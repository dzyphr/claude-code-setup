#!/usr/bin/env bash
#this prevents claude from pushing or committing to git but keeps other user's access

git config --global --unset-all url.DISABLED.pushInsteadOf

git config --file ~/.gitconfig-claude include.path ~/.gitconfig
git config --file ~/.gitconfig-claude url.DISABLED.pushInsteadOf https://github.com/
git config --file ~/.gitconfig-claude --add url.DISABLED.pushInsteadOf git@github.com:

echo "alias claude='GIT_CONFIG_GLOBAL=\$HOME/.gitconfig-claude claude'" >> ~/.bashrc
source ~/.bashrc
