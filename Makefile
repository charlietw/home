account := personal-terraform

.PHONY: setup
setup:
	ansible-playbook -i ansible/inventory.yaml ansible/setup.yaml

.PHONY: update
update:
	ansible-playbook -i ansible/inventory.yaml ansible/update.yaml

.PHONY: ping # ping all hosts
ping:
	ansible all -m ping -i ansible/inventory.yaml

.PHONY: ping # ssh as ansible
ssh:
	ssh -i ~/.ssh/ansible-ssh ansible-ssh@ubuntu-rpi


.PHONY: identity
identity: 
	aws-vault exec $(account) -- aws sts get-caller-identity

.PHONY: init
init:
	aws-vault exec $(account) -- terraform -chdir=infrastructure init -backend-config=secrets.tfvars

.PHONY: plan
plan:
	aws-vault exec $(account) -- terraform -chdir=infrastructure plan 

.PHONY: apply
apply:
	aws-vault exec $(account) -- terraform -chdir=infrastructure apply 

.PHONY: destroy
destroy:
	aws-vault exec $(account) -- terraform -chdir=infrastructure destroy 