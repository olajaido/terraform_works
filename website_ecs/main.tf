# Configure aws provider
provider "aws" {
  region  = var.region
  profile = "vscode"


}
# Create VPC
module "vpc" {
  source                       = "../vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr



}
# Create NAT Gateway
module "nat_gateway" {
  source                     = "../nat gateway"
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id


}
module "security_group" {
  source = "../security groups"
  vpc_id = module.vpc.vpc_id
  
}
module "ecs_task_exec_role" {
  source = "../ecs task execution"
  project_name = module.vpc.project_name
  
}
module "acm" {
  source = "../acm"
  domain_name = var.domain_name
  alternative_name = var.alternative_name
  
}
module "alb" {
  source = "../alb"
  project_name = module.vpc.project_name
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  vpc_id = module.vpc.vpc_id
  certificate_arn = module.acm.certificate_arn
  ALB_SG_id = module.security_group.ALB_SG_id
}
module "ecs" {
  source = "../ecs"
  project_name = module.vpc.project_name
  ecs_task_exec_role_arn = module.ecs_task_exec_role.ecs_task_exec_role_arn
  container_image = var.container_image
  region = module.vpc.region
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
  ECS_SG_id = module.security_group.ECS_SG_id
  alb_target_group_arn = module.alb.alb_target_group_arn
  
}
