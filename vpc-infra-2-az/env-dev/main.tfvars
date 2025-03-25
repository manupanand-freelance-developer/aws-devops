vpc={
    cidr                ="10.10.0.0/16"  #/24 -256 ips
    pubic_subnets       =["10.10.0.0/24","10.10.1.0/24"]
    web_subnets         =["10.10.2.0/24","10.10.3.0/24"]
    app_subnets         =["10.10.4.0/24","10.10.5.0/24"]
    db_subnets          =["10.10.6.0/24","10.10.7.0/24"]
    availability_zones  =["ap-south-2a","ap-south-2b"]
    # providing the default vpc details for peering
    default_vpc_id      = "vpc-0a814be354897a863"
    default_vpc_rt      =   "rtb-0cf04062d48dae201"
    default_vpc_cidr    =  "172.31.0.0/16"


}
env="dev"