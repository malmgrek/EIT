module EIT

using LinearAlgebra

using JSON

"""
TODO

- Add NETGEN support to meshing.jl
    - Enable Geometry -> meshing

- Implement Gaussian quadrature formulas to quadrature.jl

"""

include("geometry.jl")
include("meshing.jl")
include("models.jl")
# include("fem3d/complete.jl")


end
