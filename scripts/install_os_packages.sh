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
cat >> /etc/sysctl.conf <<EOF
fs.file-max = 6815744  
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
EOF
/sbin/sysctl -p

cat >> /etc/security/limits.d/oracle-database-preinstall-19c.conf <<EOF
oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728
EOF

