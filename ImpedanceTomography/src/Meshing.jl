"""Mesh generation for finite element method """

@doc """
Represents a triangular/tetrahedral mesh

TODO: 1. Function that writes the geofiles (2d first)
      2. As standard as possible data structure for the mesh & loader function
      3. Visualization of the mesh

"""
struct Mesh
    coordinates::Array{Array{Real, 1}, 1}
    topology::Array{Array{Int, 1}, 1}
    boundary::Array{Array{Int, 1}, 1}
    domain::Array{Array{Int, 1}, 1}
    connection::Array{Array{Int, 1}, 1}
    plot::Function
    load::Function
end


# function Cem2dMesh()
#     function plot()
#         # Use some appropriate plot tool
#     end
#     function load()
#         # Perhaps we want a full mesh generation pipeline.
#         # On the other hand, we do need to be able to serialize meshes
#         # since can't assume that the user has netgen installed.
#         # Create a small collection of example meshes to be used.
#         return Mesh()
#     end
#     return Mesh(...)
# end

@doc """
Write contents to a Netgen option file
"""
function write_ngopt(meshoptions, options; filename="ng.opt")
    open(filename, "w") do f
        write(f, join([
            ["meshoptions.$(x) $(y)" for (x, y) in meshoptions];
            ["options.$(x) $(y)" for (x, y) in options]
        ], "\n"))
    end
end


@doc """
Wrapper for running Netgen inside Julia

"""
function netgen(
    geofile;
    volfile=nothing,
    netgen_exec="/opt/netgen/bin/netgen",
    meshoptions=[],
    options=[],
    verbose=true
    )

    # If volfile not given, just use
    volfile = isnothing(volfile) ?
        split(split(geofile, ".geo")[1], "/")[end] * ".vol" :
        volfile

    # Create and enter a temporary directory
    # Write ng.opt file
    # Run netgen and save the volfile to original working directory
    # Deletes the temporary directory
    mktempdir(dir -> (
        cd(() -> (
            write_ngopt(meshoptions, options, filename="ng.opt");
            out = read(
                `$netgen_exec -batchmode -geofile=$geofile -meshfile=$volfile `,
                String
            );
            @debug out;
            @debug (
                "Finished executing netgen in $(pwd()) containing" *
                "configs $(readdir())"
            );
        ), dir)
    ), pwd())

    return volfile
end


@doc """
Create a geofile for a two-dimensional EIT model
"""
function write_geofile2d()
    # Perhaps we don't explicitly need the geofiles.
    # Instead, we can use temp files and compose the mesh generation with
    # `run_netgen`
    # Should support meshes with no electrodes.
    throw("unimplemented")
end


@doc """
Create a geofile for a three-dimensional EIT model
"""
function write_geofile3d()
    throw("unimplemented")
end
