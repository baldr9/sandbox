Changed logout time
- /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/logout/Logout.qml
  - timeout: 30 (default), changed it to 3
  - src: https://www.pclinuxos.com/forum/index.php?topic=153588.0


Had to repartion the VM to get more space, first increase size using Fusion when VM is not running
```
  107  sudo umount /boot/efi
  108  resize2fs /dev/sda2
  109  growpart -v /dev/sda 2
  110  resize2fs /dev/sda2
  111  mount
  112  df -h
  113  resize2fs /dev/sda5
  114  growpart -v /dev/sda 5
  115  resize2fs /dev/sda5
  116  df -h
  117  history
```

Had to unmount /dev/sda2 then I was able to growpart and resize2fs /dev/sda2 and /dev/sda5
```
  # To install growpart utility
  sudo apt-get install -y cloud-utils
```
