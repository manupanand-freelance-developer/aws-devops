module "security_group" {
  source          = "./modules/security-group"
  for_each        = var.ec2_instance
  vpc_name        = var.vpc_name
  subnet_name     = var.subnet_name
  name            = each.key
  ingress_ports   = each.value["server_port"] 
}

# module "iam_role" {
#   source          = "./modules/iam-rule"
# }

# module "ec2_instance" {
  
#   source            = "./modules/ec2"
#   for_each          = var.ec2_instance
#   env               = var.env
#   name              = each.key
#   instance_type     = each.value["instance_type"]
#   volume_size       = each.value["volume_size"] 
#   ami_id            = var.ami_id
#   subnet_id         = 
#   security_group_id = module.security_group.security_group_id

# }