using Nanopass
using Test

@language L0 begin
    Expr[
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
@test typeof(Lambda([:a], [Var(:a)])) == Lambda
