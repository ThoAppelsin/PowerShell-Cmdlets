# cd's into the path of the provided command
Set-Location (Split-Path (which "$args"))
