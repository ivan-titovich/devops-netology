ENV?=stage
#prod

all: init workspace plan apply

reconf: init set_workspace plan apply
#pause deploy

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
#
#pause:
#	echo "Wait for 60 seconds stupid Yandex Cloud creating a VM's..."
#	sleep 60
#	echo "May be created? Ok, run an ansible playbook..."
#deploy:
#	cd ./ansible && . ./.env.news-app && ansible-playbook -i inventory/demo site.yml
#
#reconfig:
#	cd ./ansible && . ./.env.news-app && ansible-playbook -i inventory/demo site.yml -t config