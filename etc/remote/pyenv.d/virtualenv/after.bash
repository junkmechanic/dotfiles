upgrade_packages() {
  PYENV_VERSION=$VIRTUALENV_NAME pyenv-exec pip install --upgrade pip setuptools wheel neovim neovim-remote ipython
}

after_virtualenv 'upgrade_packages'
