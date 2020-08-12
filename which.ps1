# Returns the directory of the provided command
(Get-Command -Name $args -ErrorAction SilentlyContinue | 
	Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue) -replace "\\", "/"
