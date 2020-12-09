# Sort out terminal
if grep -xq "export TERM=vt100" ~/.bashrc; then
	echo "Already here"
else
	echo "export TERM=vt100" >> ~/.bashrc
fi
source ~/.bashrc

# Change hostname to make more readable
sudo -i
hostnamectl set-hostname ansible-controller
exit
# neee something to reset the terminal in a way to show the new hostname here maybe

# Install Ansible
sudo apt update -y
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

# Install Python And Dependencies
sudo apt install python3-pip -y

# Install python packages, AWS CLI, boto (as dependency for)
pip3 install awscli boto boto3
