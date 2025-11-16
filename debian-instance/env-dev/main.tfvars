env             ="dev"
vpc_name        ="default_vpc_south2"
subnet_name     ="default-ap-south-2c"
ami_id          ="ami-0e7938ad51d883574"



ec2_instance={
    ubuntu-lab={
        instance_type ="t3.medium"
        volume_size   =50
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
            }
    }
}