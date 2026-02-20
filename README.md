# Automate Databases Install

This project provides automation scripts and configurations to simplify database installation and setup.

## 📂 Project Structure
- **installer/config** → Configuration files for database setup
- **installer/scripts** → Shell scripts to automate installation steps
- **installer/software** → Required software packages

## 🚀 How It Works
1. Place your database installation files in `installer/software`.
2. Adjust configuration files in `installer/config` as needed.
3. Run scripts from `installer/scripts` to automate the installation process.

## 🛠 Requirements
- OS oracle linux 8 or redhet 8 
- software 
 autoupgrade.jar 
 p38743961_230000_Linux-x86-64.zip 
 p6880880_230000_Linux-x86-64.zip

## 📖 Usage
```bash
cd installer
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
