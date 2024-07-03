const esbuild = require('esbuild');

esbuild.build({
  entryPoints: ['src/service-a/post/handler.js'],
  outfile: 'src/service-a/post/dist/index.mjs',
  bundle: true,
  minify: true,
  sourcemap: true,
  target: 'es2020',
  platform: 'node',
  treeShaking: true,
  format: 'esm',
  external: [
    '@aws-sdk/client-cloudwatch-events',
    '@aws-sdk/client-cloudwatch-logs',
    '@aws-sdk/client-cognito-identity',
    '@aws-sdk/client-dynamodb',
    '@aws-sdk/client-eventbridge',
    '@aws-sdk/client-kms',
    '@aws-sdk/client-lambda',
    '@aws-sdk/client-s3',
    '@aws-sdk/client-secrets-manager',
    '@aws-sdk/client-ses',
    '@aws-sdk/client-sfn',
    '@aws-sdk/client-sns',
    '@aws-sdk/client-sqs',
    '@aws-sdk/client-ssm',
    '@aws-sdk/client-sts',
    '@aws-sdk/client-xray',
    '@aws-sdk/credential-providers',
    '@aws-sdk/lib-dynamodb',
    '@aws-sdk/s3-request-presigner',
    '@aws-sdk/util-dynamodb',
    '@smithy',
    'uuid',
  ],
  // nodePaths: ['./node_modules'],

  // plugins: [
  //   {
  //     name: 'node-modules',
  //     setup(build) {
  //       build.onResolve({ filter: /^@aws-sdk\/client-rds-data$/ }, args => {
  //         return { path: require.resolve(args.path, { paths: [args.resolveDir] }) };
  //       });
  //       build.onResolve({ filter: /^aws-xray-sdk$/ }, args => {
  //         return { path: require.resolve(args.path, { paths: [args.resolveDir] }) };
  //       });
  //     },
  //   },
  // ],
}).catch(() => process.exit(1));
