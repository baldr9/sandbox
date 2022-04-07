# Setting up PopOS

## Steps

1. Used PopOS USB install and just installed over old macOS

  _ This helped setup last EFI boot partitions

2. Use macOS Catalina USB install
  
  _ Repartioned: 1 TB macOS, 982 GB Linux, 33 GB Swamp

3. Used PopOS to do 'Custom Install' and selected the EFI boot, 982 Linux `\`, and 33 GB Swap

  _ Rebooted, then used wired Ethernet to install driver for Wifi

  _ [Ubuntu-Wifi Driver Install](https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers)

  _ [Ubuntu-Wifi Driver Video](https://www.youtube.com/watch?v=kRgKlcm1XPI)

  _ Installed rEFInd: 
  ```
   sudo add-apt-repository ppa:rodsmith/refind && sudo apt update && sudo apt install refind && sudo refind-mkdefault
  ```
  _ Rebooted
  
## Commands to install Wifi driver

```
lspci
sudo apt-get update
sudo apt-get purge bcmwl-kernel-source
sudo update-pciids
lspci
lspci -nn -d 14e4:
# Macbook 2014 had Wifi Broadcom 14e4:43a0 rev 3
sudo apt-get install bcmwl-kernel-source
```

