[ -z "$PS1" ] && return

export LANG=ja_JP.UTF-8

bindkey -e
bindkey "^[[Z" reverse-menu-complete
bindkey '^R' history-incremental-pattern-search-backward

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

PROMPT='[%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%d%f%b]# '
RPROMPT='[%*]'
SPROMPT='correct: %R -> %r ? '

select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

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

alias ..='cd ..'
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '
alias -g L='| less'
alias -g G='| grep'
alias ls='ls -F --color=auto'

function cd()
{
  builtin cd $@ && ls;
}

export SDL_VIDEO_X11_DGAMOUSE=0