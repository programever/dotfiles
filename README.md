# Make symbolic link
ln -s  ~/Workspace/dotfiles/.gitconfig ~/.gitconfig
ln -s  ~/Workspace/dotfiles/.zshrc ~/.zshrc
ln -s  ~/Workspace/dotfiles/.tmux.conf ~/.tmux.conf
ln -s  ~/Workspace/dotfiles/.gemrc ~/.gemrc

mkdir .config
ln -s  ~/Workspace/dotfiles/tmuxinator ~/.config/tmuxinator

mkdir .config/nvim
ln -s  ~/Workspace/dotfiles/init.lua ~/.config/nvim/init.lua

# Presetup
- Install Xcode
- Install brew
- Install nvm + latest node 20
- Install `brew install tmuxinator tmux neovim python3 git-delta`
- Install `npm install -g neovim`

# Setup python3
cd ~/Workspace/dotfiles
mkdif ./pyenv
python3 -m venv ./pyenv
source ./pyenv/bin/activate
pip install pynvim
cd ~

# Installation for init.lua
brew tap homebrew/cask-fonts 
brew install font-fira-code-nerd-font fzf fd bat ripgrep git-delta tree-sitter stylua lua-language-server
npm install -g @fsouza/prettierd typescript typescript-language-server

# Neovim
Run :checkhealth ensure it is OK

# Iterm
- Preference -> Profile -> Keys -> Keys mapping - Add Shift+Return to Send Hex Code: 0x1B
- Preference -> Geneal -> Selection -> Applications in terminal may access clipboard
- Preference -> Profile -> Text -> Font use FiraCode Nerd and Use ligatures -> Font size 14

# Others
brew install stylemistake/formulae/runner
npm install -g spago

# Copilot
brew install gh
gh auth login
gh extension install github/gh-copilot
Run in neovim: `:Copilot setup`
