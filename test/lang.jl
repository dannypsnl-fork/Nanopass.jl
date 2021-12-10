using Nanopass
using Test

@language L0 begin
    Exp[
        Var(x::Symbol)
        Lambda(vs::Array{Var}, body::Exp)
        App(f::Exp, args::Array{Exp})
    ]
end

using .L0
using MLStyle

function eval(e::Exp)
    @match e begin
        Var(x) => Var(x)
        Lambda(vs, body) => Lambda(vs, eval(body))
        App(f, args) => eval(app(f, args...))
    end
end

function app(e::Exp, args::Exp...)
    @match e begin
        Lambda(vs, body) && if length(vs) == length(args)
        end => begin
            d = Dict()
            for (v, a) in zip(vs, args)
                d[v] = a
            end
            haskey(d, body) ? d[body] : body
        end
    end
end

@test eval(Var(:a)) == Var(:a)
@test eval(App(Lambda([Var(:a)], Var(:a)), [Var(:b)])) == Var(:b)
