"""
Represents a triangular/tetrahedral mesh

TODO redefine

"""
struct Mesh
    coordinates::Array{Array{Real, 1}, 1}
    topology::Array{Array{Int, 1}, 1}
    boundary::Array{Array{Int, 1}, 1}
    domain::Array{Array{Int, 1}, 1}
    connection::Array{Array{Int, 1}, 1}
end


# Loads mesh from a JSON file
function load_mesh(file)
    dict = JSON.parsefile(file)
    from_dict(x) = Mesh(
            x["coordinates"],
            x["topology"],
            x["boundary"],
            x["domain"],
            x["elementConnection"]
    )
    return from_dict(dict)
end
