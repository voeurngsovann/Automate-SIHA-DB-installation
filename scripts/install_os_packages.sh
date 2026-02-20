. /installer/config/intall.env

echo "******************************************************************************"
echo "Prepare dnf with the latest repos." `date`
echo "******************************************************************************"
echo "search $SEARCHDOMAIN" >> /etc/resolv.conf    ## your DNS FQDN
echo "nameserver $DNS_IP" >> /etc/resolv.conf  ## your DNSIP
 

dnf install -y binutils
dnf install -y gcc
dnf install -y gcc-c++
dnf install -y glibc
dnf install -y glibc-devel
dnf install -y glibc-devel.i686
dnf install -y libaio
dnf install -y libaio-devel
dnf install -y libgcc
dnf install -y libstdc++
dnf install -y libstdc++-devel
dnf install -y libnsl
dnf install -y sysstat
dnf install -y motif
dnf install -y motif-devel
dnf install -y redhat-lsb
dnf install -y redhat-lsb-core
dnf install -y openssl
dnf install -y make
dnf install -y libnsl
dnf install -y libnsl.i686
dnf install -y libnsl2
dnf install -y libnsl2.i686
dnf install -y libgcc.i686
dnf install -y libstdc++.i686
dnf install -y compat-libcap1
dnf install -y compat-libstdc++-33
dnf install -y compat-libstdc++-33.i686
dnf install -y dejavu-serif-fonts
dnf install -y ksh
dnf install -y numactl
dnf install -y numactl-devel
dnf install compat-openssl10-1.0.2o-4.el8_10.1.x86_64 -y


