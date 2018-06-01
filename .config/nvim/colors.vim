" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
        let g:quantum_italics=1
" Colors and Fonts {

    " set Vim-specific sequences for RGB colors
    " This is for fixing the weird lack of True Colours on ST
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Enable GUI terminal colours
    set termguicolors

    " Use Quantum colour scheme
    colorscheme quantum


"}
