# Using These Playbooks

* Copy this repository with `git clone`
* In`/etc/ansible/hosts` at the very end add:
```
[app_server]
private_ip_of_app_server ansible_ssh_private_key_file=/private/ssh/key/location

[db_server]
private_ip_of_db_server ansible_ssh_private_key_file=/private/ssh/key/location
```
* Make sure the relevant ports are open in the firewall:
	* 22 for the ansible-controller
	* 27017 from the db_server
	* 80 from the app_server
	* Maybe some more depending on your use case
* Run either the two playbooks separately
```
ansible-playbook playbook_db_server.yaml

ansible-playbook_app_server.yaml
```
* Or you can run them both with the master playbook `main.yaml`:
```
ansible-playbook main.yaml
```

