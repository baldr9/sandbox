# Issues with using Ubuntu arm64

Current distro: `Linux ubuntu-21.10 6.11.0-13-generic #14-Ubuntu SMP PREEMPT_DYNAMIC Sun Dec  1 00:22:04 UTC 2024 aarch64 aarch64 aarch64 GNU/Linux`

openjdk 21 issues.

- Waiting for new updated `openjdk jre jdk` 
  ```
  openjdk-17-jdk-headless
  openjdk-17-jre
  jopenjdk-17-jre-headless
  ```
- [GoLand Workaround](https://youtrack.jetbrains.com/issue/JBR-8078/Bundled-JRE-crashes-on-M4-MacOS-15.2-in-virtualized-environments)
  - In `goland64.vmoptions, jetbrains_client64.vmoptions` added `-XX:UseSVE=0`
  - VM custom location `/opt/GoLand-2024.3.1/bin/goland64.vmoptions`

- Also could not run the `JetBrains ToolBox` since openjdk has issues with Ubuntu 21.10


- Follow up 2025-03-12

  - [TBX-13689](https://youtrack.jetbrains.com/issue/TBX-13689) - Tried the following:
  ```
  # Upgrade vm
  sudo apt-get update
  sudo apt upgrade

  # Edit grub
  sudo nano /etc/default/grub

  # Change options by adding arm64.nosve:
  GRUB_CMDLINE_LINUX_DEFAULT="quiet splash arm64.nosve"

  # Save file and afterward:
  sudo update-grub
  ```
## Running Toolbox

- Before running Toolbox I added this command to shell `export SKIKO_RENDER_API=SOFTWARE`

  - Added to the VM `.bashrc`

- [JetBrains Toolbox won't start](https://askubuntu.com/questions/1357297/jetbrains-toolbox-wont-start-on-ubuntu-20-04)


