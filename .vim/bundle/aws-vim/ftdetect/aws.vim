"============================================================================
"File:        awsvim
"Description: vim autodetection of the Cloud Formation Templates and
"             registration of the file type 
"Author: Marcin Katulski ( marcin.katulski@gmail.com )
"
"============================================================================
au! BufNewFile,BufRead *.template set filetype=aws.json
