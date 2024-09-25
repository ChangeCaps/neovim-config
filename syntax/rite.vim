if exists("b:current_syntax")
    finish
endif

syn keyword riteKeywords
    \ assert fn for import let loop mut pub pure return type

syn keyword riteConditionals
    \ if match

syn keyword riteTypes
    \ str bool i8 i16 i32 i64 int u8 u16 u32 u64 f32 f64

syn match riteSnakeCase "\w\+_\w\+"
syn match riteSnakeCase "\w\+"
syn match ritePascalCase "\u\w\+"

syn match riteDelimiters "("
syn match riteDelimiters ")"
syn match riteDelimiters "{"
syn match riteDelimiters "}"
syn match riteDelimiters "\["
syn match riteDelimiters "\]"

syn match riteNumber "\d\+"
syn match riteNumber "\d\+\.\d\+"

let b:current_syntax = "rite"

hi def link riteKeywords Keyword
hi def link riteConditionals Conditional
hi def link riteTypes Type
hi def link riteNumber Number
hi def link ritePascalCase Type
hi def link riteSnakeCase Function
hi def link riteDelimiters Delimiter

augroup filetypedetect
  autocmd! BufRead,BufNewFile *.rite setfiletype rite
augroup END
