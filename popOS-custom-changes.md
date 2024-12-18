#  Changes to popOS default VM setup


## Development Tools

### VMWare Tools

[Install VMware Tools on Ubuntu](https://www.liquidweb.com/blog/how-to-install-vmware-tools-ubuntu/)

* `sudo apt-get install open-vm-tools-desktop` 

### Install Programming languages

* java 11

  - `sudo apt install default-jre`

* Go 1.23.4

  - [Install Go Linux](https://go.dev/doc/install) 

* Dart 3.6.0

  - [Install Dart Linux](https://dart.dev/get-dart#install)

  - `sudo dpkg -i dart_3.4.0-1_amd64.deb`

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

- Download `JetBrainsMono`, unzip `.ttf` to `~/.local/usr/share/fonts/` then run `fc-cache -fv`

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

