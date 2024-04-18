resource "aws_iam_policy" "DynamoDBCrudPolicy" {
  name = var.dynamodb_crud_policy_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
    Effect = "Allow",
    Action = [
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable"
    ],
    Resource = [
      var.connections_table_arn,
      "${var.connections_table_arn}/index/*"
    ]
  }]
  })
}

### Lambda resources

resource "aws_iam_role" "OnConnectRole" {
  name = "OnConnectRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "OnConnectRoleDynamoDBCrudPolicyAttachment" {
  role       = aws_iam_role.OnConnectRole.name
  policy_arn = aws_iam_policy.DynamoDBCrudPolicy.arn
}

resource "aws_iam_policy" "OnConnectCloudWatchLogsPolicy" {
  name = "OnConnectCloudWatchLogsPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "logs:CreateLogGroup",
        "Resource": "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.on_connect_function_name}:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "OnConnectRoleOnConnectCloudWatchLogsPolicyAttachment" {
  role       = aws_iam_role.OnConnectRole.name
  policy_arn = aws_iam_policy.OnConnectCloudWatchLogsPolicy.arn
  depends_on = [aws_iam_role.OnConnectRole, aws_iam_policy.OnConnectCloudWatchLogsPolicy]
}

resource "aws_iam_role" "OnDisconnectRole" {
  name = "OnDisconnectRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "OnDisconnectRoleDynamoDBCrudPolicyAttachment" {
  role       = aws_iam_role.OnDisconnectRole.name
  policy_arn = aws_iam_policy.DynamoDBCrudPolicy.arn
}

resource "aws_iam_policy" "OnDisconnectCloudWatchLogsPolicy" {
  name = "OnDisconnectCloudWatchLogsPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "logs:CreateLogGroup",
        "Resource": "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.on_disconnect_function_name}:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "OnDisconnectRoleOnDisconnectCloudWatchLogsPolicyAttachment" {
  role       = aws_iam_role.OnDisconnectRole.name
  policy_arn = aws_iam_policy.OnDisconnectCloudWatchLogsPolicy.arn
  depends_on = [aws_iam_role.OnDisconnectRole, aws_iam_policy.OnDisconnectCloudWatchLogsPolicy]
}

resource "aws_iam_role" "SendMessageRole" {
  name = "SendMessageRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "SendMessageRoleDynamoDBCrudPolicyAttachment" {
  role       = aws_iam_role.SendMessageRole.name
  policy_arn = aws_iam_policy.DynamoDBCrudPolicy.arn
}

resource "aws_iam_policy" "SendMessageCloudWatchLogsPolicy" {
  name = "SendMessageCloudWatchLogsPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "logs:CreateLogGroup",
        "Resource": "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.send_message_function_name}:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "SendMessageRoleSendMessageCloudWatchLogsPolicyAttachment" {
  role       = aws_iam_role.SendMessageRole.name
  policy_arn = aws_iam_policy.SendMessageCloudWatchLogsPolicy.arn
  depends_on = [ aws_iam_role.SendMessageRole, aws_iam_policy.SendMessageCloudWatchLogsPolicy ]
}



resource "aws_iam_policy" "SendMessageManageConnectionsPolicy" {
  name = "SendMessageManageConnectionsPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "execute-api:ManageConnections",
        "Resource": "${var.web_socket_execution_arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "SendMessageRoleSendMessageManageConnectionsPolicyAttachment" {
  role       = aws_iam_role.SendMessageRole.name
  policy_arn = aws_iam_policy.SendMessageManageConnectionsPolicy.arn
  depends_on = [aws_iam_role.SendMessageRole, aws_iam_policy.SendMessageManageConnectionsPolicy]
}
