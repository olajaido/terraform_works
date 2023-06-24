resource "aws_eip" "eip_for_nat_gw_az1" {
    vpc = true

    tags = {
      Name = "nat-gateway-az1-eip"
    }
  
}
resource "aws_eip" "eip_for_nat_gw_az2" {
    vpc = true

    tags = {
      Name = "nat-gateway-az2-eip"
    }
  
}
resource "aws_nat_gateway" "nat_gw_az1" {
    allocation_id = aws_eip.eip_for_nat_gw_az1.id
    subnet_id = var.public_subnet_az1_id

    tags = {
        Name = "nat-gateway-az1"
    }

    depends_on = [var.internet_gateway]
  
}
resource "aws_nat_gateway" "nat_gw_az2" {
    allocation_id = aws_eip.eip_for_nat_gw_az2.id
    subnet_id = var.public_subnet_az2_id

    tags = {
      Name = "nat-gateway-az2"
    }
    depends_on = [var.internet_gateway]

    
  
}
resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
    subnet_id = var.private_app_subnet_az1_id
    route_table_id = aws_route_table.private_route_table_az1.id
  
}
resource "aws_route_table_association" "private_data_subnet_az1_route_table_az1_association" {
    subnet_id = var.private_data_subnet_az1_id
    route_table_id = aws_route_table.private_route_table_az1.id
  
}
resource "aws_route_table" "private_route_table_az1" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
    }
    tags = {
      Name = "private route-az1"
    }
  
}
resource "aws_route_table" "private_route_table_az2" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_az2.id
    }
    tags = {
      Name = "private route-az2"
    }
  
}
resource "aws_route_table_association" "private_app_subnet_az2_route_table_az2_association" {
    subnet_id = var.private_app_subnet_az2_id
    route_table_id = aws_route_table.private_route_table_az2.id

  
}
resource "aws_route_table_association" "private_data_subnet_az2_route_table_az2_association" {
    subnet_id = var.private_data_subnet_az2_id
    route_table_id = aws_route_table.private_route_table_az2.id
  
}
