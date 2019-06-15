$p = "$env:LOCALAPPDATA/nvim"

# if (Test-Path "$p/.git") {
	# Write-Host "pull, " -NoNewline
	# git -C $p pull -q
# 
	# Write-Host "add, " -NoNewline
	# git -C $p add . -q
# 
	# Write-Host "commit, " -NoNewline
	# git -C $p commit -av --porcelain
# 
	# Write-Host "and push"
	# git -C $p push -q
# }
# else {
	# git -C $p clone "https://github.com/ThoAppelsin/NeoVim-Configs.git" ...
# }

