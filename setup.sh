#!/bin/sh

cd $(dirname $0)

if [ ! -f ~/.vim/colors/wombat256.vim ]; then
    mkdir -p ~/.vim/colors/
    git clone https://github.com/vim-scripts/wombat256.vim.git ~/wombat256.vim
    mv ~/wombat256.vim/colors/wombat256mod.vim ~/.vim/colors/wombat256.vim 
    rm -rf ~/wombat256.vim
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
