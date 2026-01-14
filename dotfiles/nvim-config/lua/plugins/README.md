# Plugin Configuration

## Windows Configuration

Used Plugin

```bash
blink.lua, colorscheme.lua, flutter.lua, go.lua, mini.lua
```

I don't use `dart.lua` and `nvim-treesitter.lua` because the `flutter.lua` sets this up

## WSL

When running nvim on WSL you need utilities to build lua plugins, install:

```bash
sudo apt install build-essential cmake liblua5.1-dev
```
