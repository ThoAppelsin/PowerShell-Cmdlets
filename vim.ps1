$res = Get-Item "$($args[0])*"
if ($res -eq $null) {
	nvim-qt $args[0]
}
else {
	nvim-qt $res[0].Name
}
