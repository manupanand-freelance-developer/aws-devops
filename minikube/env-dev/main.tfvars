env             ="dev"
vpc_name        ="default_vpc_south2"
subnet_name     ="default-ap-south-2c"
ami_id          ="ami-0e86c549c4c958e98"
zone_id         ="Z02556032JV56RSCGA16T"



ec2_instance={
    minikube={
        instance_type ="t3.medium"
        volume_size   =30
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
                  kubeapi={
                    port="8443"
                }
                 http={
                    port="80"
                }
                 https={
                    port="443"
                }
                node={
                    port="30000-32767"
                }
            }
    }
}