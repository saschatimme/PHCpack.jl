# PHCpack.jl

Julia wrapper for [PHCpack](http://homepages.math.uic.edu/~jan/PHCpack/phcpack.html). Provides the function `phc` to call PHCpack from Julia.

Uses the Julia package [DynamicPolynomials.jl](https://github.com/JuliaAlgebra/DynamicPolynomials.jl).

For instance, to solve the polynomial
```math
f(x) = x^2 - 1
```
we type
```julia
using PHCpack
using DynamicPolynomials

@polyvar x
f = [x^2 - 1]

phc(f)
```

The full syntax of `phc` is as follows
```julia
phc(f::Vector{T};
    file_path = mktempdir(),
    phc_path = "",
    cmd_options = "-b",
    print_output = true)
```
where
* `T` is the polynomial type provided by DynamicPolynomials.
* `file_path` is the path to the folder where you want the input and output be saved to.
* `phc_path` is the path to the folder where the `phc` executable is saved to.
* `cmd_options` are the options passed to `phc`.
