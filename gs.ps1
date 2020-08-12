# Recursively git-syncs directories, starting from the current directory, until git directories are reached, or the recursion tree is exhausted
function CheckPath($path, [ref]$gitonbranch, $nongits) {
	if (Test-Path (Join-Path $path .git)) {
		$status = git -C $path status -s
		$stash = git -C $path stash list
		if (($status -ne $null) -or ($stash -ne $null)) {
			Write-Output "> $path" $status $stash ""
		}
		$gitonbranch.value = $true
	}
	else {
		$exgit = $false
		$ngs = New-Object Collections.Generic.List[System.Object]
		ForEach ($item in (Get-ChildItem -Path $path -Directory)) {
			$gob = $false
			CheckPath ($item.FullName) ([ref]$gob) $nongits
			if ($gob) {
				$exgit = $true
			}
			else {
				$ngs.Add($item.Fullname)
			}
		}

		if ($exgit) {
			$gitonbranch.value = $true
			$nongits.AddRange($ngs)
		}
	}
}

$gitonbranch = $false
$nongits = New-Object Collections.Generic.List[System.Object]
CheckPath (pwd) ([ref]$gitonbranch) $nongits

ForEach ($ng in $nongits) {
	Write-Output "- $ng"
}

