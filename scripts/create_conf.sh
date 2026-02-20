#!/bin/bash

## color
GREEN="\e[32m"
RESET="\e[0m"

echo -e  "${GREEN}***********************************************************************${RESET} "
echo -e  "${GREEN}  Creating requirement directory  ${RESET}  " `date`
echo -e  "${GREEN} ***************************************************************************${RESET} "


mkdir -p /installer/scripts/ /installer/software/ /installer/config/ /installer/software/autoupgrade /installer/software/DB /installer/software/GI



cat > /installer/config/install.env << EOF
export DOMAIN_NAME=localdomain
export NODE1_HOSTNAME=server
export NODE1_FQ_HOSTNAME=server.localdomain
export UDMP=/u01
export ORACLE_BASE=/u01/app/oracle
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export GRID_HOME=/u01/app/19c/grid
export ORACLE_SID=aicdb
export ORACLE_UNQNAME=aicdb
export SYS_PASSWORD="Welcome#168"
export PDB_NAME="aipdb1"
export PDB_PASSWORD="Welcome#168"
export DATA_DIR=+DATA
export DNSNAME=localdomain #input your dnsname
export DNS_IP=8.8.8.8  #input your DNS IP
export SEARCHDOMAIN=localdomain
export GRID_SOFTWARE=LINUX.X64_193000_grid_home.zip
export DB_SOFTWARE=LINUX.X64_193000_db_home.zip
export GI_PATCH=p38629535_190000_Linux-x86-64.zip #grid patch number 
export OPATCH_FILE=p6880880_190000_Linux-x86-64.zip  #opatch number
export PATCH_FILE=p36866740_190000_Linux-x86-64.zip  #your patch file 

export SOFTWARE_DIR=/installer/software

#export PATCH_TOP=/installer/software\38629535
export PATCH_TOP=\$SOFTWARE_DIR/38629535
export PATCH_PATH1=\$SOFTWARE_DIR/GI/38629535


EOF

