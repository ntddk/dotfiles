#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ ! -f ~/.vim/colors/wombat256.vim ]; then
    mkdir -p ~/.vim/colors/
    git clone https://github.com/vim-scripts/wombat256.vim.git $SCRIPT_DIR/wombat256.vim
    mv $SCRIPT_DIR/wombat256.vim/colors/wombat256mod.vim ~/.vim/colors/wombat256.vim
    rm -rf $SCRIPT_DIR/wombat256.vim
fi

if [ ! -d ~/.vim/rc/ ]; then
    mkdir -p ~/.vim/rc
    ln -Fis $SCRIPT_DIR/dein.toml ~/.vim/rc/
    ln -Fis $SCRIPT_DIR/dein_lazy.toml ~/.vim/rc/
fi

if [ ! -d ~/.pyenv/ ]; then
    mkdir -p ~/.pyenv/
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv/
fi

if [ ! -d ~/.rbenv/ ]; then
    mkdir -p ~/.rbenv/
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

if [ ! -d ~/.nvm/ ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
fi

if [ ! -d ~/.goenv/ ]; then
    mkdir -p ~/.goenv/
    git clone https://github.com/wfarr/goenv.git ~/.goenv
fi

if [ ! -d ~/.cargo/ ]; then
    curl https://sh.rustup.rs -sSf | sh
fi

if [ ! -d ~/.peda/ ]; then
    git clone https://github.com/longld/peda.git ~/.peda
fi

if [ ! -d ~/.pwngdb/ ]; then
    git clone https://github.com/scwuaptx/Pwngdb.git ~/.pwngdb
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
