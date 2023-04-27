all:
    apply

apply:
    terraform apply -auto-approve

destroy:
    terraform destroy -auto-approve

clean:
    rm -fr .terraform
    rm -fr .terraform.lock.hcl
    rm -fr terraform.tfstate
    rm -fr terraform.tfstate.backup
