# vim: set nofoldenable:

##################
# Plugin manager #
##################
# Currently use zinit

source ~/.zinit/bin/zinit.zsh


###############
# Keybindings #
###############

# Install 'fzf' locally
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin


##########
# Prompt #
##########

# Pure prompt
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure


####################
# Syntax highlight #
####################
# This must be loaded at the end of the config

zinit load zsh-users/zsh-syntax-highlighting

# Color scheme for 'main'
typeset -A ZSH_HIGHLIGHT_STYLES

${ZSH_HIGHLIGHT_STYLES[default]:=bold}
${ZSH_HIGHLIGHT_STYLES[reserved-word]:=fg=yellow,bold}
${ZSH_HIGHLIGHT_STYLES[suffix-alias]:=fg=green,underline,bold}
${ZSH_HIGHLIGHT_STYLES[global-alias]:=fg=cyan,bold}
${ZSH_HIGHLIGHT_STYLES[precommand]:=fg=green,underline,bold}
${ZSH_HIGHLIGHT_STYLES[commandseparator]:=bold}
${ZSH_HIGHLIGHT_STYLES[autodirectory]:=fg=green,underline,bold}
${ZSH_HIGHLIGHT_STYLES[path]:=underline,bold}
${ZSH_HIGHLIGHT_STYLES[path_pathseparator]:=bold}
${ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]:=bold}
${ZSH_HIGHLIGHT_STYLES[globbing]:=fg=blue,bold}
${ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=blue,bold}
${ZSH_HIGHLIGHT_STYLES[command-substitution]:=bold}
${ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]:=fg=magenta,bold}
${ZSH_HIGHLIGHT_STYLES[process-substitution]:=bold}
${ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]:=fg=magenta,bold}
${ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=bold}
${ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=bold}
${ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=bold}
${ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]:=fg=magenta,bold}
${ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=yellow,bold}
${ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=yellow,bold}
${ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]:=fg=yellow,bold}
${ZSH_HIGHLIGHT_STYLES[rc-quote]:=fg=cyan,bold}
${ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=cyan,bold}
${ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=cyan,bold}
${ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]:=fg=cyan,bold}
${ZSH_HIGHLIGHT_STYLES[assign]:=bold}
${ZSH_HIGHLIGHT_STYLES[redirection]:=fg=yellow,bold}
${ZSH_HIGHLIGHT_STYLES[comment]:=fg=black,bold}
${ZSH_HIGHLIGHT_STYLES[named-fd]:=bold}
${ZSH_HIGHLIGHT_STYLES[numeric-fd]:=bold}
${ZSH_HIGHLIGHT_STYLES[arg0]:=fg=blue,bold}
