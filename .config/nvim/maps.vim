" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" KeyMapping {
    let mapleader=","

    " Smart way to move between windows
   nnoremap <C-j> <C-w>j
   nnoremap <C-k> <C-w>k
   nnoremap <C-h> <C-w>h
   nnoremap <C-l> <C-w>l

    " Mode binds

    " Run GDiff
   nnoremap <leader>md :Gdiff<cr>

    " Toggle zen mode
   nnoremap <leader>mz :call<space>ZenMode()<cr>

    " Git and diff keybinds

    " Bindings for merging
   nnoremap <leader>dh :diffget //2<cr>
   nnoremap <leader>dt :diffget //3<cr>

   " Bindings for diffing
   nnoremap <leader>dd :diffthis<cr>

    " Git commands
   nnoremap <leader>G :Magit<cr>
   nnoremap <leader>ga :Git add %<cr>
   nnoremap <leader>gA :Git add .<cr>
   nnoremap <leader>gc :Gcommit<cr>
   nnoremap <leader>gs :Gstatus<cr>
   nnoremap <leader>gp :Gpush<cr>
   nnoremap <leader>gu :Gpull<cr>

    " Buffer keybinds
    " Close the git windows
   nnoremap <leader>go :only<cr>

    " Dictionary
    inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')

    " Pressing \ss will toggle and untoggle spell checking
   nnoremap <leader>ss :setlocal spell!<cr>

    " Misc

    " Toggle netrw
   nnoremap <leader>e :call ToggleNetrw()<cr>

   nnoremap <leader>/ :nohlsearch<cr>

    " Fast saving
   nnoremap <leader>w :w!<cr>
   nnoremap <leader>W :w!<cr>:BD<cr>

    " Quickly open a buffer for scribble
   nnoremap <leader>sb :e ~/buffer<cr>

    " Quickly open a markdown buffer for scribble
   nnoremap <leader>sm :e ~/buffer.md<cr>

    " Close the current buffer yet keep the windows intact
   nnoremap <leader>x :BD<cr>

    " Close the current window
   nnoremap <leader>q :q<cr>
   nnoremap <leader>Q :qa<cr>
   nnoremap <leader>z :w<cr>:BD<cr>
   nnoremap <leader>Z :w<cr>:qa<cr>

    " Toggle paste mode on and off
   nnoremap <leader>pp :setlocal paste!<cr>

    "Plugin keymaps
    nnoremap <leader>B :Buffers<cr>
    nnoremap <leader>F :FZF<space>
    nnoremap <leader>S :Snippets<cr>
    nnoremap <leader>ff :FZF<cr>
    nnoremap <leader>fl :Lines<cr>
    nnoremap <leader>fb :BLines<cr>
    nnoremap <leader>ft :Tags<cr>
    nnoremap <leader>fr :History<cr>
    nnoremap <leader>fh :Helptags<cr>
    nnoremap <leader>f: :History:<cr>
    nnoremap <leader>f/ :History/<cr>
    nnoremap <leader>fg :GFiles<cr>
    nnoremap <leader>fs :GFiles?<cr>
    nnoremap <leader>fc :Commits<cr>
    nnoremap <leader>fC :Commands<cr>
    nnoremap <leader>a :Ag<cr>
    nnoremap <leader>fa :Ag<space>

    " Command remaps
    cmap ;\ \(\)<Left><Left>


""}
