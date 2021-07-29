# vi-mode, taken directly from omz

function zle-keymap-select() {
    # update keymap variable for the prompt
    VI_KEYMAP=$KEYMAP
    zle reset-prompt
    zle -R
}

zle -N zle-keymap-select

function vi-accept-line() {
    VI_KEYMAP=main
    zle accept-line
}

zle -N vi-accept-line
bindkey -v

# use custom accept-line widget to update $VI_KEYMAP
bindkey -M vicmd '^J' vi-accept-line
bindkey -M vicmd '^M' vi-accept-line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
    MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
    echo "${${VI_KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

RPS1='$(vi_mode_prompt_info)'

# vim mode is undesirable for some keys
[[ ! -z "$terminfo[kLFT5]" ]] && bindkey "$terminfo[kLFT5]" backward-word # ctrl+left
[[ ! -z "$terminfo[kRIT5]" ]] && bindkey "$terminfo[kRIT5]" forward-word # ctrl+right
bindkey "$terminfo[kich1]" overwrite-mode # insert
bindkey "$terminfo[kdch1]" delete-char # del
