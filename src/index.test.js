import { main } from './index';
import { jest } from '@jest/globals';

jest.mock('@aws-lambda-powertools/logger', () => {
  return {
    Logger: jest.fn().mockImplementation(() => {
      return {
        debug: jest.fn(),
        info: jest.fn(),
        error: jest.fn(),
      };
    }),
  };
});

describe('main handler', () => {
  it('should return a 200 status code and a Hello World message', async () => {
    const event = {
      body: null,
      headers: {},
      httpMethod: 'POST',
      isBase64Encoded: false,
      path: '/',
      pathParameters: null,
      queryStringParameters: null,
      multiValueQueryStringParameters: null,
      stageVariables: null,
      requestContext: {
        accountId: '123456789012',
        apiId: '1234567890',
        authorizer: null,
        protocol: 'HTTP/1.1',
        httpMethod: 'POST',
        identity: {
          accessKey: null,
          accountId: null,
          apiKey: null,
          apiKeyId: null,
          caller: null,
          cognitoAuthenticationProvider: null,
          cognitoAuthenticationType: null,
          cognitoIdentityId: null,
          cognitoIdentityPoolId: null,
          sourceIp: '127.0.0.1',
          userArn: null,
          userAgent: 'jest-test',
          user: null,
          clientCert: null,
          principalOrgId: null,
        },
        path: '/',
        stage: 'test',
        requestId: 'test-id',
        requestTimeEpoch: 0,
        resourceId: 'test-resource',
        resourcePath: '/',
      },
      resource: '/',
      multiValueHeaders: {},
    };

    const context = {
      callbackWaitsForEmptyEventLoop: false,
      functionName: 'test-function',
      functionVersion: '$LATEST',
      invokedFunctionArn:
        'arn:aws:lambda:us-east-1:123456789012:function:test-function',
      memoryLimitInMB: '128',
      awsRequestId: 'test-request-id',
      logGroupName: '/aws/lambda/test-function',
      logStreamName: '2020/11/11/[$LATEST]abcdef1234567890abcdef',
      getRemainingTimeInMillis: () => 3000,
      done: () => {},
      fail: () => {},
      succeed: () => {},
    };

    const result = await main(event, context, () => {});

    expect(result.statusCode).toBe(200);
    expect(JSON.parse(result.body)).toEqual({ message: 'Hello World' });
  });
});
