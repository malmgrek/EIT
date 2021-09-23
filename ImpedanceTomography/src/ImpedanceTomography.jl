module ImpedanceTomography

using LinearAlgebra

using JSON

"""
TODO

- Add NETGEN support to meshing.jl
    - Enable Geometry -> meshing

- Implement Gaussian quadrature formulas to quadrature.jl

"""

include("Geometry.jl")
include("Meshing.jl")
include("Models.jl")
# include("fem3d/complete.jl")


end
