resource "aws_api_gateway_rest_api" "api" {
  name = var.api_gateway_name
}

resource "aws_api_gateway_resource" "coffee" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "coffee"
}

resource "aws_api_gateway_resource" "coffee_item" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.coffee.id
  path_part   = "{coffee_name}"
}

resource "aws_api_gateway_method" "coffee_methods" {
  for_each      = { for k, v in var.lambda_methods : k => v if k == "GET" || k == "POST" }
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.coffee.id
  http_method   = each.key
  authorization = "NONE"
}

resource "aws_api_gateway_method" "item_methods" {
  for_each      = { for k, v in var.lambda_methods : k => v if k == "PUT" || k == "DELETE" }
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.coffee_item.id
  http_method   = each.key
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "coffee_integration" {
  for_each                = aws_api_gateway_method.coffee_methods
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.coffee.id
  http_method             = each.value.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_methods[each.key]}/invocations"
}

resource "aws_api_gateway_integration" "item_integration" {
  for_each                = aws_api_gateway_method.item_methods
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.coffee_item.id
  http_method             = each.value.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_methods[each.key]}/invocations"
}

# OPTIONS for /coffee
resource "aws_api_gateway_method" "options_coffee" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.coffee.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_coffee" {
  depends_on = [aws_api_gateway_method.options_coffee]

  rest_api_id          = aws_api_gateway_rest_api.api.id
  resource_id          = aws_api_gateway_resource.coffee.id
  http_method          = "OPTIONS"
  type                 = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_coffee_response" {
  depends_on = [aws_api_gateway_method.options_coffee]

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.coffee.id
  http_method = "OPTIONS"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_coffee_response" {
  depends_on = [aws_api_gateway_integration.options_coffee]

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.coffee.id
  http_method = "OPTIONS"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST,GET,PUT,DELETE'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  response_templates = {
    "application/json" = ""
  }
}

# OPTIONS for /coffee/{coffee_name}
resource "aws_api_gateway_method" "options_item" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.coffee_item.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_item" {
  depends_on = [aws_api_gateway_method.options_item]

  rest_api_id          = aws_api_gateway_rest_api.api.id
  resource_id          = aws_api_gateway_resource.coffee_item.id
  http_method          = "OPTIONS"
  type                 = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_item_response" {
  depends_on = [aws_api_gateway_method.options_item]

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.coffee_item.id
  http_method = "OPTIONS"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_item_response" {
  depends_on = [aws_api_gateway_integration.options_item]

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.coffee_item.id
  http_method = "OPTIONS"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST,GET,PUT,DELETE'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  response_templates = {
    "application/json" = ""
  }
}

# ✅ Correct Lambda permissions per method + path
resource "aws_lambda_permission" "allow_get" {
  statement_id  = "AllowInvoke-GET"
  action        = "lambda:InvokeFunction"
  function_name = "get_coffee"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/GET/coffee"
}

resource "aws_lambda_permission" "allow_post" {
  statement_id  = "AllowInvoke-POST"
  action        = "lambda:InvokeFunction"
  function_name = "post_coffee"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/POST/coffee"
}

resource "aws_lambda_permission" "allow_put" {
  statement_id  = "AllowInvoke-PUT"
  action        = "lambda:InvokeFunction"
  function_name = "put_coffee"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/PUT/coffee/*"
}

resource "aws_lambda_permission" "allow_delete" {
  statement_id  = "AllowInvoke-DELETE"
  action        = "lambda:InvokeFunction"
  function_name = "delete_coffee"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/DELETE/coffee/*"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.coffee_integration,
    aws_api_gateway_integration.item_integration,
    aws_api_gateway_integration.options_coffee,
    aws_api_gateway_integration.options_item
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  description = "Coffee API deployment - ${timestamp()}"
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
  stage_name    = var.api_stage_name
}
