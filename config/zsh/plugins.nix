params: with params.pkgs; ''
safe_source $HOME/.zlocals
safe_source $HOME/.local/share/zsh/syntax/zsh-syntax-highlighting.zsh
safe_source ${fzf}/share/fzf/key-bindings.zsh

eval "$(starship init zsh)"
''
