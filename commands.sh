#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "EROOR: Please run the script with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf install mysqlllll -y

if [ $? -eq 0 ]
then
    echo "Installing MySql is Success"
else
    echo "Installing MySql is Failure"
    
fi