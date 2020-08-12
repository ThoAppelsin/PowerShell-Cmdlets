# Prompts the user with choices
param([String[]]$choices, [Int32]$default=0, [String]$message=$null, [String]$question=$null)

$chs = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription];
foreach ($ch in $choices) {
	$chs.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&$ch"));
}

echo $Host.UI.PromptForChoice($message, $question, $chs, $default)
