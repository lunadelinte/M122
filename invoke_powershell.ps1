$desktopPath = "$env:USERPROFILE\Desktop"
$fileName = "example.txt"
$fileContent = "This is an example text file created by PowerShell."

New-Item -ItemType File -Path "$desktopPath\$fileName" -Value $fileContent

