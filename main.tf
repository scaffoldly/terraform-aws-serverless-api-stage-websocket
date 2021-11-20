resource "aws_apigatewayv2_api" "api" {
  name                       = "${var.repository_name}-${var.stage}"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
  tags                       = {}
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id = aws_apigatewayv2_api.api.id
  name   = var.stage

  access_log_settings {
    destination_arn = var.logs_arn
    format          = "$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] \"$context.eventType $context.routeKey $context.connectionId\" $context.status  $context.requestId"
  }

  default_route_settings {
    data_trace_enabled       = true
    detailed_metrics_enabled = true
    logging_level            = "INFO"
  }

  lifecycle {
    ignore_changes = [
      deployment_id
    ]
  }
}

resource "aws_apigatewayv2_api_mapping" "mapping" {
  count = var.domain != "" ? 1 : 0

  api_id          = aws_apigatewayv2_api.api.id
  domain_name     = var.domain
  stage           = aws_apigatewayv2_stage.stage.id
  api_mapping_key = var.path
}
