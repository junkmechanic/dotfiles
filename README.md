dotfiles for setups at home, work and beyond.

Setup:
=====

1. Clone the repo
2. Link all bin files
3. Vim setup
  1. Install dependencies for vim
  2. git clone https://github.com/vim/vim.git
  3. ./configure --enable-perlinterp --enable-luainterp --enable-rubyinterp --enable-pythoninterp --enable-python3interp --with-features=huge
  4. make and install
  5. Link vim dir
  6. `git submodule update --init --recursive`
  7. Run `make` inside vim/bundle/vimproc/
4. To update vim plugins, use `git submodule update --remote` (`gitsbup` alias)
5. `exuberant-ctags` is required for unite-outline to support tags for C family

TODO:
-----

(Mostly a revamp of the whole organizaiton)

1. Merge home and sec
2. Better vim plugin management (departure from git submodules)
