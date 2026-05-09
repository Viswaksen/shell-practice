#! /bin/bash

USERID=$(id -u)
R="\e[31m"
B="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R EROOR: Please run the script with root access Ok? $N"
    exit 1
else
    echo -e "$B You are running with root access $N"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "Installing $2 is Success"
    else
        echo "Installing $2 is Failure"
        exit 1
    fi
}


dnf list instaled mysql

if [ $? -ne 0 ]
then 
    echo "Mysql is not installed.....going to install"

    dnf install mysql -y

   VALIDATE $? "mysql"

else
    echo "Mysql is already installed"
    
fi 

dnf list instaled nginx

if [ $? -ne 0 ]
then 
    echo "nginx is not installed.....going to install"

    dnf install nginx -y

    VALIDATE $? "nginx"
else
    echo "nginx is already installed"
    
fi


dnf list instaled python3

if [ $? -ne 0 ]
then 
    echo "python3 is not installed.....going to install"

    dnf install python3 -y

    VALIDATE $? "python3"

else
    echo "python3 is already installed"
    
fi