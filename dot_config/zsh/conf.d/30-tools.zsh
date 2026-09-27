# Each line runs only if the tool is installed.
(( $+commands[fzf] ))    && source <(fzf --zsh)        # Ctrl-R history, Ctrl-T files (fzf 0.48+)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"  # `z proj` jumps to a folder
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"  # per-project .envrc
