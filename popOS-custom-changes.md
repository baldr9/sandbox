#  Changes to popOS default VM setup


## Development Tools

### Fonts

Install inconsolata

```
sudo apt-get update
sudo apt-get install fonts-inconsolata
```

### JetBrains ToolBox

JetBrains ToolBox lets you install different IDE tools, search for Downloads

* Installed IntelliJ, Goland, CLion, PyCharm, WebStorm

* Exported settings.zip from previous setups and imported them


### Install Programming languages

* Installed java 11, go 1.17, node, npm, nvm

### Dev Tools

* Installed sublime following website [instructions](https://www.sublimetext.com/docs/linux_repositories.html)

  * Created symlink `cd /usr/local/bin; sudo ln -s /opt/sublime_text/sublime_text sublime`

* Installed Beyond Compare following website [instructions](https://www.scootersoftware.com/download.php)

  * Created symlink `cd /usr/local/bin; sudo ln -s /usr/bin/bcompare bcomp` 

* After installing last node LTS usin nvm then make it the default `nvm alias default node; nvm alias default node`

* Installed open-vm-tools following website [instructions](https://docs.vmware.com/en/VMware-Tools/11.3.0/com.vmware.vsphere.vmwaretools.doc/GUID-C48E1F14-240D-4DD1-8D4C-25B6EBE4BB0F.html)

* Installed Docker following website [instructions](https://docs.docker.com/engine/install/ubuntu/)

