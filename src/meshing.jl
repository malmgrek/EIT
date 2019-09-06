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


function run_netgen(
    geofile; volfile=nothing, netgen_exec="/opt/netgen/bin/netgen"
    )
    # TODO: Add ng_options
    # TODO: Try to make with minimal side effects

    default_volfile = (
        (x -> x * ".vol") ∘ 
        (x -> split(x, "/")[end]) ∘ 
        (x -> split(x, ".geo")[1])
    )

    volfile = isnothing(volfile) ? default_volfile(geofile) : volfile
    @info "Running netgen with $(geofile)"
    run(`$(netgen_exec) -batchmode -geofile=$(geofile) -meshfile=$(volfile)`)
    @info "Wrote mesh to $(volfile)"
    return volfile
end
