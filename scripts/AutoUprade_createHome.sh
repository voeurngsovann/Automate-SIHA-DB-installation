#!/bin/bash

## color
GREEN="\e[32m"
RESET="\e[0m"
chown oracle:oinstall -R /installer
chmod 755 -R /installer
chown oracle:oinstall /installer/software/autoupgrade.jar
chown oracle:oinstall /installer/scripts/database_installation.sh 
chmod 755 /installer/software/autoupgrade.jar
chmod 755 /installer/scripts/database_installation.sh

su - oracle -c 'sh /installer/scripts/database_installation.sh ' 


echo -e  "${GREEN}***********************************************************************${RESET} "
echo -e  "${GREEN}  Performing root.sh from oracle binary home ${RESET}  " `date`
echo -e  "${GREEN} ***************************************************************************${RESET} "    

. /installer/config/install.env


sh $ORACLE_HOME/root.sh

echo -e  "${GREEN} ***************************************************************************${RESET} "
echo -e  " ${GREEN} Following is the database binary which has installed ${RESET}" `date`
echo -e  "${GREEN} ***************************************************************************${RESET} "

su - oracle -c ' . /home/oracle/dbprofile; $ORACLE_HOME/OPatch/opatch version'
su - oracle -c ' . /home/oracle/dbprofile;  echo QUIT | $ORACLE_HOME/bin/sqlplus /nolog; '


echo -e " ${GREEN}************************************************************************${RESET} "

echo -e " ${GREEN} This is the database home and version of opatch that was installed ${RESET} " `date`

echo -e  "${GREEN} ***************************************************************************${RESET} "    
