. /installer/config/install.env
. /home/oracle/dbprofile
# drop database 
read -p "Are you sure you want to drop database $ORACLE_SID  [y/n] " answer
case $answer in
  [yY]* ) 
    dbca -silent -deleteDatabase -sourceDB $ORACLE_SID -sysDBAUserName sys -sysDBAPassword $SYS_PASSWORD -forceArchiveLogDeletion
    ;;

  [nN]* ) echo "Aborting the command..."; exit;;
  * ) echo "Invalid input..."; exit 1;;
esac


