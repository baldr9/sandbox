# Neovim plugin tasks

- [x] nvim `:LazyExtras` is used to install language LSPs enabled laguages:

   ```
      lang.dart, lang.go, lang.json, lang.markdown, lang.typescript, lang.docker
   ```

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

- [ ] Setup LazyVim `ai.copilot-native` plugin because it uses Lua LSP

  - On nvim do:

    - Requires nvim 11.5+, use `:LazyExtras`, click x on `ai.copilot-native`, restart nvim

    - nvim use `:Copilot setup`

    - nvim use `:Copilot auth`, use your `fabio-rojas-tfs` and Keeper auth to login github

      - After login to GitHub using browser as `fabio-rojas-tfs`, go to `https://github.com/login/device` and enter the code that was generated when you ran `:Copilot auth`

    - nvim `Copilot <cmds>` are `attach, auth, detach, disable, enable, panel, status, suggestion, toggle, version`
