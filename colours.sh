#!/bin/bash

USERID=$(id -u)
DATE=$(date +%F)
LOG="Jenkins-install-${DATE}.log"

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

yum update -y &>>$LOG

VALIDATE $? "update yum"

yum install git -y &>>$LOG

VALIDATE $? "install git"

sudo amazon-linux-extras install java-openjdk11 -y &>>$LOG

VALIDATE $? "install JDK"

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo &>>$LOG

VALIDATE $? "downlod jenkins REPO"

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>>$LOG

VALIDATE $? "add jenkins key"

yum install jenkins -y &>>$LOG

VALIDATE $? "install jenkins"

service jenkins start &>>$LOG

VALIDATE $? "servicestart jenkins"