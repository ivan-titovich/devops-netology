resource "null_resource" "supplementary_addresses" {
  provisioner "local-exec" {
    command = "echo 'supplementary_addresses_in_ssl_keys: [ ${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address} ]' >> ../playbook/k8s/inventory/k8s-cluster.yml"
  }


resource "local_file" "script" {
  content = <<-DOC
    #!/bin/sh
    ansible-playbook -i ./playbook/k8s/inventory/prod.yml ./playbook/k8s/prepare.yml
    sleep 10
    ssh ubuntu@${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address} 'export ANSIBLE_CONFIG=/home/ubuntu/kubespray/ansible.cfg; ansible-playbook -i /home/ubuntu/kubespray/inventory/mycluster/hosts.yaml /home/ubuntu/kubespray/cluster.yml -b -v'
    sleep 10
    ansible-playbook -i ./playbook/k8s/inventory/prod.yml ./playbook/k8s/get-kubeconfig.yml
    sleep 10
    sed -i -e 's,server: https://127.0.0.1:6443,server: https://${yandex_compute_instance.vm_for_each["kuber-master01.netology.yc"].network_interface.0.nat_ip_address}:6443,g'  ~/.kube/config
    sleep 10
    # Download the binary for your system
    sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

    # Give it permission to execute
    sudo chmod +x /usr/local/bin/gitlab-runner

    # Create a GitLab Runner user
    sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

    # Install and run as a service
    sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
    sudo gitlab-runner start
    DOC
  filename = "../install"

  depends_on = [
    null_resource.supplementary_addresses
  ]
}

resource "null_resource" "chmod" {
  provisioner "local-exec" {
    command = "chmod 755 ../install"
  }
  depends_on = [
    local_file.script
  ]
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 100"
  }

  depends_on = [
    null_resource.chmod
  ]
}