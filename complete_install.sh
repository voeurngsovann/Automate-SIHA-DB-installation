echo "******************************************************************************"
echo "Start install and configure Grid infastructure" `date`
echo "******************************************************************************"

#. /installer/installer.sh --GridInstall

echo "******************************************************************************"
echo "Starting install oracle database home using Autoupgrade " `date`
echo "******************************************************************************"



#. /installer/installer.sh --CreateHomeAuto



echo "******************************************************************************"
echo " Creating oracle database " `date`
echo "******************************************************************************"

. /installer/installer.sh --createdb

echo "******************************************************************************"
echo "Completed install grid ,oracle and create database " `date`
echo "******************************************************************************"




