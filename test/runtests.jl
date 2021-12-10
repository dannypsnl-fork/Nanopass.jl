using Nanopass
using Aqua

Aqua.test_ambiguities(Nanopass)
Aqua.test_unbound_args(Nanopass)
Aqua.test_undefined_exports(Nanopass)
Aqua.test_project_extras(Nanopass)
Aqua.test_deps_compat(Nanopass)
Aqua.test_project_toml_formatting(Nanopass)

include("lang.jl")
