// Import the AWS SDK clients
import { SQSClient } from '@aws-sdk/client-sqs';
import { S3Client } from '@aws-sdk/client-s3';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { SecretsManagerClient } from '@aws-sdk/client-secrets-manager';
import { SNSClient } from '@aws-sdk/client-sns';
import { LambdaClient } from '@aws-sdk/client-lambda';

const sqsClient = new SQSClient({});
const s3Client = new S3Client({});
const dynamoDBClient = new DynamoDBClient({});
const secretsManagerClient = new SecretsManagerClient({});
const snsClient = new SNSClient({});
const lambdaClient = new LambdaClient({});

export {
  sqsClient,
  s3Client,
  dynamoDBClient,
  secretsManagerClient,
  snsClient,
  lambdaClient,
};

// eslint-disable-next-line no-unused-vars
export async function main(event) {
  console.log('hello world');
  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Hello World' }),
  };
}
