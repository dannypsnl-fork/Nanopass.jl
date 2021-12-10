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
  ss = @pipe block.args |>
             map(expr -> begin
      :(@data $(expr.args[1]) begin
        $(expr.args[2:end]...)
      end)
    end, _)
  quote
    @eval module $language_name
    using MLStyle
    export $(exports...)
    $(ss...)
    end
  end
end

export @language

end # module
