FROM python:3.8-slim-buster
COPY soak.py .
RUN pip install boto3 requests
ENTRYPOINT ["python", "-u", "soak.py"]