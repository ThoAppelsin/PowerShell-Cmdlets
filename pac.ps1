# Activates the existing venv for Python, and prompts for creation otherwise
if (Test-Path 'env/Scripts/activate') {
	.\env\Scripts\activate
}
else {
	$message = 'Virtual Environment Absent';
	$question = 'Would you like to create one first?';

	$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription];
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'));
	$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'));

	$decision = $Host.UI.PromptForChoice($message, $question, $choices, 0);
	if ($decision -eq 0) {
		python -m venv env
		pac
	}
}

