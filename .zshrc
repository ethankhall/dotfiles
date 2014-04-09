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
export NOTE_DIR=~/Documents/notes

function todays_note() {
    echo $NOTE_DIR/`date +"%Y/%B/%m-%d-%y.markdown" | tr "[A-Z]" "[a-z]"`
}

function take_note () {
    NOTE_FILE=`todays_note`
    NOTE_FILE_DIR=`dirname $NOTE_FILE`
 
    echo "Taking note in $NOTE_FILE"
    [ -d  $NOTE_FILE_DIR ] || mkdir $NOTE_FILE_DIR
    #Edit file
    vim $NOTE_FILE
    
    #Add file to git
    git -C $NOTE_FILE_DIR add $NOTE_FILE
    
    #Auto commit of there are changes
    if ! git -C $NOTE_FILE_DIR diff-index --quiet HEAD --; then
        git -C $NOTE_FILE_DIR commit -m "File updates to $NOTE_FILE on $(date)"
    fi
}

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

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/boxen/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
