# The ideal way to install with autocompletion

Clone repo and run install script, on older machines I install only the binary but I typically use brew to install fzf

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Using Homebrew

- Installed: `brew install fzf`

- To create the `.fzf.zsh` run: `(fzf --zsh) > ~/.fzf.zsh`

  - Add to `.my_custom_zshrc` the line: `[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh`

## Articles

- [Finding using fzf](https://www.redhat.com/en/blog/fzf-linux-fuzzy-finder)
