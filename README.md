# Make symbolic link
ln -s  ~/Workspace/dotfiles/.zshrc ~/.zshrc
ln -s  ~/Workspace/dotfiles/.tmux.conf ~/.tmux.conf
ln -s  ~/Workspace/dotfiles/.gemrc ~/.gemrc

mkdir .config
ln -s  ~/Workspace/dotfiles/tmuxinator ~/.config/tmuxinator

mkdir .config/nvim
ln -s  ~/Workspace/dotfiles/init.lua ~/.config/nvim/init. lua

# Presetup
- Install Xcode
- Install brew
- Install nvm + latest node 20
- Install `brew install tmuxinator tmux neovim python3`
- Install `npm install -g neovim`

# Setup python3
cd ~/Workspace/dotfilespython3
python3 -m venv ./pyenv
source ./pyenv/bin/activate
pip install pynvim

# Installation for init.lua
brew tap homebrew/cask-fonts 
brew install font-fira-code-nerd-font fzf fd bat ripgrep git-delta tree-sitter stylua lua-language-server
npm install -g @fsouza/prettierd typescript typescript-language-server

# Neovim
Run :checkhealth ensure it is OK

# Iterm
- Preference -> Profile -> Keys -> Keys mapping - Add Shift+Return to Send Hex Code: 0x1B
- Preference -> Geneal -> Selection -> Applications in terminal may access clipboard
- Preference -> Profile -> Text -> Font use FiraCode Nerd and Use ligatures

# Others
brew install stylemistake/formulae/runner
npm install -g spago
