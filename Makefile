account := mt-playground

.PHONY: ansible
ansible:
	ansible-playbook -i inventory.yaml playbook.yaml

.PHONY: ping # ping all hosts
ping:
	ansible all -m ping -i inventory.yaml

.PHONY: ping # ssh as ansible
ssh:
	ssh -i ~/.ssh/ansible-ssh ansible-ssh@ubuntu-rpi


.PHONY: identity
identity: 
	aws-vault exec $(account) -- aws sts get-caller-identity

.PHONY: init
init:
	aws-vault exec $(account) -- terraform init -chdir=infrastructure -backend-config=secret.tfvars

.PHONY: plan
plan:
	aws-vault exec $(account) -- terraform plan -chdir=infrastructure

.PHONY: apply
apply:
	aws-vault exec $(account) -- terraform apply -chdir=infrastructure

.PHONY: destroy
destroy:
	aws-vault exec $(account) -- terraform destroy -chdir=infrastructure