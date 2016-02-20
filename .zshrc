[ -z "$PS1" ] && return

export LANG=ja_JP.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GREP_OPTIONS='--color=auto'
export SDL_VIDEO_X11_DGAMOUSE=0
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/usr/local/heroku/bin:$PATH"

bindkey -e
bindkey "^[[Z" reverse-menu-complete
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^[^B' vi-backward-blank-word
bindkey '^[^F' vi-forward-blank-word
bindkey '^[^U' backward-delete-word
bindkey '^[^K' delete-word

eval $(dircolors -b)

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

PROMPT='[%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%d%f%b]# '
#RPROMPT='[%*]'
SPROMPT='correct: %R -> %r ? '

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

function _delete-char-or-list-expand() {
    if [[ -z "${RBUFFER}" ]]; then
        zle list-expand
    else
        zle delete-char
    fi
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand

function _kill-backward-blank-word() {
    zle set-mark-command
    zle vi-backward-blank-word
    zle kill-region
}
zle -N _kill-backward-blank-word
bindkey '^Y' _kill-backward-blank-word

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^O" history-beginning-search-backward-end

autoload -U modify-current-argument
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}

zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quotus-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double

autoload -Uz select-word-style
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz compinit
compinit
autoload -Uz colors
colors

setopt correct
setopt auto_list
setopt auto_pushd
setopt auto_menu
setopt list_types
setopt list_packed
setopt print_eight_bit
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob
unset caseglob

alias d='cd'
alias ..='cd ..'
alias la='ls -a'
alias ll='ls -la'
alias ks='ls'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '
alias -g L='| less'
alias -g G='| grep'
alias ls='ls -F --color=auto'
alias q=`exit`
alias fuck='eval $(thefuck $(fc -ln -1))'
alias FUCK='fuck'

function cd()
{
    builtin cd $@ && ls;
}

function aslr(){
    ASLR=`cat /proc/sys/kernel/randomize_va_space`
    if [ $ASLR = '2' ]; then
        RPROMPT='[%*][%F{red}ASLR%f]'
    else
        RPROMPT='[%*][%F{blue}NO ASLR%f]'
fi
}
precmd(){ aslr }

setxkbmap -option ctrl:nocaps
