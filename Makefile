account := personal-terraform

# Ansible commands

.PHONY: setup
setup:
	ansible-playbook -i ansible/inventory.yaml ansible/setup.yaml

.PHONY: restart
restart:
	ansible-playbook -i ansible/inventory.yaml ansible/restart.yaml

.PHONY: update
update:
	ansible-playbook -i ansible/inventory.yaml ansible/update.yaml

.PHONY: backup
backup:
	ansible-playbook -i ansible/inventory.yaml ansible/backup.yaml

.PHONY: restore
restore:
	ansible-playbook -i ansible/inventory.yaml ansible/restore.yaml

.PHONY: influxdb-setup
influxdb-setup:
	ansible-playbook -i ansible/inventory.yaml ansible/influxdb/setup.yaml

.PHONY: ping # ping all hosts
ping:
	ansible all -m ping -i ansible/inventory.yaml

.PHONY: ssh # ssh as ansible
ssh:
	ssh -i ~/.ssh/ansible-ssh ansible-ssh@ubuntu-rpi


# Terraform commands

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