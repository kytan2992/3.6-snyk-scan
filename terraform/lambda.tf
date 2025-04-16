locals {
  name_prefix = "ky-tf"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_files/lambda_function.py"
  output_path = "${path.module}/lambda_files/lambda_function.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = "${local.name_prefix}-lambdafunction"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  depends_on = [aws_iam_role_policy_attachment.cloudwatch_logs]

  tracing_config {
    mode = "Active"
  }
}

resource "aws_cloudwatch_log_group" "create_url_logs" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 7
}
