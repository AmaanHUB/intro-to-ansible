# Introduction To Ansible

* Configuration management software that allows one to make changes to machines
	* Declarative way
	* Through "push" system (don't need Ansible on the machines on that changes are being made on)
* Platform agnostic
	* Ansible provides an abstraction layer so you should be able to run the code in any environment in any OS

## Playbooks

* Playbooks contain all the instructions that Ansible uses to hold the 'instructions' that it will run on the machines
	* Is basically a provision file
* `inventory` file contains all the `hosts`, which are the machines that the playbook will run on
	* contains the IP
	* username and ssh private key can be configured
* Testing can be built into the playbooks
