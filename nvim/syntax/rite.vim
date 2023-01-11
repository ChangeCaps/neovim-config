syntax keyword Type u8 u16 u32 u64 u128 usize i8 i16 i32 i64 i128 isize f16 f32 f64 bool void
syntax keyword Keyword class fn let if else return
syntax keyword Constant true false self null
syntax keyword Operator = + - * & \/
syntax match Comment "//.*$"
syntax match Comment "/\*.*\*/"
syntax match Function "\w\(\w\)*("he=e-1

let b:current_syntax = "rite"
