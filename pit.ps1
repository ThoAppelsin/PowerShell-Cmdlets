if (!($env:virtualenv_never) -and (Test-Path 'env/Scripts/activate') -and !($env:VIRTUAL_ENV)) {
	$decision = ask Yes, No, "Don't ask again" 0 "Inactive Virtual Environment" "Would you like to activate it first?"
	switch ($decision) {
		0 { pac }
		2 { $env:virtualenv_never = $True }
	}
}
python -i $args (ls *.py)[0].Name 
