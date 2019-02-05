ForEach ($item in (Get-ChildItem -Recurse -Directory)) {
	if (Test-Path (Join-Path $item.FullName .git)) {
		$status = git -C $item.FullName status -s
		$stash = git -C $item.FullName stash list
		if (($status -ne $null) -or ($stash -ne $null)) {
			Write-Output "> $($item.FullName)"
			Write-Output $status
			Write-Output $stash
		}
	}
}
