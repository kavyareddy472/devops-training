#! /bin/bash

sudo yum install git -y
# sudo yum install maven -y
# sudo yum install java-1.8.0-openjdk-devel -y 
sudo yum install docker -y
sudo systemctl start docker

if [ -d "devops-training" ]
then
   echo "repo is already cloned and exists"
   cd /home/ec2-user/devops-training
   git pull origin feature/ssh
else
   git clone https://github.com/kavyareddy472/devops-training.git
   cd devops-training
   git checkout feature/ssh
fi

# export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-1.amzn2.0.1.x86_64
# export PATH=$JAVA_HOME/bin:$PATH
# source /etc/profile
# mvn package

sudo docker build -t $1:$2 /home/ec2-user/devops-training