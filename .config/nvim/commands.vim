" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" Commands {
    " :W sudo saves the file
    command W w !sudo tee % > /dev/null
"}
