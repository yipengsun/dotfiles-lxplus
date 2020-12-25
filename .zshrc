# vim: ts=2 sw=2 et nofoldenable

##################
# Plugin manager #
##################
# Currently use zinit

source ~/.zinit/bin/zinit.zsh


############
# Settings #
############

autoload -U colors && colors

setopt complete_aliases        # Do not expand aliases before_ completion has finished
setopt auto_pushd              # Automatically pushd directories on dirstack
setopt auto_continue           # Automatically send SIGCON to disowned jobs
setopt extended_glob           # So that patterns like ^() *~() ()# can be used
setopt pushd_ignore_dups       # Do not push dups on stack
setopt pushd_silent            # Be quiet about pushds and popds
setopt brace_ccl               # Expand alphabetic brace expressions
setopt complete_in_word        # Stay where it is and completion is done from both ends
setopt correct                 # Spell check for commands only
setopt hash_list_all           # Search all paths before command completion
setopt hist_ignore_all_dups    # When runing a command several times, only store one
setopt hist_ignore_space       # Do not remember commands starting with space
setopt share_history           # Share history among sessions
setopt hist_verify             # Reload full command when runing from history
setopt hist_expire_dups_first  # Remove dups when max size reached
setopt list_types              # Show ls -F style marks in file completion
setopt long_list_jobs          # Show pid in bg job list
setopt numeric_glob_sort       # When globbing numbered files, use real counting
setopt no_hist_beep            # Don not beep on history expansion errors
setopt hist_reduce_blanks      # Reduce whitespace in history
setopt interactive_comments    # Comments in history
setopt inc_append_history      # Append to history once executed

# Exclude '/' from WORDCHARS so <Ctrl-w> will only delete part of the path
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# Comamnd history
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=$HOME/.cache/zsh/zsh_history

# Colored man pages
# bold & blinking mode
export LESS_TERMCAP_mb="${fg_bold[red]}"
export LESS_TERMCAP_md="${fg_bold[red]}"
export LESS_TERMCAP_me="${reset_color}"
# standout mode
export LESS_TERMCAP_so="${fg_bold[yellow]}${bg[blue]}"
export LESS_TERMCAP_se="${reset_color}"
# underlining
export LESS_TERMCAP_us="${fg_bold[green]}"
export LESS_TERMCAP_ue="${reset_color}"


###########################
# Environmental variables #
###########################

export EDITOR=vim
export VISUAL=vim

export PAGER=less
export READNULLCMD=less
export LESS="-M -i -R --shift 5"
export LESSCHARSET=utf-8

# Customize ls output color scheme
[[ -f $HOME/.lscolors ]] && eval $(dircolors -b $HOME/.lscolors)


##############
# Completion #
##############

autoload -Uz compinit && compinit

# use cache to speed up completion
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $HOME/.cache/zsh

# Completion options
zstyle ':completion:*:matches' group            'yes'
zstyle ':completion:*'         group-name       ''
zstyle ':completion:*:options' description      'yes'
zstyle ':completion:*:options' auto-description '%d'

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# Configure completion list module
zmodload -i zsh/complist
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Ignore folders that are part of current path
zstyle ':completion:*' ignore-parents parent pwd directory

# Force rehash when command not found
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

# Menu select in completion
zstyle ':completion:*'               menu select=2
zstyle ':completion:*'               completer _oldlist _expand _force_rehash _complete _match
zstyle ':completion:*:match:*'       original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Completion prompt format
zstyle ':completion:*:descriptions' format "${bg_bold[yellow]} %d ${reset_color}"
zstyle ':completion:*:messages'     format "${bg_bold[yellow]} %d ${reset_color}"
zstyle ':completion:*:warnings'     format "${bg_bold[red]} no match found ${reset_color}"
zstyle ':completion:*:corrections'  format "${bg_bold[red]} %d (errors: %e) ${reset_color}"


###############
# Keybindings #
###############

autoload -U zkbd

# Use emacs style keybindings
bindkey -e

# Install fzf locally
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# fzf search history
fzf_use_tmux() {
  [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
}

fzf_cmd() {
  fzf_use_tmux &&
    echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst pipefail 2> /dev/null
  selected=( $(fc -l 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS +s --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(q)LBUFFER} +m" $(fzf_cmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

# Allow 'cd ...'
expand-multiple-dots() {
  local MATCH
  if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
    LBUFFER=$LBUFFER:fs%\.\.\.%../..%
  fi
}

expand-multiple-dots-then-expand-or-complete() {
  zle expand-multiple-dots
  zle expand-or-complete
}

expand-multiple-dots-then-accept-line() {
  zle expand-multiple-dots
  zle accept-line
}

zle -N expand-multiple-dots
zle -N expand-multiple-dots-then-expand-or-complete
zle -N expand-multiple-dots-then-accept-line

bindkey '^I' expand-multiple-dots-then-expand-or-complete
bindkey '^M' expand-multiple-dots-then-accept-line

# Add 'sudo' to current line
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  zle end-of-line
}

zle -N sudo-command-line

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

for k in ${(k)key} ; do
  [[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
done

# Set up key accordingly
[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-history
[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-history
[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char

autoload history-search-end
autoload -U edit-command-line

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N edit-command-line

# Fallback mapping for tmux
bindkey '\e\e' sudo-command-line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[6~' history-beginning-search-forward-end
bindkey '^[[5~' history-beginning-search-backward-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^J' backward-word
bindkey '^K' forward-word
bindkey '^\' edit-command-line

# Use the vi navigation keys besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char         # left
bindkey -M menuselect 'k' vi-up-line-or-history    # up
bindkey -M menuselect 'l' vi-forward-char          # right
bindkey -M menuselect 'j' vi-down-line-or-history  # bottom


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

ZSH_HIGHLIGHT_STYLES[default]='bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=yellow,underline,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=yellow,underline,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='bold'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=yellow,underline,bold'
ZSH_HIGHLIGHT_STYLES[path]='underline,bold'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='bold'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution]='bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[process-substitution]='bold'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[assign]='bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[named-fd]='bold'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'


##########################
# Host-specific settings #
##########################

[[ -f $HOME/.zshrc.host ]] && source $HOME/.zshrc.host
