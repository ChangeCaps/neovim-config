if exists("b:current_syntax")
    finish
endif

syn keyword riteKeywords
    \ assert fn for import let loop mut panic pub pure return type as

syn keyword riteConditionals
    \ if else match

syn keyword riteTypes
    \ str bool true false void i8 i16 i32 i64 int u8 u16 u32 u64 f32 f64

syn match riteSnakeCase "[a-z0-9_]\+" contained

syn match riteCall "|>\s*\([a-z0-9_]*:\)*\zs[a-z0-9_]\+\ze"
syn match riteCall "\w\(\w\)*("he=e-1,me=e-1

syn match ritePascalCase "\u\w\+"
syn match riteGeneric "'\w\+"

syn match riteOperator "->" contained
syn match riteOperator "&&" contained
syn match riteOperator "||" contained
syn match riteOperator "==" contained
syn match riteOperator "!=" contained
syn match riteOperator "<=" contained
syn match riteOperator ">=" contained
syn match riteOperator "|>" contained
syn match riteOperator "<" contained
syn match riteOperator ">" contained
syn match riteOperator "+" contained
syn match riteOperator "-" contained
syn match riteOperator "*" contained
syn match riteOperator "/" contained
syn match riteOperator "%" contained
syn match riteOperator ":" contained

syn match riteNumber "\d\+"
syn match riteNumber "\d\+\.\d\+"

syn region riteComment start="///" end="$"
syn region riteComment start="//!" end="$"
syn region riteComment start="//" end="$"

syn region riteString start="\"" end="\"" skip="\\\""

let b:current_syntax = "rite"

hi def link riteKeywords Keyword
hi def link riteConditionals Conditional
hi def link riteTypes Type
hi def link riteNumber Number
hi def link ritePascalCase Type
hi def link riteGeneric Special
hi def link riteOperator Operator
hi def link riteComment Comment
hi def link riteString String
hi def link riteCall Function
