resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.lambda_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

// Build lambda and install packages
resource "null_resource" "build_lambda" {
  provisioner "local-exec" {
    environment = {
      SRC_DIR_ENV         = var.lambda_source_dir
      LAMBDA_SRC_DIR_PATH = var.lambda_source_path
      BINARY_URL          = var.lambda_llrt_url
    }
    command = "${path.module}/../../scripts/build.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_lambda_function" "this" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = var.lambda_handler_location
  runtime       = "provided.al2023"
  architectures = [ "arm64" ]
  memory_size   = 128
  timeout       = 30

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${var.lambda_source_dir}/dist"
  output_path = "${path.module}/.tmp/lambda.zip"

  depends_on = [null_resource.build_lambda]
}

// Cleanup lambda packages
resource "null_resource" "cleanup_lambda" {
  provisioner "local-exec" {
    environment = {
      SRC_DIR_ENV         = var.lambda_source_dir
      LAMBDA_SRC_DIR_PATH = var.lambda_source_path
      BINARY_URL          = var.lambda_llrt_url
    }
    command = "${path.module}/../../scripts/cleanup.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [data.archive_file.lambda_zip]
}

