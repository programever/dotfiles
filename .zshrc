alias stree='open -a SourceTree ./'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# PHP
export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"

# PG_DUMP
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export CLICOLOR=1
export LS_COLORS=GxFxCxDxBxegedabagaced
export LC_ALL='en_US.UTF-8'  
export LANG='en_US.UTF-8'
export EDITOR='nvim'
alias ll='ls -al'
alias ls='ls -GFh'

# zsh plugins
source $HOME/Workspace/dotfiles/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D7D7D7,underline"

antigen theme denysdovhan/spaceship-prompt

# Various auto-completions in zsh
# Used for tmuxinator, nvm
# https://github.com/zsh-users/zsh-completions/tree/master/src
antigen bundle zsh-users/zsh-completions

# zsh-syntax-highlighting must be the last!
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Vim-like key binding
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Movement-1
bindkey '' vi-backward-char # move left
bindkey '' autosuggest-accept # move right to accept suggestion
bindkey '' vi-backward-word # move left by a word
bindkey '' vi-forward-word # move right by a word
bindkey '' vi-beginning-of-line
bindkey '' vi-end-of-line
bindkey '' backward-delete-word

# Load zsh autocomplete
autoload -U compinit && compinit

# Use local npm binaries over global npm binaries
export PATH=./node_modules/.bin:${PATH}

# TMUX
alias mux="tmuxinator"

# XCODE
alias symbolicatecrash="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"
export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"

# ANDROID STUDIO
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

# GRADLE
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/iker/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/iker/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/iker/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/iker/google-cloud-sdk/completion.zsh.inc'; fi
