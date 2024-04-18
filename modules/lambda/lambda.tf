#
# Lambda function resources.
#

###########
# OnConnect
###########
data "archive_file" "OnConnectZip" {
  type        = "zip"
  source_file = "./onconnect/app.js"
  output_path = "./onconnect/app.zip"
}

resource "aws_lambda_function" "OnConnectFunction" {
  filename      = data.archive_file.OnConnectZip.output_path
  function_name = var.on_connect_function_name
  role          = var.on_connect_role_arn
  handler       = "app.handler"
  runtime       = "nodejs16.x"
  memory_size   = 256

  environment {
    variables = {
      TABLE_NAME = var.connections_table_name
    }
  }
}

resource "aws_lambda_permission" "OnConnectPermission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.OnConnectFunction.function_name
  principal     = "apigateway.amazonaws.com"
}


##############
# OnDisconnect
##############
data "archive_file" "OnDisconnectZip" {
  type        = "zip"
  source_file = "./ondisconnect/app.js"
  output_path = "./ondisconnect/app.zip"
}

resource "aws_lambda_function" "OnDisconnectFunction" {
  filename      = data.archive_file.OnDisconnectZip.output_path
  function_name = var.on_disconnect_function_name
  role          = var.on_disconnect_role_arn
  handler       = "app.handler"
  runtime       = "nodejs16.x"
  memory_size   = 256

  environment {
    variables = {
      TABLE_NAME = var.connections_table_name
    }
  }
}

resource "aws_lambda_permission" "OnDisconnectPermission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.OnDisconnectFunction.function_name
  principal     = "apigateway.amazonaws.com"
}


#############
# SendMessage
#############
data "archive_file" "SendMessageZip" {
  type        = "zip"
  source_file = "./sendmessage/app.js"
  output_path = "./sendmessage/app.zip"
}

resource "aws_lambda_function" "SendMessageFunction" {
  filename      = data.archive_file.SendMessageZip.output_path
  function_name = var.send_message_function_name
  role          = var.send_message_role_arn
  handler       = "app.handler"
  runtime       = "nodejs16.x"
  memory_size   = 256

  environment {
    variables = {
      TABLE_NAME = var.connections_table_name
    }
  }
}

resource "aws_lambda_permission" "SendMessagePermission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.SendMessageFunction.function_name
  principal     = "apigateway.amazonaws.com"
}

