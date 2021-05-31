" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=1 foldmethod=marker spell:
" Settings {

    " Tun on numbers and relative numbers
    set number
    set relativenumber

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

    " Ope them folds please
    set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump

    autocmd FileType haskell,puppet,ruby,yaml,markdown setlocal expandtab shiftwidth=2 softtabstop=2

    " Change working directory to the git root of the project if it exists
    autocmd * exec 'cd' fnameescape(fnamemodify(finddir('.git',
    \ escape(expand('%:p:h'), ' ') . ';'), ':h'))

    augroup TermAutoInsert
        autocmd BufWinEnter,WinEnter term://* startinsert
        autocmd BufLeave term://* stopinsert
    augroup END

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
" Plugin Settings {

    " Fzf {

        " If installed using git
        set rtp+=~/.fzf

    "}

    " UltiSnips {

        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"
        let g:UltiSnipsExpandTrigger="<c-e>"

        let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

    "}

    " ALE {

        let g:ale_open_list = 1
        let g:ale_list_window_size = 5
        let g:ale_lint_on_text_changed="never"

        let g:ale_completion_enabled = 1

        let g:ale_yaml_cfnlint_options = "--ignore-checks E3002"

    "}

    " Lightline {

        function! MyFiletype()
            return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
        endfunction

        let g:lightline = {
          \ 'colorscheme': 'one',
          \ }

        let g:lightline.component_function = {
          \  'filetype': 'MyFiletype',
          \ }

        let g:lightline.component_expand = {
          \  'linter_checking': 'lightline#ale#checking',
          \  'linter_warnings': 'lightline#ale#warnings',
          \  'linter_errors': 'lightline#ale#errors',
          \  'linter_ok': 'lightline#ale#ok',
          \  'buffers': 'lightline#bufferline#buffers'
          \ }

        let g:lightline#bufferline#enable_devicons = 1
        let g:lightline#bufferline#unicode_symbols = 1
        let g:lightline#bufferline#min_buffer_count = 2

        let g:lightline.component_type = {
          \     'linter_checking': 'left',
          \     'linter_warnings': 'warning',
          \     'linter_errors': 'error',
          \     'linter_ok': 'left',
          \     'buffers': 'tabsel'
          \ }

        let g:lightline.active = {
                    \  'right': [[
                    \  'linter_checking',
                    \  'linter_errors',
                    \  'linter_warnings',
                    \  'linter_ok'
                    \  ]],
                    \  'left': [ ['mode', 'paste'],
                    \            ['readonly', 'filetype', 'filename', 'modified']
                    \]
                    \}

        let g:lightline.tabline          = {'left': [['buffers']], 'right': [[]]}

        let g:lightline#ale#indicator_checking = "\uf110"
        let g:lightline#ale#indicator_warnings = "\uf071 "
        let g:lightline#ale#indicator_errors = "\uf05e "
        let g:lightline#ale#indicator_ok = "\uf00c"

    "}

    " PolyGot {

        let g:polyglot_disabled = ['markdown']

    "}

    " Clever-f {

    let g:clever_f_smart_case = 1

    "}

    " Sneak {

    let g:sneak#label = 1

    "}

    " BufKill {

        let g:BufKillCreateMappings = 0

    "}

    " Jedi.vim {
        let g:jedi#popup_on_dot = 0
    " }

    let g:task_rc_override = 'rc.defaultwidth=265'

    let g:airline_powerline_fonts = 1


"}

" NERDTree Settings {
    let NERDTreeShowHidden = 1
    let NERDTreeShowLineNumbers = 1
    let NERDTreeMinimalUI=1
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    "let g:NERDTreeLimitedSyntax = 1
    let g:NERDTreeSyntaxDisableDefaultExtensions = 1
    let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
    let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
    let g:NERDTreeSyntaxEnabledExtensions = ['bmp', 'c', 'coffee', 'cpp', 'cs', 'css', 'erb', 'go', 'hs', 'html', 'java', 'jpg', 'js', 'json', 'jsx', 'less', 'lua', 'markdown', 'md', 'php', 'png', 'pl', 'py', 'rb', 'rs', 'scala', 'scss', 'sh', 'sql', 'vim', 'yml', 'j2']
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
    " Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" }

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
    " Auto LCD to role dir if it's an ansible role with the folder of tasks
    autocmd BufEnter * call AnsibleRoot()
    autocmd USer RooterChDir call AnsibleRoot()
    "autocmd User RooterChDir if expand("%:p:h") =~ '\/roles\/' | exec 'lcd' fnameescape(fnamemodify(finddir('tasks', escape(expand('%:p:h'), ' ') . ';'), ':h')) | endif
    let g:rooter_silent_chdir = 1

"}
