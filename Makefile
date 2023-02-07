.PHONY: ansible
ansible:
	ansible-playbook -i inventory.yaml playbook.yaml

.PHONY: ping # ping all hosts
ping:
	ansible all -m ping -i inventory.yaml

.PHONY: ping # ssh as ansible
ssh:
	ssh -i ~/.ssh/ansible-ssh ansible-ssh@ubuntu-rpi