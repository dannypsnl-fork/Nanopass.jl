module Nanopass

macro language(language_name::Symbol, block::Expr)
  for v in block.args
    @show v
  end
  quote
    @eval module $language_name end
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

  Prog
  P(s::[Stmt])
end

end # module
