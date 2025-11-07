# Make symbolic link
mkdir ~/.ssh
cp -r ~/Dropbox/Documents/Migrating/ssh/* ~/.ssh

mkdir ~/.aws
cp -r ~/Dropbox/Documents/Migrating/aws/* ~/.aws

mkdir ~/Workspace/dotfiles/Note
ln -s ~/Dropbox/Note/* ~/Workspace/dotfiles/Note

cp ~/Dropbox/Documents/Migrating/zsh_secrets ~/.zsh_secrets

mkdir -p ~/.config/nvim/lua/alpha
mkdir -p ~/.config/gitui
ln -s ~/Workspace/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Workspace/dotfiles/.zshrc ~/.zshrc
ln -s ~/Workspace/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Workspace/dotfiles/.gemrc ~/.gemrc
ln -s ~/Workspace/dotfiles/ranger ~/.config/ranger
ln -s ~/Workspace/dotfiles/.gitui-keys.ron ~/.config/gitui/key_bindings.ron
ln -s ~/Workspace/dotfiles/.gitui-theme.ron ~/.config/gitui/theme.ron
ln -s ~/Workspace/alpha/lua/init.lua ~/.config/nvim/lua/alpha/init.lua

mkdir .config
ln -s  ~/Workspace/dotfiles/tmuxinator ~/.config/tmuxinator

mkdir .config/nvim
ln -s  ~/Workspace/dotfiles/init.lua ~/.config/nvim/init.lua

# Presetup
- Install Xcode
- Install brew
- Install nvm + latest node 20
- Install `brew install android-platform-tools stylemistake/formulae/runner tmuxinator tmux neovim python3 gh font-fira-code-nerd-font fzf fd bat ripgrep git-delta tree-sitter tree-sitter-cli stylua lua-language-server gitui ranger hashicorp/tap/terraform`
- Install `brew tap homebrew/cask-fonts hashicorp/tap`
- Install `npm install -g neovim spago @fsouza/prettierd typescript typescript-language-server purescript-language-server purs-tidy vscode-langservers-extracted`

# 1Password
brew install --cask 1password-cli
- Open the 1Password desktop app.
- Go to Settings (⌘ ,) → Developer.
- Turn on "Integrate with 1Password CLI".

# python3
cd ~/Workspace/dotfiles
mkdir ./pyenv
python3 -m venv ./pyenv
source ./pyenv/bin/activate
pip install pynvim

# Neovim
Run :checkhealth ensure it is OK
Run :Lazy ensure it is OK

# Iterm
- Preference -> Profile -> Keys -> Keys mapping - Add Shift+Return to Send Hex Code: 0x1B
- Preference -> Geneal -> Selection -> Applications in terminal may access clipboard
- Preference -> Profile -> Text -> Font use FiraCode Nerd and Use ligatures -> Font size 14

