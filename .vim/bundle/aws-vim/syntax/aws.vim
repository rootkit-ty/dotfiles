" Vim syntax file
" Language:     AWS CloudFormation Templates (cft)
" Last Change:  2016 Sept 14
"
" Maintainer:   Andrew Stuart <andrew.stuart2@gmail.com>

runtime! syntax/json.vim

" Type definitions
syn match type /"Type"\s*:\s*".\{-}"/  containedin=topjsonObject

" Reference object
syn match   ref          /{\s*"Ref"\s*:\_.\{-}}/

" Functions and predefined AWS
syn match   fn     /Fn::\w\+/ containedin=ALL
syn match   predef   /AWS::\(\w\|:\)\+/ containedin=ALL

" "Keywords"
syn keyword Keyword containedin=jsonKeyword
      \ AWSTemplateFormatVersion
      \ ConstraintDescription
      \ NoEcho
      \ Type
      \ Ref
      \ Default
      \ Description
      \ MinLength
      \ MaxLength
      \ AllowedPattern
      \ AllowedValues
      \ Metadata
      \ Parameters
      \ Outputs
      \ Properties
      \ Label
      \ TemplateURL
      \ Resources


hi def link ref Special
hi def link fn Function
hi def link predef Constant
hi def link type Type

let b:current_syntax="aws"
