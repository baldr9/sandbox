# Setting up macOS Catalina and PopOS dual boot

## Steps

1. Used PopOS USB install and just installed over old macOS

   - This helped setup larger sized EFI boot partitions

2. Use macOS Catalina USB install
  
   - Repartioned: 1 TB macOS, 982 GB Linux, 33 GB Swamp

3. Used PopOS to do 'Custom Install' and selected the EFI boot, 982 Linux `\`, and 33 GB Swap

   - Rebooted, then used wired Ethernet to install the WiFi driver

   - [Ubuntu-Wifi Driver Install](https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers)

   - [Ubuntu-Wifi Driver Video](https://www.youtube.com/watch?v=kRgKlcm1XPI)

   - [Installed rEFInd](https://www.youtube.com/watch?v=kRgKlcm1XPI)
   ```
   sudo add-apt-repository ppa:rodsmith/refind && sudo apt update && sudo apt install refind && sudo refind-mkdefault
   ```
   - Rebooted
  
## Commands to install WiFi driver

```
sudo apt-get update
sudo apt-get purge bcmwl-kernel-source
sudo update-pciids
lspci
lspci -nn -d 14e4:
# Macbook 2014 had WiFi Broadcom 14e4:43a0 rev 3
sudo apt-get install bcmwl-kernel-source
```

