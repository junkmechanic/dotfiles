ln -s "$HOME/.files/etc/remote/remote.tmux.conf" "$HOME/.tmux.conf"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "$HOME"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -sf "$HOME/.files/etc/remote/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.files/etc/remote/zpreztorc" "$HOME/.zpreztorc"
cd "$HOME/.zprezto/modules"
git clone git@github.com:psprint/zsh-navigation-tools.git
git clone git@github.com:hlissner/zsh-autopair.git
mkdir -p "$HOME/.config/nvim"
ln -s "$HOME/.files/etc/remote/dein.toml" "$HOME/.config/nvim/"
ln -s "$HOME/.files/etc/remote/init.vim" "$HOME/.config/nvim/"
ln -s "$HOME/.files/etc/nvim/dein_lazy.toml" "$HOME/.config/nvim/"
ln -s "$HOME/.files/etc/remote/rc" "$HOME/.ssh/rc"
