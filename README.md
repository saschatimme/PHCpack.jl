# PHCpack.jl

Julia wrapper for [PHCpack](http://homepages.math.uic.edu/~jan/PHCpack/phcpack.html). Provides the function `phc` to call PHCpack from Julia.

For instance, to solve the polynomial system
```math
x^2 - y + 1 = x + y + 4 = 0
```
we type
```julia
using PHCPack
@var x y

f = System([x^2 - y + 1 ; x + y + 4])

phc(f)
```

The full syntax of `phc` is as follows
```julia
phc(f::HC.System;
    file_path = mktempdir(),
    phc_path = "",
    cmd_options = "-b",
    print_output = true)
```
where
* `file_path` is the path to the folder where you want the input and output be saved to.
* `phc_path` is the path to the folder where the `phc` executable is saved to.
* `cmd_options` are the options passed to `phc`.
