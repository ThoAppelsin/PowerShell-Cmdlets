$path = $pwd.Path
[System.Environment]::SetEnvironmentVariable('Q_DIR', $path, [System.EnvironmentVariableTarget]::User)
$env:Q_DIR = $path
