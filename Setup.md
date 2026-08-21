# 1. Dropbox first
Install Dropbox and sign in. Wait until these are synced before anything else:
- ~/Dropbox/Documents/Migrating  (ssh, aws, zsh_secrets)
- ~/Dropbox/Note

# 2. Presetup
- Install Xcode (App Store), then `xcode-select --install`
- Install brew
- Install nvm, then the Node versions the projects pin (alpha=20, papa=22, ts-bedrock=24):
  `nvm install 20 && nvm install 22 && nvm install 24 && nvm alias default 22`
- Install latest rust (rustup), then `rustup component add rust-analyzer`
- `brew tap hashicorp/tap`
- `brew install android-platform-tools stylemistake/formulae/runner tmuxinator tmux neovim python3 gh fzf fd bat ripgrep git-delta git-lfs tree-sitter tree-sitter-cli stylua lua-language-server gitui ranger hashicorp/tap/terraform antigen bash coreutils gum jq awscli httpie just gnupg ffmpeg watchman cocoapods fastlane mysql-client@8.4 sqlcmd code2prompt yt-dlp`
- `brew install --cask font-fira-code-nerd-font ngrok localxpose vlc`
- `npm install -g neovim @fsouza/prettierd typescript typescript-language-server vscode-langservers-extracted elm elm-test elm-format @elm-tooling/elm-language-server`
- Install Docker Desktop (papa + alpha need it)
- Install Claude desktop app

# 3. Restore secrets
mkdir ~/.ssh
cp -r ~/Dropbox/Documents/Migrating/ssh/* ~/.ssh

mkdir ~/.aws
cp -r ~/Dropbox/Documents/Migrating/aws/* ~/.aws

cp ~/Dropbox/Documents/Migrating/zsh_secrets ~/.zsh_secrets

# 4. Make symbolic links
Restore ~/Workspace first (unzip the backup, or clone each repo — dotfiles and alpha are needed for the links below; ts-bedrock-validator is a private repo).

mkdir ~/Workspace/dotfiles/Note
ln -s ~/Dropbox/Note/* ~/Workspace/dotfiles/Note

mkdir -p ~/.config/nvim/lua/alpha
mkdir -p ~/.config/gitui
ln -s ~/Workspace/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Workspace/dotfiles/.zshrc ~/.zshrc
ln -s ~/Workspace/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Workspace/dotfiles/.gemrc ~/.gemrc
ln -s ~/Workspace/dotfiles/ranger ~/.config/ranger
ln -s ~/Workspace/dotfiles/.gitui-keys.ron ~/.config/gitui/key_bindings.ron
ln -s ~/Workspace/dotfiles/.gitui-theme.ron ~/.config/gitui/theme.ron
ln -s ~/Workspace/dotfiles/tmuxinator ~/.config/tmuxinator
ln -s ~/Workspace/dotfiles/init.lua ~/.config/nvim/init.lua
ln -s ~/Workspace/alpha/lua/init.lua ~/.config/nvim/lua/alpha/init.lua

## Claude Code (Workspace context + rules, Alpha's memory)
mkdir -p ~/.claude/projects/-Users-iker-Workspace
ln -s ~/Workspace/dotfiles/claude/CLAUDE-Alpha.md ~/Workspace/CLAUDE.md
ln -s ~/Workspace/dotfiles/claude/memory ~/.claude/projects/-Users-iker-Workspace/memory
- The memory path is derived from the Workspace path; it only works if Workspace is at ~/Workspace.

# 5. 1Password
brew install --cask 1password-cli
- Open the 1Password desktop app.
- Go to Settings (⌘ ,) → Developer.
- Turn on "Integrate with 1Password CLI".

# 6. Claude Code CLI
brew install --cask claude-code
claude auth login
- Needed on top of the Claude desktop app: the app's login is not shared with the standalone `claude` binary, and headless `claude -p` (used by `~/Workspace/ts-bedrock-validator/bin/validate.sh`) needs its own login.
- Check with `claude auth status` (expect `"loggedIn": true`).

# 7. python3
cd ~/Workspace/dotfiles
mkdir ./pyenv
python3 -m venv ./pyenv
source ./pyenv/bin/activate
pip install pynvim

# 8. Neovim
Run :checkhealth ensure it is OK
Run :Lazy ensure it is OK

# 9. Iterm
- Preference -> Profile -> Keys -> Keys mapping - Add Shift+Return to Send Hex Code: 0x1B
- Preference -> Geneal -> Selection -> Applications in terminal may access clipboard
- Preference -> Profile -> Text -> Font use FiraCode Nerd and Use ligatures -> Font size 14
