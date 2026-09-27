mkcd() { mkdir -p -- "$1" && cd -- "$1" }        # make a dir and cd into it
zsh-startup() { repeat 5 { time zsh -i -c exit } } # measure startup time
