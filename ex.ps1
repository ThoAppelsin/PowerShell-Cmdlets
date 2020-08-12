# Opens a Windows Explorer window in the directory provided, otherwise in the current directory
if ($args.length) {
	explorer $args[0]
}
else {
	explorer .
}
