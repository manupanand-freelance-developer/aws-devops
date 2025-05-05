env             ="dev"
vpc_name        ="default_vpc_south2"
subnet_name     ="default-ap-south-2c"
ami_id          ="ami-0e86c549c4c958e98"



ec2_instance={
    server={
        instance_type ="t3.medium"
        volume_size   =10
        server_port={
                ssh={
                    port="22"
                }
            }
    }
}