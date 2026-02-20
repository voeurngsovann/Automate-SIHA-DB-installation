# Automate SIHA Databases Installation

This project provides automation scripts and simplify install oracle SIHA by install GI Infrastructure ,database installation and database creation on oracle database 19c version.

## 📂 Project Structure
- **installer/config/install.env** → Configuration files for GI and  database setup
- **installer/scripts** → Shell scripts to automate installation steps
- **installer/software/autoupgrade** 
- **installer/software/GI** 
- **installer/software/DB**
   

## 🚀 How It Works
1. Place your GI and database software  files in `installer/software`.
2. Download GI software (LINUX.X64_193000_grid_home.zip)and  PSU patches and put in  /installer/software/GI
3. Download DB software (LINUX.X64_193000_db_home.zip)and  PSU patches and put in  /installer/software/DB
4. Adjust install.env configuration files in `installer/config` as needed.
5. Run scripts from `installer/installer.sh` with available option  to automate the installation process.

## 🛠 Requirements
- OS oracle linux 8 or redhet 8 
- softwares 
 autoupgrade.jar 
 LINUX.X64_193000_grid_home.zip
 LINUX.X64_193000_db_home.zip
 p38629535_190000_Linux-x86-64.zip  
 p6880880_190000_Linux-x86-64.zip
## Noted for database software
you can using autoupgrade tool to download or using manual download  RU,OJVM,OPATCH,DPBP,MRP patch update  in put in  /installer/software/DB


## 📖 Usage
```bash
cd /installer
bash installer.sh with option below : 

1. create folder /installer
 mkdir -p /installer/scripts/ /installer/software/ /installer/config/ /installer/software/autoupgrade /installer/software/DB /installer/software/GI

2. adjust /installer/config/install.env based on your enviroment

3. sh istaller.sh using this following option

--GridInstall:
             Install software binary and configure GI single instance
--dropdb:
             drop database

--CreateHomeAuto:
             creating oracle home using autoupgrade
--createdb:
             create database required 8GB of memory
--dropdb:
             drop database

--version:
        show current version and last modified of script

Or you want automation all using following shell script for automation everything 
sh complete_install.sh 

