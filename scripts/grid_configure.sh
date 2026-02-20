. /installer/config/install.env


echo "******************************************************************************"
echo "Do grid configuration." `date`
echo "******************************************************************************"

whoami

cd ${GRID_HOME}
./gridSetup.sh  -silent  -executeConfigTools  -waitforcompletion -ignorePrereqFailure -lenientInstallMode  \
    -responseFile  ${GRID_HOME}/install/response/grid_*.rsp \
    INVENTORY_LOCATION=${ORA_INVENTORY} \
    SELECTED_LANGUAGES=${ORA_LANGUAGES} \
    ORACLE_BASE=/u01/app/grid \
    oracle.install.asm.OSDBA=asmdba \
    oracle.install.asm.OSOPER=asmoper \
    oracle.install.asm.OSASM=asmadmin \
    oracle.install.asm.SYSASMPassword=${SYS_PASSWORD} \
    oracle.install.asm.monitorPassword=${SYS_PASSWORD} \
    oracle.install.asm.diskGroup.diskDiscoveryString=/dev/sdb1 \
    oracle.install.asm.storageOption=ASM \
    oracle.install.asm.diskGroup.name=DATA \
    oracle.install.asm.diskGroup.redundancy=EXTERNAL \
    oracle.install.asm.diskGroup.AUSize=4 \
    oracle.install.asm.configureAFD=false \
    oracle.install.crs.rootconfig.executeRootScript=false \
    oracle.install.config.managementOption=NONE \
    oracle.install.config.omsPort=0
