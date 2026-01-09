# Neovim plugin tasks

- [x] Deprecate `cmp.lua` so that we switch to using custom `blink-cmp.lua`.

  - Sources

    - [blink.lua](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/blink.lua) example.

    - [blink-comp.lua](https://github.com/jakobwesthoff/nvim-from-scratch/blob/session/06/lua/plugins/blink-cmp.lua)
  
    - [Easiest neovim autocompletion setup using blink video](https://www.youtube.com/watch?v=Q0cvzaPJJas)

    - [Blink auto completion plugin video](https://www.youtube.com/watch?v=GKIxgCcKAq4)

- [x] Setup `marksman.lua` to do markdown linting

  - On nvim do:

    - `:MasonInstall marksman`

    - `:MasonInstall markdownlint`

    - Use LazyExtras and install `lang.markdown`

    - Copy `marksman.lua` to `.config/nvim/lua/plugins`

    - Add a `.markdownlint.yaml` to your root project with rules to exclude

    - Use `<leader>c` to view `<leader>cd` which is `line diagnostics`
