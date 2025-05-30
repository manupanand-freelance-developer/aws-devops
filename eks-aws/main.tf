module "eks" {
  source            = "./modules/eks"
  env               = var.env 
  vpc_name          = var.vpc_name 
  subnet_name       = var.subnet_name   
}

