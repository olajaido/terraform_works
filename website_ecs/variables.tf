# enviroment Variables
variable "region" {
  // region = "eu-west-2"



}
variable "project_name" {
  //  project_name = "VPC Module"

}


# VPC variables
variable "vpc_cidr" {
  // cidr_block = "10.15.0.0/16"



}
variable "public_subnet_az1_cidr" {
  // cidr_block = "10.15.2.0/24"

}
variable "public_subnet_az2_cidr" {
  // cidr_block = "10.15.3.0/24"

}
variable "private_app_subnet_az1_cidr" {
  //  cidr_block = "10.15.4.0/24"

}
variable "private_app_subnet_az2_cidr" {
  //  cidr_block = "10.15.5.0/24"

}
variable "private_data_subnet_az1_cidr" {
  //   cidr_block = "10.15.6.0/24"

}
variable "private_data_subnet_az2_cidr" {
  //  cidr_block = "10.15.7.0/24"

}
variable "domain_name" {
      
}
variable "alternative_name" {
  
}
variable "container_image" {
  
}