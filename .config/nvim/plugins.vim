" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" VimPlug {
    call plug#begin('~/.local/share/nvim/plugged')

    " Nord colour theme
    Plug 'arcticicestudio/nord-vim'

    Plug 'tyrannicaltoucan/vim-quantum'

    Plug 'mhinz/vim-startify'

    Plug 'wellle/visual-split.vim', { 'on': [ 'VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow' ] }

    Plug 'itchyny/lightline.vim'

    Plug 'sirver/ultisnips'

    Plug 'honza/vim-snippets'

    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-commentary'

    Plug 'tpope/vim-git'

    Plug 'tpope/vim-fugitive'

    Plug 'raimondi/delimitmate'

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    Plug 'yggdroot/indentline'

    Plug 'godlygeek/tabular'

    Plug 'junegunn/vim-peekaboo'

    Plug 'qpkorr/vim-bufkill'

    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

    Plug 'jreybert/vimagit', { 'on': 'Magit' }

    Plug 'sheerun/vim-polyglot'

    Plug 'mhinz/vim-signify'

    Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
    Plug 'junegunn/limelight.vim'

    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --cs-completer --go-completer --java-completer --js-completer' }

    Plug 'w0rp/ale'

    Plug 'maximbaz/lightline-ale'

    " Initialize plugin system
    call plug#end()
"}

" Plugin Settings {
    "let g:rainbow_active = 1

    if has("mac")
        " If installed using Homebrew
        set rtp+=/usr/local/opt/fzf

        " If installed using git
        set rtp+=~/.fzf
    endif

    " UltiSnips {
        let g:UltiSnipsJumpForwardTrigger="<Tab>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"
        let g:UltiSnipsExpandTrigger="<C-e>"

        let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
    "}

    " ALE {
        let g:ale_open_list = 1
        let g:ale_list_window_size = 5
        let g:ale_lint_on_text_changed="never"
    "}

    " YouCompleteMe {
        let g:ycm_key_list_stop_completion = ['<C-a>']
        let g:ycm_max_num_identifier_candidates = 5
        let g:ycm_max_num_candidates = 20
        let g:ycm_min_num_of_chars_for_completion = 4
        let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'magit' : 1,
        \ 'vimwiki' : 1,
        \}
    " }

    " Lightline {
        let g:lightline = {
          \ 'colorscheme': 'one',
          \ }

        let g:lightline.component_expand = {
          \  'linter_checking': 'lightline#ale#checking',
          \  'linter_warnings': 'lightline#ale#warnings',
          \  'linter_errors': 'lightline#ale#errors',
          \  'linter_ok': 'lightline#ale#ok',
          \ }

        let g:lightline.component_type = {
          \     'linter_checking': 'left',
          \     'linter_warnings': 'warning',
          \     'linter_errors': 'error',
          \     'linter_ok': 'left',
          \ }

        let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

        let g:lightline#ale#indicator_checking = "\uf110"
        let g:lightline#ale#indicator_warnings = "\uf071"
        let g:lightline#ale#indicator_errors = "\uf05e"
        let g:lightline#ale#indicator_ok = "\uf00c"
    "}
    let g:polyglot_disabled = ['markdown']
"}
