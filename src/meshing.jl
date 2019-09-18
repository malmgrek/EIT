"""
Represents a triangular/tetrahedral mesh

TODO

    1. Function that writes the geofiles (2d first)
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


function Cem2dMesh()
    function plot()
        # Use some appropriate plot tool
    end
    function load()
        # Perhaps we want a full mesh generation pipeline.
        # On the other hand, we do need to be able to serialize meshes
        # since can't assume that the user has netgen installed.
        # Create a small collection of example meshes to be used.
        return Mesh()
    end
    return Mesh(...)
end


function run_netgen(
    geofile;
    volfile=nothing,
    netgen="/opt/netgen/bin/netgen",
    meshoptions=[],
    options=[],
    verbose=true
    )

    default_volfile = (
        (x -> x * ".vol") ∘ 
        (x -> split(x, "/")[end]) ∘ 
        (x -> split(x, ".geo")[1])
    )

    function write_ngopt()
        open("ng.opt", "w") do io
            write(
                io,
                join([
                    ["meshoptions.$(x) $(y)" for (x, y) in meshoptions];
                    ["options.$(x) $(y)" for (x, y) in options]
                ], "\n")
            )
        end
    end

    volfile = isnothing(volfile) ? default_volfile(geofile) : volfile

    # Creates a temporary directory
    # Writes the option file there
    # Runs netgen
    # Erases the directory
    mktempdir(
        dir -> (
            cd(
                () -> (
                    write_ngopt();
                    out = read(
                        `$netgen 
                        -batchmode 
                        -geofile=$geofile 
                        -meshfile=$volfile `,
                        String
                    );
                    @debug out;
                    @debug (
                        "Finished executing netgen in $(pwd()) containing" *
                        "configs $(readdir())"
                    );
                ),
                dir
            )
        ),
        pwd())

    return volfile
end


function write_geofile()
    # Perhaps we don't explicitly need the geofiles.
    # Instead, we can use temp files and compose the mesh generation with
    # `run_netgen`
    # Should support meshes with no electrodes.
end
