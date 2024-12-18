# Updating and Installing Go and DART

## update go on VM
 - https://go.dev/doc/install

## update sylinks
Remove symlink and add new one
  - `cd /usr/bin;sudo rm go;sudo ln -s /usr/local/go/bin/go go`

## Update .bashrc
```
# Setting up golang path
export GOPATH=$HOME/Documents/dev/baldr9-github/iot-blackbox/learn/go/go-workspace
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
```

---

## Install dart on Ubuntu
  - https://dart.dev/get-dart
  - IntelliJ plugins: flutter and dart

---

## IntelliJ Theme changes
- Use Inconsolata 14.0 spacing 1.2
- Import IDE settings.zip for different IDEs

