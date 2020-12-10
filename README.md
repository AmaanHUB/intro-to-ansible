# Introduction To Ansible

* Configuration management software that allows one to make changes to machines
	* Declarative way
	* Through "push" system (don't need Ansible on the machines on that changes are being made on)
* Platform agnostic
	* Ansible provides an abstraction layer so you should be able to run the code in any environment in any OS


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

## Introducution To Playbooks

* Playbooks contain all the instructions that Ansible uses to hold the 'instructions' that it will run on the machines
	* Is basically a provision file
* `inventory` file contains all the `hosts`, which are the machines that the playbook will run on
	* contains the IP
	* username and ssh private key can be configured
* Testing can be built into the playbooks

### Writing A Playbooks

* Structure:
* Running it:
```
ansible-playbook playbook.yaml
```
* Install packages
```yaml
# can install multiple packages with `pkg`
    - name: Install packages
      apt:
        pkg:
          - package_1
          - package_2
          - package_3
          - package_4
        state: present
```
* NPM package installation
```yaml
    - name: Install pm2
      npm:
        name: pm2
        global: yes
```
* Create/remove file
```yaml
#  remove nginx default file
	- name: Remove nginx default file
	  file:
	    path: /etc/nginx/sites-enabled/default
  	    state: absent

# create a file
	- name: Create a file in sites-available
	  file:
	    path: /etc/sites-available/reverse_proxy.conf
		state: touch
		mode: '755'

# write into a file
	- name: Write into a file
	  blockinfile:
	    path: /etc/nginx/sites-available/reverse_proxy.conf
		block: |
server {

	listen 80;

	location / {

		proxy_pass http://127.0.0.1:3000;
		proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;

	}

}

# symlink
	- name: create sym link for sites-enabled and sites-available
	  file:
	    path: /etc/nginx/sites-available/reverse_proxy.conf
		dest: /etc/nginx/sites-enabled/
		state: link

```
* How to run shell commands

*  Running services can be done with the `service` module or a handler
```yaml
	- name: service usage
	  service:
	    name: nginx
		state: started

	- name: some task
	  file:
	    path: /etc/nginx/sites-available/reverse_proxy.conf
		dest: /etc/nginx/sites-enabled/
		state: link
	  notify:
	  	- Restart nginx

	handlers:
		- name: Restart nginx
		  service:
		  	name: nginx
			state: restarted
```
* N.B. Handlers can be after the task

* Templates
* Shell commands
