py Tester.py
ls ..\testcases\input* | foreach { Write-Host ($_.name + ' given: '); (cat $_ | py .\Main.py); Write-Host 'expected:'; (cat ("..\testcases\output" + $_.name.substring(5))) }
