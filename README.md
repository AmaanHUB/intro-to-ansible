# Introduction To Ansible

* Configuration management software that allows one to make changes to machines
	* Declarative way
	* Through "push" system (don't need Ansible on the machines on that changes are being made on)
* Platform agnostic
	* Ansible provides an abstraction layer so you should be able to run the code in any environment in any OS

## Introducution To Playbooks

* Playbooks contain all the instructions that Ansible uses to hold the 'instructions' that it will run on the machines
	* Is basically a provision file
* `inventory` file contains all the `hosts`, which are the machines that the playbook will run on
	* contains the IP
	* username and ssh private key can be configured
* Testing can be built into the playbooks

## Setting It Up

Setting up a controller machine in AWS. In `ansible-setup/provision.sh` is a small provision script that would automatically install ansible on the AWS EC2 instance.


## Hosts file

* Here one specifies how one connects to the machines one is trying to control, with the specific key file and the ip address etc
	* in `/etc/ansible/hosts`
```
[host_a]
172.31.45.97    ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74-amaan-aws.pem
```

* Make sure that the security group (in AWS) allows on port 22 from the `ansible-controller` IP address
* Can check if this works by using an ansible `ping` module. This can be done from the command line as well as from a playbook (which shall be done later)
```
# host_name can be 'all' to say ping every specified machine
ansible host_name -m ping
```

## Ad hoc Commands

* Can call bash commands from an ansible command
	* The command must be within quotes
```
ansible host_name -a "command"
```
* Instead of calling `sudo` in the command, one can use `--become` at the end to 'become' root
```
ansible host_name -a "command" --become
```
* Updating the ansible way (using the `apt` module)
	* Note `--become` is needed since this is operation needs root permissions
```
# can just use `apt` instead of `ansible.builtin.apt`
ansible host_name -m ansible.builtin.apt -a "upgrade=yes update_cache=yes" --become
```
