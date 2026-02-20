#!/bin/bash
RED='\033[0;31m'
#blue color
BLUE='\033[0;34m'
#green
green='\033[0;32m'

. /installer/config/install.env

echo -e "${BLUE}******************************************************************************"
echo -e "Unzip Grid Software " `date`
echo -e "******************************************************************************${NC} "

rm -f /home/grid/gi_profile 

cat > /home/grid/gi_profile << EOF
export ORACLE_SID=+ASM
export ORACLE_BASE=/u01/app/grid
export ORACLE_HOME=${GRID_HOME}
export ORACLE_TERM=xterm
export BASE_PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$BASE_PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
export CVUHOME=/home/grid/mycvhome
export PATH=\$CVUHOME/bin:\$PATH

alias sql='sqlplus / as sysasm '

EOF

cd ${GRID_HOME}
pwd
unzip -oq /installer/software/GI/LINUX.X64_193000_grid_home.zip
unzip -oq /installer/software/GI/${OPATCH_FILE}
cd /installer/software/GI
unzip -oq /installer/software/GI/${GI_PATCH}
rm -f /installer/software/GI/LINUX.X64_193000_grid_home.zip
rm -f /installer/software/GI/${GI_PATCH}


echo -e "${BLUE}******************************************************************************"
echo -e "Unzip Grid Software success ${NC}" `date`
echo -e "******************************************************************************"

echo -e "${BLUE}******************************************************************************"
echo -e " Grid  installation is processing ." `date`
echo -e "******************************************************************************${NC} "
# Variables
REQUIRED_SPACE="14GB"

# Convert REQUIRED_SPACE to KB for comparison
REQUIRED_KB=$(echo $REQUIRED_SPACE | awk '
    /GB$/ {gsub("GB",""); print $1*1024*1024}
    /MB$/ {gsub("MB",""); print $1*1024}
    /KB$/ {gsub("KB",""); print $1}
')

# Check free space on filesystem containing GRID_HOME
AVAILABLE_KB=$(df -k ${GRID_HOME} | tail -1 | awk '{print $4}')

echo "Required: ${REQUIRED_SPACE} (${REQUIRED_KB} KB)"
echo "Available: $((${AVAILABLE_KB}/1024/1024)) GB"

if [ ${AVAILABLE_KB} -lt ${REQUIRED_KB} ]; then
    echo "ERROR: Not enough space in $(df -h ${GRID_HOME} | tail -1 | awk '{print $1}')."
    echo "Grid Infrastructure install requires at least ${REQUIRED_SPACE}."
    exit 1
else
    echo "Sufficient space available. Proceeding with installation..."


. /home/grid/gi_profile

${GRID_HOME}/gridSetup.sh -ignorePrereq -waitforcompletion  -lenientInstallMode \
    -silent \
    -applyRU ${PATCH_PATH1} \
    -responseFile ${GRID_HOME}/install/response/gridsetup.rsp \
    oracle.install.option=HA_CONFIG  \
    ORACLE_BASE=/u01/app/grid \
    oracle.install.asm.OSDBA=asmdba \
    oracle.install.asm.OSOPER=asmoper \
    oracle.install.asm.OSASM=asmadmin \
    oracle.install.asm.SYSASMPassword=${SYS_PASSWORD} \
    oracle.install.asm.monitorPassword=${SYS_PASSWORD} \
    oracle.install.asm.diskGroup.disks=${rwdisk1} \
    oracle.install.asm.diskGroup.diskDiscoveryString=/dev/sd* \
    oracle.install.asm.storageOption=ASM \
    oracle.install.asm.diskGroup.name=DATA \
    oracle.install.asm.diskGroup.redundancy=EXTERNAL \
    oracle.install.asm.diskGroup.AUSize=4 \
    oracle.install.asm.configureAFD=false \
    oracle.install.crs.rootconfig.executeRootScript=false \
    oracle.install.config.managementOption=NONE \
    oracle.install.config.omsPort=0
    
 fi




echo -e "${BLUE}******************************************************************************"
echo -e "Completed software-only installation. " `date`
echo -e "******************************************************************************${NC}"

echo -e "cleanup patch directory  " `date`

rm -f -r  /installer/software/GI/*

