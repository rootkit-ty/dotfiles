" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" Settings {

    " Tun on numbers and relative numbers
    set number
    set relativenumber

    " 4 soft-tab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4

    set foldmethod=syntax
    set foldlevel=4

    " Ignore case unless a capital is explicitly used
    set ignorecase
    set smartcase

    " Change split directions to be more consistent with i3
    set splitbelow
    set splitright

    " List invisible characters
    set list
    set listchars=eol:¬,tab:→\ ,trail:~,extends:»,precedes:«,space:·,nbsp:§

    "Setup highlighting for listchars to make them slightly darker
    if has("mac")
        hi SpecialKey ctermfg=black
    else
        hi SpecialKey ctermfg=grey
    endif

    " Set column colour for long lines
    " TODO: Have this only for lines that exceed the limit
    set colorcolumn=80

    " Match trailing spaces
    match ErrorMsg '\s\+$'

    " Set utf8 as standard encoding and en_US as the standard language
    set encoding=utf8

    " Use Unix as the standard file type
    set fileformats=unix,dos,mac

    " Hide buffers, don't close them
    set hidden
    set showmatch

    " Global flag always applied on regex (save a keypress every search)
    set gdefault

    " Don't redraw while executing macros (good performance config)
    set lazyredraw

    autocmd FileType haskell,puppet,ruby,yaml,markdown setlocal expandtab shiftwidth=2 softtabstop=2

    " Deal with swap, backup, and undo files
    call WriteCacheDir("swap")
    set directory=./.vim_data/,~/.cache/vim/swap/,~/.cache/,./,~

    call WriteCacheDir("backup")
    set backupdir=./.vim_data/,~/.cache/vim/backup/,~/.cache/,./,~

    if exists('+undofile')
        call WriteCacheDir("undo")
        set undofile
        set undodir=./.vim_data/,~/.cache/vim/undo/,~/.cache/,./,
    endif

"}
" Netrw settings {
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1
    let g:netrw_winsize = 10
    "
"    augroup ProjectDrawer
"        autocmd!
"        autocmd VimEnter * :Vexplore | :set winfixwidth | let  g:net_rw_window=winnr() | let g:net_rw_state=1 | :winc l
"    augroup END


    " To avoid overwriting the netrw buffer with some other buffer, we should
    " change window before executing
    augroup NetrwMaps
        autocmd FileType netrw nnoremap <buffer> <leader>B :winc w<cr>:Buffers<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>F :winc w<cr>:FZF<space>
        autocmd FileType netrw nnoremap <buffer> <leader>ff :winc w<cr>:FZF<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fl :winc w<cr>:Lines<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fb :winc w<cr>:BLines<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>ft :winc w<cr>:Tags<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fr :winc w<cr>:History<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fh :winc w<cr>:Helptags<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>f: :winc w<cr>:History:<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>f/ :winc w<cr>:History/<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fg :winc w<cr>:GFiles<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fs :winc w<cr>:GFiles?<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fc :winc w<cr>:Commits<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fC :winc w<cr>:Commands<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>a :winc w<cr>:Ag<cr>
        autocmd FileType netrw nnoremap <buffer> <leader>fa :winc w<cr>:Ag<space>
        autocmd FileType netrw nnoremap <buffer> - <plug>VinegarUp
    augroup END
"}
