using Documenter
using Nanopass

makedocs(
    sitename = "Nanopass",
    format = Documenter.HTML(),
    modules = [Nanopass]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
