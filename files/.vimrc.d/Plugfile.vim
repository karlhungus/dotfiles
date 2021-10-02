set nocompatible
set t_Co=256
set background=dark
filetype off

call plug#begin('~/.vim/bundle')

" Common plugins (always loaded)
Plug 'mileszs/ack.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.vim/bundle/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
" Plug 'scrooloose/nerdcommenter'
Plug 'roman/golden-ratio'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-scripts/localvimrc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'w0rp/ale'
"Plug 'Valloric/YouCompleteMe', { 'on': 'YouCompleteMe', 'do': './install.py --all' }
Plug 'editorconfig/editorconfig-vim'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Rubby
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
" Plug 'karlhungus/vim-railscasts-theme'
Plug 'vim-ruby/vim-ruby'

" Python
" Plug 'nvie/vim-flake8', { 'for': 'python' }

" Closure
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Javascript
" Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript' ] }
" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.eruby'] }
" Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }

" Go
"Plug 'fatih/vim-go', { 'for': 'go' }
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'prabirshrestha/asyncomplete-gocode.vim'
Plug 'ekalinin/Dockerfile.vim'

" HTML/Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" hashicorp configuration language (terraform etc)
Plug 'hashivim/vim-terraform'

" yaml helper
Plug 'Einenlum/yaml-revealer'

" rego
Plug 'tsandall/vim-rego'

" nginx
Plug 'chr4/nginx.vim'

call plug#end()
