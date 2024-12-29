#  Changes to popOS default VM setup

## Development Tools

### Dev CLI tools

git, ssh, ifconfig

```
# To use ifconfig
sudo apt-get install net-tools

# To use git
sudo apt-get install git

# To use ssh
sudo apt install openssh-server
sudo systemctl enable ssh
sudo ufw allow ssh

# Created location for git repos
Location of git repos: `~/Documents/dev`
```

### VMWare Tools

[Install VMware Tools on Ubuntu](https://www.liquidweb.com/blog/how-to-install-vmware-tools-ubuntu/)

* `sudo apt-get install open-vm-tools-desktop` 

### Install Programming languages

* java 17

  - java17: `sudo apt install openjdk-17-jre`

  - Note: @jan2025 Ubuntu ARM64 has issues with latest: `sudo apt install default-jre`

* Go 1.23.4

  - [Install Go Linux](https://go.dev/doc/install) 

* Dart 3.6.0

  - [Install Dart Linux](https://dart.dev/get-dart#install)

  - `sudo dpkg -i dart_3.4.0-1_amd64.deb`

  - Ubuntu ARM64 deviations

    - For dart-sdk get package at: `https://dart.dev/get-dart/archive`

    - Note: @jan2025, the arm64 debian is not available, so install ARM64 dart-sdk zip to `/usr/local/dart-sdk` and add `/usr/local/dart-sdk/bin` to `$PATH`

* Python2 and Python3

  - `sudo apt-get install python2`

  - `sudo apt-get install python3`

* node, npm, nvm

  - `sudo apt install nodejs`

  - [nvm install](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)

  - [Download Node.js](https://nodejs.org/en/download/package-manager)

### Fonts

Install inconsolata

```
sudo apt-get update
sudo apt-get install fonts-inconsolata
```
[Install Nerd Fonts](https://www.nerdfonts.com/)

- Download `JetBrainsMono`, unzip `.ttf` to `~/.local/share/fonts/` then run `fc-cache -fv`

### JetBrains ToolBox

JetBrains ToolBox lets you install different IDE tools, search for Downloads

* Installed IntelliJ, Goland, CLion, PyCharm, WebStorm

* Exported settings.zip from previous setups and imported them

### Install FlatPak

[How to Install Flatpak on Ubuntu](https://flatpak.org/setup/Ubuntu)

### Chromium ARM64

* Currently, Chrome is not available in ARM64 linux, so you need to install Chromium.

  - `sudo apt-get install chromium-browser`

### VMware-Tools

## Dev Tools

* Installed sublime following website [instructions](https://www.sublimetext.com/docs/linux_repositories.html)

  * Created symlink `cd /usr/local/bin; sudo ln -s /opt/sublime_text/sublime_text sublime`

* Installed Beyond Compare following website [instructions](https://www.scootersoftware.com/download.php)

  * Created symlink `cd /usr/local/bin; sudo ln -s /usr/bin/bcompare bcomp` 

* After installing last node LTS usin nvm then make it the default `nvm alias default node; nvm alias default node`

* Installed open-vm-tools following website [instructions](https://docs.vmware.com/en/VMware-Tools/11.3.0/com.vmware.vsphere.vmwaretools.doc/GUID-C48E1F14-240D-4DD1-8D4C-25B6EBE4BB0F.html)

* Installed Docker following website [instructions](https://docs.docker.com/engine/install/ubuntu/)

