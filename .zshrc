alias stree='open -a SourceTree ./'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias simu='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias ll='ls -al'
alias ls='ls -GFh'
alias mux="tmuxinator"

# Use local npm binaries over global npm binaries
export PATH=./node_modules/.bin:${PATH}

# zsh plugins
source $HOME/Workspace/dotfiles/antigen.zsh

# Vim-like key binding
antigen bundle jeffreytse/zsh-vi-mode

# zsh auto suggestion
antigen bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D7D7D7,underline"

# zsh to display git + env version
antigen theme denysdovhan/spaceship-prompt

# Various auto-completions in zsh
# Used for tmuxinator, nvm
# https://github.com/zsh-users/zsh-completions/tree/master/src
antigen bundle zsh-users/zsh-completions

# zsh autocomplete
autoload -U compinit && compinit

# zsh-syntax-highlighting must be the last!
antigen bundle zsh-users/zsh-syntax-highlighting

# zsh appy antige
antigen apply

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Android Studio
export ANDROID_HOME=~/Library/Android/sdk
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
