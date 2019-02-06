function CheckPath($path) {
	if (Test-Path (Join-Path $path .git)) {
		$status = git -C $path status -s
		$stash = git -C $path stash list
		if (($status -ne $null) -or ($stash -ne $null)) {
			Write-Output "> $path" $status $stash ""
		}
	}
}

CheckPath(pwd)
ForEach ($item in (Get-ChildItem -Recurse -Directory)) {
	CheckPath($item.FullName)
}
