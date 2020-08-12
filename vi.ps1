# Opens every file that starts as the provided argument
$res = Get-Item "$($args[0])*"
if ($res -eq $null) {
	nvim -o $args[0]
}
else {
	nvim -o $res.FullName
}
