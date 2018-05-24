" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" VimPlug {
    call plug#begin('~/.local/share/nvim/plugged')

    " Nord colour theme
    Plug 'arcticicestudio/nord-vim'

    Plug 'tyrannicaltoucan/vim-quantum'

    Plug 'wellle/visual-split.vim', { 'on': [ 'VSResize', 'VSSplit', 'VSSplitAbove', 'VSSplitBelow' ] }

    Plug 'itchyny/lightline.vim'

    Plug 'sirver/ultisnips'

    Plug 'honza/vim-snippets'

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    Plug 'tpope/vim-sensible'

    Plug 'junegunn/vim-peekaboo'

    Plug 'qpkorr/vim-bufkill'

    Plug 'tpope/vim-git'

    Plug 'tpope/vim-fugitive'

    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

    Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

    Plug 'jreybert/vimagit', { 'on': 'Magit' }

    Plug 'sheerun/vim-polyglot'

    Plug 'mhinz/vim-signify'

    Plug 'junegunn/limelight.vim'

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

    "set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%*

    "let g:syntastic_always_populate_loc_list = 1
    "let g:syntastic_auto_loc_list = 1
    "let g:syntastic_check_on_open = 1
    "let g:syntastic_check_on_wq = 0

    "let g:indent_guides_enable_on_vim_startup = 1
    "let g:indent_guides_guide_size = 1

    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    let g:UltiSnipsExpandTrigger="<tab>"

    let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
"}
