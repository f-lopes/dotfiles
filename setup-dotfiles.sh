#!/bin/bash

USER_DIRECTORY=~/
DOTFILES_DIRECTORY=~/dotfiles
BACKUP_DIRECTORY=~/dotfiles-backup
DOTFILES=".gitconfig .gitignore_global .aliases .bash_profile"

echo -n "Installing git dotfiles in ${USER_DIRECTORY}"

for dotfile in ${DOTFILES};
do
  echo "${dotfile} -> ${DOTFILES_DIRECTORY}/${dotfile}"
  ln -s ${DOTFILES_DIRECTORY}/${dotfile} ${dotfile}
done
