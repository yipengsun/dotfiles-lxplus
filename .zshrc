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

zinit light zsh-users/zsh-syntax-highlighting
