resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
      Name = "${var.project_name}-vpc"
    }
  
}
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "${var.project_name}-igw"
    }
  
}
data "aws_availability_zones" "availability_zone" {
 // state = "availability_zone"
  
}
    
  
  

resource "aws_subnet" "pub_sub_az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_az1_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[0]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-public-az1"
    }

  
}
resource "aws_subnet" "pub_sub_az2" {
    cidr_block = var.public_subnet_az2_cidr
    vpc_id = aws_vpc.vpc.id
    availability_zone = data.aws_availability_zones.availability_zone.names[1]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-pubblic-az2"
    }
  
}
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.vpc.id

    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id

    }
    tags = {
      Name = "${var.project_name}-public-rt"
    }
  
}
resource "aws_route_table_association" "pub-sub-az1" {
    subnet_id = aws_subnet.pri_app_sub-az1.id
    route_table_id = aws_route_table.pub_rt.id
  
}
resource "aws_route_table_association" "pub-sub-az2" {
    subnet_id = aws_subnet.pub_sub_az2.id
    route_table_id = aws_route_table.pub_rt.id


     
}
resource "aws_subnet" "pri_app_sub-az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_app_subnet_az1_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[0]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-pri-app-az1"
    }
  
}
resource "aws_subnet" "pri_app_sub-az2" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_app_subnet_az2_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[1]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-pri-app-az2"
    }
  
}
resource "aws_subnet" "pri_data_sub-az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_data_subnet_az1_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[0]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-pri-data-az1"
    }
  
}
resource "aws_subnet" "pri_data_sub-az2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_data_subnet_az2_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[1]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-pri-data-az2"
    }
  
}