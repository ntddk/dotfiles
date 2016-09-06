#!/bin/sh

cd $(dirname $0)

if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi

if [ ! -d ~/.pyenv/ ]; then
    mkdir -p ~/.pyenv/
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv/
fi

if [ ! -z $TMUX_ENV ]; then
    echo "set-option -g prefix C-t" > ~~~tmp
    echo ".tmux.conf setting for remote."
else
    echo "set-option -g prefix C-g" > ~~~tmp
    echo ".tmux.conf setting for local."
fi
cat ~~~tmp tmux.conf > ~~~tmux.conf
mv ~~~tmux.conf .tmux.conf
rm -f ~~~tmp

for file in `find $HOME/dotfiles -name '.*' | grep -v 'dotfiles/.git$' | perl -nle 'm!dotfiles/(.+)$! and print $1'`; do
    ln -s -f $HOME/dotfiles/$file $HOME/$file
done

chsh -s $(which zsh)

echo "Finished!"
