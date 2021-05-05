module PHCpack

export phc

import HomotopyContinuation
using HomotopyContinuation: @var
using HomotopyContinuation: @polyvar
export @var
export @polyvar
const HC = HomotopyContinuation
using DelimitedFiles



function phc(
    f::HC.System;
    file_path = mktempdir(),
    phc_path = "",
    cmd_options = "-b",
    print_output = true)

    oldpath = pwd()
    cd(file_path)
    println("File path: $(file_path)")

    input = String[]
    push!(input, "$(HC.length(f)) $(HC.nvariables(f))")
    n = length(f)

    for (i, fi) in enumerate(f)
      push!(input, "$(fi);")
    end
    # replace exponentiation
    input = map(line -> replace(line, "^" => "**"), input)
    # replace complex numbers
    input = map(line -> replace(line, r"(^|\W)(im)(\W|$)" => s"\1I\3"), input)


    writedlm("input", input, '\n')
    @time run(`$(phc_path)phc $(cmd_options) input output.phc`)
    if print_output
        run(`tail -40 output.phc`)
    end
    nothing
end

end
