$res = Get-Item "$($args[0])*"
if ($res -eq $null) {
	nvim $args[0]
}
else {
	nvim $res[0].FullName
}
