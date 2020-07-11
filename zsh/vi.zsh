# Updates editor information when the keymap changes.
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
# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

bindkey -M vicmd "i" vi-insert
bindkey -M vicmd "A" vi-insert-bol
bindkey -M vicmd "l" vi-backward-char
bindkey -M vicmd "h" vi-forward-char
bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line
bindkey -M vicmd "j" down-line-or-history
bindkey -M vicmd "k" up-line-or-history
bindkey -M vicmd "u" undo
#bindkey -M vicmd "-" vi-rev-repeat-search
bindkey -M vicmd "=" vi-repeat-search
bindkey -M vicmd "b" vi-forward-word-end


# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${VI_KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi

