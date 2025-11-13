#!/bin/bash
# ----------------------------------------------------------------------
# getComputerInfo.sh
# ----------------------------------------------------------------------
# get general info about running Linux System
# o- Manufacturer|Product Name
# o- running OS
# o- BIOS Version|Serial
# o- Harddisk model|GiB
# o- RAM total|Type|Size
# o- Network device|macaddress
# -> logs data to to Logfile in Location 
# ----------------------------------------------------------------------
# set variables
# package used to aquire info
Package=dmidecode
# folder 
Location="./aquired-data/"
# filename
Logfile="logfile_"
Logfile+=`date '+%Y-%m-%d_%H-%M-%S'`
Logfile+=".txt"
# message to save
Message=""
# ----------------------------------------------------------------------
# install package if not yet installed
# check arch
if [ -d /etc/pacman.d ]
  then
    echo "Arch is installed"
    # check package
    if pacman -Qs $Package > /dev/null ; 
      then
        echo "The Package $Package is installed"
      else
        #install package
        sudo pacman -Syu
        sudo pacman -S $Package
        echo "$Package is now installed"
    fi
fi
# check debian
if [ -d /etc/apt ]
  then
   echo "Debian is installed"
  # check package
    if apt-cache search $Package > /dev/null;
      then
        echo "$Package is installed"
      else
        #install package
        sudo apt update
        sudo apt install dmidecode
        echo "$Package is now installed"
  fi
fi
# check red hat
if [ -d /etc/dnf ]
  then
    echo "Red Hat is Installed"
    # check package
    if dnf search $Package > /dev/null;
      then
        echo "$Package is installed"
      else
        #install package
        sudo dnf upgrade --refresh
        sudo dnf install $Package
        echo "$Package is now installed"
  fi
fi
# ----------------------------------------------------------------------
# create Message
Message+='Computerinfo
------------------------------------------------------------------------
'$( sudo dmidecode -t 1 | grep -E 'Manufacturer|Product Name')'
  '$( uname -n)': '$( uname -o )' '$( uname -r )' '$( uname -m)'
------------------------------------------------------------------------
 '$( sudo dmidecode -t 1 | grep -E 'Version|Serial Number|UUID')'
 '$( sudo dmidecode -t 4 | grep -E 'Version|Signature|Characteristics|Serial Number')'
------------------------------------------------------------------------
 '$(sudo fdisk -l | grep -E "model|GiB")'
------------------------------------------------------------------------
RAM '$( grep MemTotal /proc/meminfo )'
 '$(sudo dmidecode -t memory | grep -E 'Type|Size')'
------------------------------------------------------------------------
 '$(ip link | grep -E "MULTICAST|link/ether")
# create folder if not exists
mkdir -p $Location
cd $Location
# write to file
if [ -f $Logfile ]
  then
    echo "$Message " >> $Logfile
  else
    touch $Logfile
    echo "$Message" >> $Logfile
fi