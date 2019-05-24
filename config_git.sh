#!bin/bash

# Pretty print
git config --global alias.lg "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold dim green)(%ar)%C(reset) %C(cyan)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold magenta)%d%C(reset)' --all"
