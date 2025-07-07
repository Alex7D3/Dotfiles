# Dotfiles
My configuration files. This includes my neovim setup, tmux, fonts, etc.

## Installation
Clone the repository, and run `install.sh` from within the root folder:
```bash
git clone https://github.com/Alex7D3/Dotfiles
cd ./Dotfiles
./install.sh
```
This adds symlinks from within the home folder pointing to the repository folder, so files can be version controlled.

The install script also appends scripts and settings into configuration folders (`~/.bashrc` or `~/.zshrc`).
The installation is interactive, but all prompts can be skipped by passing `-y` to `install.sh`.
