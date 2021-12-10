module Nanopass

macro language(language_name::Symbol, block)
    quote
        @eval module $language_name
            $block
        end
    end
end

@language L0 begin
  Expr
    x::Symbol
    c::Expr
    Begin(es::[Expr], e::Expr)
    If(test::Expr, body::Expr)
    If(test::Expr, body::Expr, body2::Expr)
    Lambda(vs::[Symbol], body::[Expr])
    App(e::Expr, es::[Expr])
  Stmt
    Define(v::Symbol, e::Expr)
end

end # module
