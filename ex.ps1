# Opens a Windows Explorer window in the directory provided, otherwise in the current directory
if ($args.length) {
	explorer (Get-Item "$($args[0])").FullName
}
else {
	explorer .
}
