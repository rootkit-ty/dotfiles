" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" VimPlug {
    call plug#begin('~/.local/share/nvim/plugged')

    " Nord colour theme
    Plug 'arcticicestudio/nord-vim'

    Plug 'tyrannicaltoucan/vim-quantum'

    Plug 'rhysd/clever-f.vim'
    Plug 'justinmk/vim-sneak'

    Plug 'wellle/targets.vim'

    " Snippet plugins
    Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'

    " Tim pope plugins
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'

    Plug 'raimondi/delimitmate'

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'

    Plug 'yggdroot/indentline'

    Plug 'godlygeek/tabular', {'on': 'Tabularize'}

    Plug 'junegunn/vim-peekaboo'
    Plug 'mbbill/undotree', { 'on': [ 'UndotreeToggle' ] }
    Plug 'wellle/visual-split.vim', { 'on': [ 'VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow' ] }

    Plug 'qpkorr/vim-bufkill'

    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

    Plug 'jreybert/vimagit', { 'on': 'Magit' }

    Plug 'sheerun/vim-polyglot'

    "TODO make this load on file save
    Plug 'mhinz/vim-signify'

    Plug 'roxma/vim-paste-easy'

    Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
    Plug 'junegunn/limelight.vim', {'on': 'LimeLight'}

    Plug 'ajh17/VimCompletesMe'
"    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --cs-completer --go-completer --java-completer --js-completer', 'on': []}

    Plug 'w0rp/ale'

    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'

    " Initialize plugin system
    call plug#end()
"}

