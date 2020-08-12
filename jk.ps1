# Runs the first .jl file in the current directory in interactive and revisable mode
julia -e "
atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
		@eval includet(\`"$((ls *.jl)[0].Name)\`")
    catch
	end
end
" -i
