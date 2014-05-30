autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}

zle -N zle-line-init
zle -N zle-line-finish

## Take note 
source $HOME/.zsh/.take_note

#################
##   History   ##
################
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

#############
##   Git   ##
#############
source  $HOME/.zsh/.zsh_shouse_prompt

## Reverse Search
bindkey "^R" history-incremental-search-backward

## Begining of line
bindkey "^A" beginning-of-line

## Color of ls
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#############
##   PS1   ##
#############
#if test "$(id -u)" != "0"; then
#	PS1="%B%* %{$fg[green]%}%n%{$reset_color%}%b@%B%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}% %b ${vcs_info_msg_0_} %# "
#else
#	PS1="%B%* %{$fg[red]%}%n%{$fg[white]%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}% %b$ "
#fi
################
##   export   ##
################
export EDITOR=vim

###############
##   alias   ##
###############

### Linux Alias ###
#alias ls='ls --color=auto'
#alias grep='grep --colour=auto'

if [ -f /opt/boxen/env.sh ]; then
    source /opt/boxen/env.sh
fi

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/boxen/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
