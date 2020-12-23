# Initialize zinit plugin manager
source ~/.zinit/bin/zinit.zsh

# Pure prompt
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Syntax high light
zinit light zdharma/fast-syntax-highlighting
