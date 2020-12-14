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
pip3 install boto boto3
# installs latest version of aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# set python3 as default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 20
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 10
