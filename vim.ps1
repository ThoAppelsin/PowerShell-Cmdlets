# Without arguments, opens GUI Neovim in the current directory
# Otherwise, opens the file(s) specified by the first argument, with the flags specified in the further arguments
if ($args[0] -eq $null) {
	nvim-qt -- .
}
else {
	$res = Get-Item "$($args[0])*" -ErrorAction SilentlyContinue
	$flags = [string] $args[1..$args.length]
	if ($flags -eq "") {
		$flags = "-o"
	}
	if ($res -eq $null) {
		nvim-qt -- $flags $args[0].replace("*", "")
	}
	else {
		
		nvim-qt -- $flags $res.FullName
	}
}
