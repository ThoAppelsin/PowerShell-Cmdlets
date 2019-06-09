if (!($env:virtualenv_never) -and (Test-Path 'env/Scripts/activate') -and !($env:VIRTUAL_ENV)) {
	$message = 'Inactive Virtual Environment';
	$question = 'Would you like to activate it first?';

	$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription];
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'));
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'));
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&Don't ask again"));

	$decision = $Host.UI.PromptForChoice($message, $question, $choices, 0);
	switch ($decision) {
		0 { pac }
		2 { $env:virtualenv_never = $True }
	}
}
python -i $args (ls *.py)[0].Name 
