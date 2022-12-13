py $env:CMDLETSDIR/t150.py "$(pwd)"
# py Tester.py
# ls ..\testcases\input* | foreach { Write-Host ($_.name + ' given: '); (cat $_ | py .\Main.py); Write-Host 'expected:'; (cat ("..\testcases\output" + $_.name.substring(5))) }
