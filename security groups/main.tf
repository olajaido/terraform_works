resource "aws_security_group" "alb_SG" {
    name = "ALB SG"
    description = "Allow access on port 40/443"
    vpc_id = var.vpc_id

    ingress {
        description = "http Access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    ingress {
        description = "https Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    tags = {
      Name = "ALB_SG"
    }
  
}
resource "aws_security_group" "ecs_SG" {
    name = "ECS SG"
    description = "Allow access on port 40/443"
    vpc_id = var.vpc_id

    ingress {
        description = "https Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = [aws_security_group.alb_SG.id]
        
    }
    ingress {
        description = "http Access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = [aws_security_group.alb_SG.id]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    tags = {
      Name = "ECS_SG"
    }
  
}
  
