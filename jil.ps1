# Runs the first .jl file in the current directory in interactive mode
julia -i $args (ls *.jl)[0].Name 
