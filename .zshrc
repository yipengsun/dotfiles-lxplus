###########
# Plugins #
###########
# Currently managed by zinit

# Initialize zinit plugin manager
source ~/.zinit/bin/zinit.zsh

# Pure prompt
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Syntax high light
zinit light zdharma/fast-syntax-highlighting

# Install 'fzf' locally
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin
