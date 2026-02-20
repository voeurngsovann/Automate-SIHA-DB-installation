. /installer/config/install.env

cat > $ORACLE_HOME/network/admin/tnsnames.ora <<EOF
LISTENER = (ADDRESS = (PROTOCOL = TCP)(HOST = $HOSTNAME)(PORT = 1521))
$ORACLE_SID= 
(DESCRIPTION = 
  (ADDRESS = (PROTOCOL = TCP)(HOST = $HOSTNAME)(PORT = 1521))
  (CONNECT_DATA =
    (SERVER = DEDICATED)
    (SERVICE_NAME = $ORACLE_SID)
  )
)
$PDB_NAME= 
(DESCRIPTION = 
  (ADDRESS = (PROTOCOL = TCP)(HOST = $HOSTNAME)(PORT = 1521))
  (CONNECT_DATA =
    (SERVER = DEDICATED)
    (SERVICE_NAME = $PDB_NAME)
  )
)
EOF



echo "******************************************************************************"
echo "Create database." `date`
echo "******************************************************************************"
. /home/oracle/dbprofile
$ORACLE_HOME/bin/dbca -silent -createDatabase \
  -templateName General_Purpose.dbc \
  -gdbname $ORACLE_UNQNAME -responseFile NO_VALUE \
  -characterSet AL32UTF8 \
  -sysPassword $SYS_PASSWORD \
  -systemPassword $SYS_PASSWORD \
  -createAsContainerDatabase true \
  -numberOfPDBs 1 \
  -pdbName $PDB_NAME \
  -pdbAdminPassword $PDB_PASSWORD \
  -databaseType MULTIPURPOSE \
  -automaticMemoryManagement false \
  -totalMemory 8024 \
  -redoLogFileSize 1024 \
  -emConfiguration NONE \
  -ignorePreReqs \
  -storageType ASM \
  -diskGroupName +DATA \
  -recoveryGroupName +DATA \
  -useOMF true \
  -asmsnmpPassword $SYS_PASSWORD 

echo "******************************************************************************"
echo "Save state of PDB to enable auto-start." `date`
echo "******************************************************************************"
sqlplus / as sysdba <<EOF
ALTER PLUGGABLE DATABASE $PDB_NAME SAVE STATE;
show pdbs;
EXIT;
EOF

echo "******************************************************************************"
echo "Output from srvctl config database -d ${ORACLE_UNQNAME}" `date`
echo "******************************************************************************"
srvctl config database -d ${ORACLE_UNQNAME}

echo "******************************************************************************"
echo "Output from srvctl status database -d ${ORACLE_UNQNAME}" `date`
echo "******************************************************************************"
srvctl status database -d ${ORACLE_UNQNAME}

echo "******************************************************************************"
echo "Output from v\$active_instances" `date`
echo "******************************************************************************"
sqlplus / as sysdba <<EOF
set linesize 300;
select HOST_NAME,INSTANCE_NAME ,status from v\$instance;
SELECT inst_name FROM v\$active_instances;

EXIT;
EOF

