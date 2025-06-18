# Make symbolic link
ln -s ~/Workspace/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Workspace/dotfiles/.zshrc ~/.zshrc
ln -s ~/Workspace/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Workspace/dotfiles/.gemrc ~/.gemrc
ln -s ~/Workspace/dotfiles/ranger ~/.config/ranger
ln -s ~/Workspace/dotfiles/.gitui-keys.ron ~/.config/gitui/key_bindings.ron
ln -s ~/Workspace/dotfiles/.gitui-theme.ron ~/.config/gitui/theme.ron

mkdir .config
ln -s  ~/Workspace/dotfiles/tmuxinator ~/.config/tmuxinator

mkdir .config/nvim
ln -s  ~/Workspace/dotfiles/init.lua ~/.config/nvim/init.lua

# .zsh_secrets
export OPENAI_API_KEY=""
export ANTHROPIC_API_KEY=""

# Presetup
- Install Xcode
- Install brew
- Install nvm + latest node 20
- Install `brew install stylemistake/formulae/runner tmuxinator tmux neovim python3 gh font-fira-code-nerd-font fzf fd bat ripgrep git-delta tree-sitter stylua lua-language-server gitui ranger`
- Install `brew tap homebrew/cask-fonts`
- Install `npm install -g neovim spago @fsouza/prettierd typescript typescript-language-server purescript-language-server purs-tidy`

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

