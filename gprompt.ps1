# Customizes the git prompt for poshgit (PowerShell git extension)
$pr = (Get-PromptPath)
$segs = $pr -split '\\'
if ($segs.count -gt 4) {
	return '--\' + ($segs[-2..-1] -join '\')
}
else {
	return $pr
}
