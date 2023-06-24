output "ALB_SG_id" {
    value = aws_security_group.alb_SG.id
  
}
output "ECS_SG_id" {
    value = aws_security_group.ecs_SG.id
  
}