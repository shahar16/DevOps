#!/bin/bash


echo "update machine"
sudo apt-get update

echo "install java 8"
sudo apt-get install openjdk-8-jdk -y

echo "install tomcat 7"
sudo apt-get install tomcat7 -y
sudo service tomcat7 start || true

echo "install nginx"
sudo apt-get install nginx -y

chmod -R 777 /home/shahar



