module Nanopass

using Pipe
using MacroTools

macro language(language_name::Symbol, block::Expr)
  block = rmlines(block)
  exports = @pipe block.args |> map(expr -> begin
                      entryName = expr.args[1]
                      productNames = map(expr -> begin
                          @assert @capture(expr, T_Symbol(fields__))
                          T
                        end, expr.args[2:end])
                      pushfirst!(productNames, entryName)
                    end, _) |> Iterators.flatten
  ss =
    @pipe block.args |>
          map(expr -> begin
              entryName = expr.args[1]
              products = map(expr -> begin
                  @assert @capture(expr, T_Symbol(fields__))
                  :(struct $(T) <: $(entryName)
                    $(fields...)
                  end)
                end, expr.args[2:end])
              pushfirst!(products, :(abstract type $(entryName) end))
            end, _) |>
          Iterators.flatten
  quote
    @eval module $language_name
    export $(exports...)
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

using .L0
@show L0
@show Exp
@show Stmt
@show P <: Prog
@show P([])
@show Var(:a)
@show Var(:a)

end # module
