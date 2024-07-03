module.exports = {
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: 'module',
  },
  env: {
    node: true,
    jest: true,
  },
  overrides: [
    {
      files: ['**.ts', '**.tsx'],
      parser: '@typescript-eslint/parser',
      plugins: ['@typescript-eslint'],
      extends: [
        'eslint:recommended',
        'plugin:@typescript-eslint/recommended',
        'plugin:prettier/recommended',
      ],
      rules: {
        'prettier/prettier': ['error', { singleQuote: true }],
      },
    },
    {
      files: ['**.js', '**.jsx'],
      extends: ['eslint:recommended'],
      rules: {
        'prettier/prettier': ['error', { singleQuote: true }],
      },
    },
  ],
};
