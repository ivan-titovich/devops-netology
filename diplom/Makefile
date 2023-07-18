ENV?=stage


all: init workspace plan apply

reconf: init set_workspace plan apply


cleanup: destroy clean

init:
	cd ./terraform && terraform init

workspace:
	cd ./terraform && terraform workspace new ${ENV}

set_workspace:
	cd ./terraform && terraform workspace select ${ENV}

plan: set_workspace
	cd ./terraform && terraform plan

apply: set_workspace
	cd ./terraform && terraform apply -auto-approve

destroy: set_workspace
	cd ./terraform && terraform destroy -auto-approve

clean:
	cd ./terraform && terraform workspace select default && terraform workspace delete ${ENV}
	cd ./terraform &&  rm -f .terraform.lock.hcl
	cd ./terraform &&  rm -f terraform.tfplan
	cd ./terraform &&  rm -fr terraform.tfstate*
	cd ./terraform &&  rm -fr .terraform/
