#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
	echo "Not a superuser"
	exit 1
fi

yum install java-1.8* -y > op

if [[ "$?" -ne 0 ]]
then
	echo "Java Not Installed"
	exit 1
fi

yum install wget -y >> op

if [[ "$?" -ne 0 ]]
then
	echo "WGET Not installed"
	exit 1
fi

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo >> op

if [[ "$?" -ne 0 ]]
then
	echo "Couldn't download jenkins"
	exit 1
fi

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key >> op

if [[ "$?" -ne 0 ]]
then
	echo "Failed importing"
	exit 1
fi

yum install jenkins -y >> op
if [[ "$?" -ne 0 ]]
then
	echo "Failed to install jenkins"
	exit 1
fi

systemctl start jenkins
if [[ "$?" -ne 0 ]]
then
	echo "Unable to start Jenkins"
	exit 1
fi
systemctl status jenkins
if [[ "$?" -ne 0 ]]
then
	echo "Unable to get Jenkins status"
	exit 1
fi

yum install git -y >> op
if [[ "$?" -ne 0 ]]
then
	echo "GIT installation faile"
	exit 1
fi
cd /opt
wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
if [[ "$?" -ne 0 ]]
then
	echo "Maven download failed"
	exit 1
fi
tar -xvzf apache-maven-3.6.3-bin.tar.gz 
if [[ "$?" -ne 0 ]]
then
	echo "Maven extraction failed"
	exit 1
fi
