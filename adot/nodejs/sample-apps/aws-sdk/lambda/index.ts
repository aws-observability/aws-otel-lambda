import {
  APIGatewayProxyEvent,
  APIGatewayProxyResult,
  Context,
} from 'aws-lambda';

import { STSClient, GetCallerIdentityCommand } from '@aws-sdk/client-sts';

const sts = new STSClient({});

export const handler = async (
  event: APIGatewayProxyEvent,
  _context: Context,
): Promise<APIGatewayProxyResult> => {
  console.log('Received event:', JSON.stringify(event, null, 2));
  console.log('Received context:', JSON.stringify(_context, null, 2));

  try {
    // Make an instrumented AWS SDK call so the emitted trace contains an
    // STS GetCallerIdentity segment (asserted by the soak trace validator).
    await sts.send(new GetCallerIdentityCommand({}));

    // The soak trace validator extracts the X-Ray trace ID from the HTTP
    // response body (see the go and python sample apps, which return
    // `_X_AMZN_TRACE_ID`). Returning the caller-identity payload instead
    // leaves the validator with no trace ID (`trace_id=null`) and it can
    // never fetch the trace. Return the trace header so validation can run.
    return {
      statusCode: 200,
      body: JSON.stringify(process.env._X_AMZN_TRACE_ID ?? ''),
    };
  } catch (error) {
    console.error('Error retrieving caller identity:', error);
    return {
      statusCode: 500,
      body: 'Internal Server Error',
    };
  }
};
