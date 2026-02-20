. /installer/config/install.env
# ANSI escape code for red color
RED='\033[0;31m'
#blue color
BLUE='\033[0;34m'
#green
green='\033[0;32m'
# ANSI escape code to reset color
NC='\033[0m'
rm -f -r ${GRID_HOME} 
mkdir -p ${GRID_HOME}
rm -f -r ${ORA_INVENTORY}
ls -l ${GRID_HOME}
mkdir -p ${ORA_INVENTORY}
mkdir -p $SOFTWARE_DIR
chown -R grid:oinstall $SOFTWARE_DIR
chown -R grid:oinstall $UDMP
chmod -R 775 $UDMP
chown grid:asmadmin ${rwdisk1}
chmod 660  ${rwdisk1}
 
echo -e "${BLUE}****************************************************************************"

echo -e "Install grid binary software " `date`
echo -e "******************************************************************************${NC} "

su - grid -c 'sh /installer/scripts/oracle_grid_software_installation.sh'


sh ${ORA_INVENTORY}/orainstRoot.sh

sh ${GRID_HOME}/root.sh


echo -e "${BLUE}******************************************************************************"
echo -e "Configure grid" `date`
echo -e "****************************************************************************** ${NC}  "

su - grid -c 'sh /installer/scripts/grid_configure.sh'
echo -e "${BLUE}******************************************************************************"
echo -e "Run DB root scripts. " `date`
echo -e "****************************************************************************** ${NC} "
#working around for issue CLSRSC-400
ls -la ${GRID_HOME}/bin/acfsdriverstate 
ls -la ${GRID_HOME}/bin/acfsroot 

mv ${GRID_HOME}/bin/acfsdriverstate ${GRID_HOME}/bin/acfsdriverstate_org
mv ${GRID_HOME}/bin/acfsroot  ${GRID_HOME}/bin/acfsroot_org

echo -e "${BLUE}****************************************************************************"
echo -e "Perform root.sh  *******${NC} "
echo -e "******************************************************************************${NC} "


sh ${ORA_INVENTORY}/orainstRoot.sh

sh ${GRID_HOME}/root.sh



echo -e "${BLUE}****************************************************************************"
echo -e "Checking services up and running  *******${NC} "
echo -e "******************************************************************************${NC} "

. /home/grid/gi_profile

crsctl stat res -t -init




echo -e "${BLUE}****************************************************************************"
echo -e "Completed and install grid infrusture  *******${NC} "
echo -e "******************************************************************************${NC} "


