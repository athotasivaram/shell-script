#!/bin/bash

USERID=$(id -u)

VALIDATE (){
if [ $1 -ne 0 ]; then
    echo "$2 ...FAILURE"
	exit 1
else
     echo "$2 ...SUCCESS"
fi
}

if [ $USERID -ne 0 ]; then
   echo "must be root user"
   exit 1
fi

yum update -y 

VALIDATE $? "update yum"

yum install git -y

VALIDATE $? "install git"

sudo amazon-linux-extras install java-openjdk11 -y

VALIDATE $? "install JDK"

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo

VALIDATE $? "downlod jenkins REPO"

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

VALIDATE $? "add jenkins key"

yum install jenkins -y

VALIDATE $? "install jenkins"

service jenkins start

VALIDATE $? "servicestart jenkins"

