# get computer info

Bash script to save general hardware and software info from linux pc's to logfile.

### o- Manufacturer|Product Name
### o- running OS
### o- BIOS Version|Serial
### o- Harddisk model|GiB
### o- RAM total|Type|Size
### o- Network device|macaddress
### -> logs data to to Logfile in Location


## siutable for

arch linux
debian, ubuntu
fedora

## requires dmidecode

If not installed, bash runs update and upgrade, then istalls dmidecode.

Further information:
https://www.nongnu.org/dmidecode

## creates

The bash creates the given folder if necesseray and adds the new logfile to the folder.

```sh
sudo bash getComputerInfo.sh
```
