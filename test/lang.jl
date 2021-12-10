using Nanopass
using Test

@language L0 begin
    Exp[
        Var(x::Symbol)
        Lambda(vs::Array{Var}, body::Exp)
        App(e::Exp, es::Array{Exp})
    ]
end

using .L0
using MLStyle

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

@test app(Lambda([Var(:a)], Var(:a)), Var(:b)) == Var(:b)
