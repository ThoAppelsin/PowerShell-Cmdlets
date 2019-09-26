param([String]$local, [String]$remote)

if (Test-Path (Join-Path $local .git)) {
	if (git -C $local status --porcelain) {
		Write-Host "add, " -NoNewline
		git -C $local add .

		Write-Host "commit, " -NoNewline
		git -C $local commit -av
	}
	else {
		Write-Host "add/commit (N/A), " -NoNewline
	}

	Write-Host "fetch, " -NoNewline
	git -C $local fetch -q
	$syncneeded = (git -C $local status --porcelain -b) -match '.*?\[(?:ahead (\d+))?(?:, )?(?:behind (\d+))?\]'

	if ($syncneeded) {
		if ($Matches[2]) {
			Write-Host "pull, " -NoNewline
			git -C $local pull -q
		}
		else {
			Write-Host "pull (N/A), " -NoNewline
		}

		if ($Matches[1]) {
			Write-Host "and push"
			git -C $local push -q
		}
		else {
			Write-Host "and push (N/A)"
		}
	}
	else {
		Write-Host "and pull/push (N/A)"
	}
}
else {
	if (Test-Path "$local/*") {
		git -C $local init
		git -C $local remote add origin $remote
		git -C $local fetch --all
		git -C $local status
		if (ask No, Yes 0 "WARNING: Files will be reset with the remote's contents!" "Proceed?") {
			git -C $local reset --hard origin/master
			git -C $local branch --set-upstream-to=origin/master master
		}
	}
	else {
		git clone $remote $local
	}
}

