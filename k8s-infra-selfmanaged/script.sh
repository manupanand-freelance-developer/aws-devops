#!/bin/bash

# run the script if error
sudo rm -rf $HOME/.kube 
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo chmod 775 $HOME/.kube

sudo systemctl restart kubelet

cd /tmp

sudo kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.3/manifests/tigera-operator.yaml  --validate=false

sudo curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.3/manifests/custom-resources.yaml -O 
sudo  kubectl create -f custom-resources.yaml --validate=false

