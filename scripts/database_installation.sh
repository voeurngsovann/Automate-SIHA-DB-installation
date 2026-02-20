

. /installer/config/install.env

#!/bin/bash
RED='\033[0;31m'
#blue color
BLUE='\033[0;34m'
#green
green='\033[0;32m'

echo -e "${GREEN}******************************************************************************"
echo -e " Creating Configuration and requreid directories ...." `date`
echo -e "****************************************************************************** ${NC} "
#skip it if you already download
#java -jar /home/oracle/scripts/autoupgrade/autoupgrade.jar  -config /home/oracle/scripts/autoupgrade/config/26ai.cfg  -patch -mode download

rm -f -r  $ORACLE_HOME
mkdir -p $ORACLE_HOME
ls $ORACLE_HOME
echo "Oracle Home is $ORACLE_HOME"

#mkdir -p /u01/app/oraInventory

echo " checking if configuration existing and creating it ...." `date`

rm /installer/config/19c_install.cfg -f 
cat >> /installer/config/19c_install.cfg  <<EOF
global.global_log_dir=$SOFTWARE_DIR/autoupgrade/log
patch1.log_dir=$SOFTWARE_DIR/autoupgrade/log/DB1
patch1.sid=$ORACLE_SID
patch1.folder=$SOFTWARE_DIR/DB
patch1.patch=RU,OJVM,OPATCH,DPBP,MRP
patch1.target_version=19
patch1.target_home=$ORACLE_HOME
patch1.home_settings.edition=ee
patch1.home_settings.oracle_base=/u01/app/oracle
patch1.home_settings.inventory_location=/u01/app/oraInventory
patch1.home_settings.inventory_group=oinstall
EOF


cat > /home/oracle/dbprofile << EOF
export CV_ASSUME_DISTID=OL7
export ORACLE_HOSTNAME=$NODE1_HOSTNAME
export ORACLE_SID=$ORACLE_SID
export ORACLE_UNQNAME=$ORACLE_SID
export ORACLE_BASE=$ORACLE_BASE
export ORA_INVENTORY=$ORA_INVENTORY
export ORACLE_HOME=$ORACLE_HOME
export TNS_ADMIN=$ORACLE_HOME/network/admin
export PATH=/usr/sbin:/usr/local/bin:${PATH}
export PATH=${ORACLE_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
alias sql='sqlplus / as sysdba '
alias alert='tail -300f $ORACLE_BASE/diag/rdbms/$ORACLE_UNQNAME/$ORACLE_SID/trace/alert_$ORACLE_SID.log'

EOF

echo "******************************************************************************"
echo "checking and verify oracle software existing " `date`
echo "******************************************************************************"


ls -la $SOFTWARE_DIR/DB/*


echo "******************************************************************************"
echo " checking and verify Autoupgrade software  Version " `date`
echo "******************************************************************************"


java -jar $SOFTWARE_DIR/autoupgrade.jar   -version



# Variables
REQUIRED_SPACE="15GB"

# Convert REQUIRED_SPACE to KB for comparison
REQUIRED_KB=$(echo $REQUIRED_SPACE | awk '
    /GB$/ {gsub("GB",""); print $1*1024*1024}
    /MB$/ {gsub("MB",""); print $1*1024}
    /KB$/ {gsub("KB",""); print $1}
')

# Check free space on filesystem containing GRID_HOME
AVAILABLE_KB=$(df -k ${ORACLE_HOME} | tail -1 | awk '{print $4}')

echo "Required: ${REQUIRED_SPACE} (${REQUIRED_KB} KB)"
echo "Available: $((${AVAILABLE_KB}/1024/1024)) GB"

if [ ${AVAILABLE_KB} -lt ${REQUIRED_KB} ]; then
    echo "ERROR: Not enough space in $(df -h ${ORACLE_HOME} | tail -1 | awk '{print $1}')."
    echo "Oracle HOME installatopm required at least ${REQUIRED_SPACE}."
    exit 1
else
    echo "Sufficient space available. Proceeding with installation..."



echo "******************************************************************************"
echo "installation oracle 19c home and Be patient and waiting for completing tasks " `date`
echo "******************************************************************************"

echo "Typing command 'lsj' for checking job and 'status' for checking status"

echo "******************************************************************************"
echo "******************************************************************************"




java -jar /installer/software/autoupgrade.jar  -config /installer/config/19c_install.cfg  -patch -mode create_home




echo "******************************************************************************"
echo " installation oracle  home is completed " `date`
echo "******************************************************************************"

fi

 
