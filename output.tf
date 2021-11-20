output "api_id" {
  value = aws_apigatewayv2_api.api.id
}

output "url" {
  value = var.websocket_domain_id != "" ? aws_apigatewayv2_stage.stage.invoke_url : "wss://${format("wss://%s%s", var.websocket_domain, var.path != "" ? "/${var.path}" : "")}"
}
