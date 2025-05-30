# vpc
env="dev"
vpc_name     ="dev-private-vpc"
subnet_name  ="dev-kube-subnet"

#eks

eks={
    eks_version  = "1.33" 
    node_groups={
        
        main_spot={
            instance_types      =["t4g.medium"]
            max_size            = 3
            min_size            = 1 
            capacity_type       = "SPOT"
            ami_type            ="AL2023_ARM_64_STANDARD"
        }
    }
    # aws eks describe-addon-versions command |grep addonName
    add_ons={
        vpc-cni={
            cni_version="v1.1.8"
        }
    }
}
