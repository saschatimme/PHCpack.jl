module PHCpack

using Base.Filesystem
import MultivariatePolynomials
const MP = MultivariatePolynomials

export phc

function phc(
    f::Vector{<: MP.AbstractPolynomialLike};
    file_path = mktempdir(),
    phc_path = "",
    cmd_options = "-b",
    print_output = true)

    oldpath = pwd()
    cd(file_path)
    println("File path: $(file_path)")

    phcpack_input = String[]
    push!(phcpack_input, "$(length(f)) $(MP.nvariables(f))")

    for i in 1:length(f)
        monomials = MP.monomials(f[i])
        fi_data = zip([MP.exponents(m) for m in monomials], [MP.variables(m) for m in monomials], MP.coefficients(f[i]))
        fi = ""
        t = first(fi_data)
        if typeof(t[3]) <: Real
            fi = string(fi, "+($(t[3]))")
        else
            fi = string(fi, "+(")
            fi = string(fi, string(t[3])[1:end-2])
            fi = string(fi, "*I)")
        end
        for j in 1:length(t[1])
            if t[1][j] > 1
                fi = string(fi, "*$(t[2][j]^t[1][j])")
            elseif t[1][j] == 1
                fi = string(fi, "*$(t[2][j])")
            end
        end
        for t in Iterators.drop(fi_data, 1)
            if typeof(t[3]) <: Real
                fi = string(fi, "+($(t[3]))")
            else
                fi = string(fi, "+(")
                fi = string(fi, string(t[3])[1:end-2])
                fi = string(fi, "*I)")
            end

            for j in 1:length(t[1])
                if t[1][j] > 1
                    fi = string(fi, "*$(t[2][j]^t[1][j])")
                elseif t[1][j] == 1
                    fi = string(fi, "*$(t[2][j])")
                end
            end
        end
        push!(phcpack_input, " $fi;")
    end


    writedlm("input", phcpack_input, '\n')
    @time run(`$(phcpack_path)phc $(cmd_options) input output.phc`)
    if print_output
        run(`tail -40 output.phc`)
    end
    nothing
end

end
