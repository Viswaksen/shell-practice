#! /bin/bash

USERID=$(id -u)
R="\e[31m"
B="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python3" "nginx")

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

for PACKAGE in ${PACKAGES[@]}
do
    dnf list instaled $PACKAGE &>>$LOG_FILE

    if [ $? -ne 0 ]
    then 
        echo "$PACKAGE is not installed.....going to install" | tee -a $LOG_FILE

        dnf install $PACKAGE -y &>>$LOG_FILE

         VALIDATE $? "$PACKAGE"

    else
        echo "Mysql is already installed" | tee -a $LOG_FILE
        
    fi 

done
