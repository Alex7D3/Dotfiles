#!/usr/bin/env bash

if [[ "$1" =~ --[yY][eE][sS]|-[yY] ]]; then
	shift
	confirm() { return 0; }
else
	confirm() {
		read -p "$1 [Y/n] " ans
		case "$ans" in
			[yY][eE][sS]|[yY])
				return 0;;
			*)
				return 1;;
		esac
	}
fi

echo 'Linking files...'
confirm '.config/nvim?' && ln -sfv "$PWD/nvim"            ~/.config/
confirm '.tmux.conf?'   && ln -sfv "$PWD/tmux/.tmux.conf" ~/.tmux.conf

[ -L "$HOME/.config/nvim" ] && nvim --headless "+Lazy! sync" +qa >/dev/null
[ -L "$HOME/.tmux.conf" ] && tmux source-file "$HOME/.tmux.conf"

shell=$(basename $SHELL)
config_file="$HOME/.${shell}rc"

shopt -s dotglob
for extension_file in shell/*; do
	base=$(basename $extension_file)
	confirm "$base?" || continue

	ln -sfv "$PWD/$extension_file" "$HOME/$base"

	if ! grep -q "\(\.\|source\) ~/$base" $config_file; then
		echo "[ -f ~/$base ] && . ~/$base" | tee -a $config_file
	fi
done
shopt -u dotglob

# Download nerd font and apply it:
if confirm 'nerd font?'; then
	case $(uname) in
		Linux)
			font=FiraMono
			ver=v3.4.0
			font_dir="$HOME/.local/share/fonts"
			mkdir -p $font_dir
			;;
		Darwin)
			font=Hack
			ver=v3.4.0
			font_dir="$HOME/Library/Fonts"
			;;
		*)
			echo "Unsupported OS for nerd fonts: $(uname)" >&2 ;;
	esac
	curl -fLsS "https://github.com/ryanoasis/nerd-fonts/releases/download/$ver/$font.zip" \
		-o "/tmp/$font.zip"
	unzip -oq "/tmp/$font.zip" -d "/tmp/$font"
	cp /tmp/"$font"/*.ttf /tmp/"$font"/*.otf $font_dir 2>/dev/null
	fc-cache -fv >/dev/null && echo "Font downloaded and configured."
fi

# Download git shell prompt script:
if confirm 'git shell prompt?'; then

	curl -fLsS https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh \
		-o "$HOME/.git-prompt.sh"
	if [ $? -eq 0 ] && ! grep -q "\(\.\|source\) ~/.git-prompt.sh" $config_file; then
		echo '. ~/.git-prompt.sh' | tee -a $config_file
	fi

	case $shell in
		bash) prompt='PS1=${PS1%\\\$ }'\''\[\033[35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '\' ;;
		zsh) prompt='setopt PROMPT_SUBST ; PS1='\''[%n@%m %c$(__git_ps1 " (%s)")]\$ '\' ;;
		*) echo "Unsupported shell for prompt: $shell" >&2 ;;
	esac
	if [ -n "$prompt" ] && ! grep -qF "$prompt" "$config_file"; then
		echo "$prompt" | tee -a $config_file
		echo "Prompt settings configured"
	fi
fi
