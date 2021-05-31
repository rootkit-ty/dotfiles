" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell: 
" Custom functions {
    " Automatic file formattting {
        " Delete trailing white space on save, useful for some filetypes ;)
        fun! CleanExtraSpaces()
            let save_cursor = getpos(".")
            let old_query = getreg('/')
            silent! %s/\s\+$//e
            call setpos('.', save_cursor)
            call setreg('/', old_query)
        endfun

        if has("autocmd")
            autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
        endif
    "}
    " Syntastic Loclist resize {

        " see :h syntastic-loclist-callback
        function! SyntasticCheckHook(errors)
            if !empty(a:errors)
                let g:syntastic_loc_list_height = min([len(a:errors), 5])
            endif
        endfunction

    "}
    " Zen mode {
        fun! ZenMode()
            "Toggle the flag (or set it if it doesn't yet exist)...
            let g:zen_mode = exists('g:zen_mode') ? !g:zen_mode : 1

            if g:zen_mode
                Goyo
                Limelight 0.8
                silent !i3-msg fullscreen
            else
                Goyo
                Limelight!
                silent !i3-msg fullscreen
            endif
        endfun

    "}
    " Write cache file {
        fun! WriteCacheDir(dir)
            let g:cachedir = $HOME . '/.cache/vim/' . a:dir
            if !isdirectory(g:cachedir) && has('unix')
                :silent execute "!mkdir -p ". g:cachedir . " >/dev/null 2>&1"
                :redraw!
            endif
        endfunction
    " }
    " Toggle netrw {
        fun! ToggleNetrw()
            let g:net_rw_state = exists('g:net_rw_state') ? !g:net_rw_state : 0

            if g:net_rw_state && exists('g:net_rw_window')
                exec g:net_rw_window.'wincmd q'
            else
                Vexplore
                let g:net_rw_window = winnr()
                winc w
            endif

        endfunction
    "}
    " InitYCM {
        function! InitYCM()
            let g:load_ycm_done = exists('g:load_ycm_done') ? !g:load_ycm_done : 0
            if g:load_ycm_done && exists('g:load_ycm_done')
                let g:load_ycm_done = 1
                call plug#load('YouCompleteMe')
            endif
        endfunction

    "}

    " Basic idea is that I want to lcd to the role root and cd to the git root
    " So that way I have nerdtree show the whole project but more or less work
    " relative to the role
    " Ansible CD {
        function! AnsibleRoot()
            " If the dir contains roles
            let file_path = expand('%:p:h')
            let role_dirs = ['tasks', 'templates', 'files', 'handlers', 'defaults']
            if file_path =~ '\/roles\/'
                exec 'lcd' fnameescape(fnamemodify(finddir('tasks',
                            \ escape(file_path, ' ') . ';'), ':h'))
            endif
        endfunction
    " }

" }
