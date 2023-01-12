#!/bin/bash
 
USERNAME='silence'
SCNAME='starbound'
BIN_PATH="/home/silence/steamcmd/starbound/linux/"
SERVICE='starbound_server'
CONFIG='/home/silence/terraria/serverconfig.txt'
 
 
ME=`whoami`
 
if [ $ME != $USERNAME ] ; then
   echo "Please run the $USERNAME user."
   exit
fi
 
start() {
   if pgrep -u $USERNAME -f $SERVICE > /dev/null ; then
       echo "$SERVICE is already running!"
       exit
   fi
 
   echo "Starting $SERVICE..."
   screen -AmdS $SCNAME
   screen -p 0 -S $SCNAME -X stuff "cd $BIN_PATH && ./$SERVICE\r"
   exit
}
 
stop() {
   if pgrep -u $USERNAME -f $SERVICE > /dev/null ; then
       echo "Stopping $SERVICE "
   else
       echo "$SERVICE is not running!"
       exit
   fi

   kill -2 `pgrep -u $USERNAME -f $SERVICE`
   sleep 5

   if pgrep -u $USERNAME -f $SERVICE > /dev/null ; then
       echo "Stopping $SERVICE Error!"
       exit
   fi
       echo "Finished!"
       screen -p 0 -S $SCNAME -X stuff "exit\r"
       exit
}
 
status() {
   if pgrep -u $USERNAME -f $SERVICE > /dev/null ; then
       echo "$SERVICE is already running!"
       exit
   else
       echo "$SERVICE is not running!"
       exit
   fi
}
 
case "$1" in
   start)
       start
       ;;
   stop)
       stop
       ;;
   status)
       status
       ;;
   *)
       echo  $"Usage: $0 {start|stop|status}"
esac
