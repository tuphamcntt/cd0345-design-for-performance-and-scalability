terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["C:\\Users\\tupm2\\.aws\\credentials"]
}

# Create IAM role
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}

data "archive_file" "greet_lambda" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}

resource "aws_lambda_function" "greet_lambda" {
  function_name    = "greet_lambda"
  filename         = data.archive_file.greet_lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.greet_lambda.output_path)
  role             = aws_iam_role.lambda_exec.arn
  handler          = "greet_lambda.lambda_handler"
  runtime          = "python3.8"

  environment {
    variables = {
      greeting = "TuPM2"
    }
  }
}