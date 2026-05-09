#! /bin/bash

USERID=$(id -u)
R="\e[31m"
B="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" &>>$LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R EROOR: Please run the script with root access $N" | tee -a $LOG_FILE
    exit 1
else
    echo -e "$B You are running with root access $N" | tee -a $LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "Installing $2 is Success" | tee -a $LOG_FILE
    else
        echo "Installing $2 is Failure" | tee -a $LOG_FILE
        exit 1
    fi
}


dnf list instaled mysql &>>$LOG_FILE

if [ $? -ne 0 ]
then 
    echo "Mysql is not installed.....going to install" | tee -a $LOG_FILE

    dnf install mysql -y &>>$LOG_FILE

   VALIDATE $? "mysql"

else
    echo "Mysql is already installed" | tee -a $LOG_FILE
    
fi 

dnf list instaled nginx &>>$LOG_FILE

if [ $? -ne 0 ]
then 
    echo "nginx is not installed.....going to install" | tee -a $LOG_FILE

    dnf install nginx -y &>>$LOG_FILE

    VALIDATE $? "nginx"
else
    echo "nginx is already installed" | tee -a $LOG_FILE
    
fi


dnf list instaled python3 &>>$LOG_FILE

if [ $? -ne 0 ]
then 
    echo "python3 is not installed.....going to install" | tee -a $LOG_FILE

    dnf install python3 -y &>>$LOG_FILE

    VALIDATE $? "python3"

else
    echo "python3 is already installed" | tee -a $LOG_FILE
    
fi