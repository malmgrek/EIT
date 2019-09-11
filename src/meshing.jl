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
