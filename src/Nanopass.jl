module Nanopass

using Pipe
using MacroTools

macro language(language_name::Symbol, block::Expr)
  block = rmlines(block)
  ss =
    @pipe block.args |>
          map(expr -> begin
              entryName = expr.args[1]
              sss = map(expr -> begin
                  @assert @capture(expr, T_Symbol(fields__))
                  :(struct $(T) <: $(entryName)
                    $(fields...)
                  end)
                end, expr.args[2:end])
              pushfirst!(sss, :(abstract type $(entryName) end))
            end, _) |>
          Iterators.flatten
  quote
    @eval module $language_name
    $(ss...)
    end
  end
end

@language L0 begin
  Exp[
    Var(x::Symbol)
    Begin(es::Array{Expr}, e::Expr)
    If(test::Expr, body::Expr, body2::Expr)
    Lambda(vs::Array{Symbol}, body::Array{Expr})
    App(e::Expr, es::Array{Expr})
  ]
  Stmt[
    Define(v::Symbol, e::Expr)
  ]
  Prog[
    P(s::Array{Stmt})
  ]
end

@show L0
@show L0.Exp
@show L0.Stmt
@show L0.Prog
@show L0.Var(:a)

end # module
