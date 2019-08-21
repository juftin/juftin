# SOURCE

# USE THE BASH_ALIASES FILE TO STORE ALIASES
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#variable exports
export CLICOLOR=1

# PROMPT: user@host date time working directory newline
#    Black      0;30       Dark Gray    1;30
#    Red        0;31       Bold Red     1;31
#    Green      0;32       Bold Green   1;32
#    Yellow     0;33       Bold Yellow  1;33
#    Blue       0;34       Bold Blue    1;34
#    Purple     0;35       Bold Purple  1;35
#    Cyan       0;36       Bold Cyan    1;36
#    Light Gray 0;37       White        1;37
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
export PS1=$'\[\033[38;5;99m\]\u@\[\033[0m\]\[\033[0;31m\]$(tput smul)\h$(tput rmul) \[\033[39m\]\D{%Y-%m-%d %T}\[\033[38;5;76m\] \w\n\[\033[38;5;76m\]$ \[\033[0m\]'
# LS COLORS
#    a = black
#    b = red
#    c = green
#    d = brown
#    e = blue
#    f = magenta
#    g = cyan
#    h = grey
#    A = dark grey
#    B = bold red
#    C = bold green
#    D = yellow
#    E = bold blue
#    F = magenta
#    G = cyan
#    H = white
#    x = default

#    directory
#    symbolic link
#    socket
#    pipe
#    executable
#    block device
#    character device
#    executable with setuid set
#    executable with setguid set
#    directory writable by others, with sticky bit
#    directory writable by others, without sticky bit
export LSCOLORS=hxfxGxDxcxaDehhxhxcxcx
# export APP_OPEN_URL=http://localhost:9099/login/
shopt -s histappend
shopt -s histverify
shopt -s hostcomplete
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=2048576
export HISTSIZE=1000000

export EDITOR="vim"

export PYTHONPATH="$PYTHONPATH:/Users/justin/Documents/git/myStrength_Analytics/integrations/pybase"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##
# Your previous /Users/justin/.bash_profile file was backed up as /Users/justin/.bash_profile.macports-saved_2019-08-20_at_17:28:54
##

# MacPorts Installer addition on 2019-08-20_at_17:28:54: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias wut)
eval $(thefuck --alias '?')
