import boto3
import getopt
from threading import Thread
import os
import sys
import time
import requests

# Alarm flag, False means no Alarm
state = False

# LambdaInsight layer ARNs, suppose we run soak test only in these regions
lambdaInsightArnMap = {}
lambdaInsightArnMap[
    "us-east-1"
] = "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:14"
lambdaInsightArnMap[
    "us-east-2"
] = "arn:aws:lambda:us-east-2:580247275435:layer:LambdaInsightsExtension:14"
lambdaInsightArnMap[
    "us-west-1"
] = "arn:aws:lambda:us-west-1:580247275435:layer:LambdaInsightsExtension:14"
lambdaInsightArnMap[
    "us-west-2"
] = "arn:aws:lambda:us-west-2:580247275435:layer:LambdaInsightsExtension:14"


def enableLambdaInsight(function_name):
    lambdaClient = boto3.client("lambda")
    lambdaInsightLayerArn = lambdaInsightArnMap[boto3.Session().region_name]
    response = lambdaClient.get_function_configuration(FunctionName=function_name)
    print("Lambda function has layers: {}".format(response["Layers"]))

    arnList = []
    for item in response["Layers"]:
        arn = item["Arn"]
        arnList.append(arn)
        if arn == lambdaInsightLayerArn:
            print("LambdaInsight has been enabled, no need enable again.")
            return
    arnList.append(lambdaInsightLayerArn)

    lambdaClient.update_function_configuration(
        FunctionName=function_name, Layers=arnList
    )
    response = lambdaClient.get_function_configuration(FunctionName=function_name)
    print("Enable LambdaInsight {}".format(response["Layers"]))


def parse_args():
    # default setting
    _soaking_time, _emitter_interval, _cpu_threshold, _memory_threshold = 600, 5, 60, 45
    argument_list = sys.argv[1:]
    short_options = "i:t:e:n:c:m:"
    long_options = [
        "interval=",
        "time=",
        "endpoint=",
        "name=",
        "cpu-threshold=",
        "memory-threshold=",
    ]

    try:
        arguments, values = getopt.getopt(argument_list, short_options, long_options)
    except getopt.error as err:
        print(str(err))
        sys.exit(2)

    for current_argument, current_value in arguments:
        if current_argument in ("-i", "--interval"):
            _emitter_interval = int(current_value)
        elif current_argument in ("-t", "--time"):
            _soaking_time = int(current_value)
        elif current_argument in ("-e", "--endpoint"):
            _endpoint = current_value
        elif current_argument in ("-n", "--name"):
            _name = current_value
        elif current_argument in ("-c", "--cpu-threshold"):
            _cpu_threshold = int(current_value)
        elif current_argument in ("-m", "--memory-threshold"):
            _memory_threshold = int(current_value)

    print(
        (
            "Soak test gets started on Lambda function: %s\n"
            "endpoint:\t%s\n"
            "soak time:\t%s sec\n"
            "invoke interval:\t%s sec\n"
            "alarm cpu threshold:\t%s ns\n"
            "alarm memory threshold:\t%s%%"
        )
        % (
            _name,
            _endpoint,
            _soaking_time,
            _emitter_interval,
            _cpu_threshold,
            _memory_threshold,
        )
    )

    return (
        _name,
        _endpoint,
        _soaking_time,
        _emitter_interval,
        _cpu_threshold,
        _memory_threshold,
    )


def invoke_lambda(interval, endpoint):
    while True:
        print(requests.get(endpoint).text)
        time.sleep(interval)


def alarm_puller(function_name, cpu_threshold, memory_threshold):
    global state

    # Memory alarm
    cloudwatch.put_metric_alarm(
        AlarmName=memory_alarm,
        ActionsEnabled=True,
        OKActions=[],
        AlarmActions=[],
        InsufficientDataActions=[],
        MetricName="memory_utilization",
        Namespace="LambdaInsights",
        Statistic="Maximum",
        Dimensions=[
            {"Name": "function_name", "Value": function_name},
        ],
        Period=60,
        EvaluationPeriods=5,
        DatapointsToAlarm=3,
        Threshold=memory_threshold,
        ComparisonOperator="GreaterThanThreshold",
        TreatMissingData="notBreaching",
    )

    # CPU alarm
    cloudwatch.put_metric_alarm(
        AlarmName=cpu_alarm,
        ActionsEnabled=True,
        OKActions=[],
        AlarmActions=[],
        InsufficientDataActions=[],
        MetricName="cpu_total_time",
        Namespace="LambdaInsights",
        Statistic="Maximum",
        Dimensions=[
            {"Name": "function_name", "Value": function_name},
        ],
        Period=60,
        EvaluationPeriods=5,
        DatapointsToAlarm=3,
        Threshold=cpu_threshold,
        ComparisonOperator="GreaterThanThreshold",
        TreatMissingData="notBreaching",
    )

    paginator = cloudwatch.get_paginator("describe_alarms")

    while True:
        for response in paginator.paginate(AlarmNames=[memory_alarm, cpu_alarm]):
            for alarm in response["MetricAlarms"]:
                print("{} state {}".format(alarm["AlarmName"], alarm["StateValue"]))
                if alarm["StateValue"] == "ALARM":
                    state = True
                    return

        time.sleep(60)


if __name__ == "__main__":
    (
        function_name,
        endpoint,
        soaking_time,
        emitter_interval,
        cpu_threshold,
        memory_threshold,
    ) = parse_args()

    # Enable LambdaInsight
    enableLambdaInsight(function_name)

    # Set alarm name
    memory_alarm = "otel_lambda_memory-" + function_name
    cpu_alarm = "otel_lambda_cpu-" + function_name

    cloudwatch = boto3.client("cloudwatch")

    # emitter thread
    Thread(
        target=invoke_lambda,
        name="emitter",
        args=(
            emitter_interval,
            endpoint,
        ),
        daemon=True,
    ).start()

    alarm_thread = Thread(
        target=alarm_puller,
        name="alarm_puller",
        args=(function_name, cpu_threshold, memory_threshold),
        daemon=True,
    )
    alarm_thread.start()
    alarm_thread.join(soaking_time)

    # if alarm
    if state:
        print("Soaking test failed!")
        exit(1)
    else:
        print("Soaking test succeed!")
        # Delete alarm if no alarm fired
        cloudwatch.delete_alarms(AlarmNames=[memory_alarm, cpu_alarm])
        exit(0)
