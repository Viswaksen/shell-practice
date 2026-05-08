#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "EROOR: Please run the script with root access"
    exit 0
else
    echo "You are running with root access"
fi

dnf install mysql -y