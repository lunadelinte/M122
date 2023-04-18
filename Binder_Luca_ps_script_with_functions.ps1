Set-ExecutionPolicy RemoteSigned


    function Set-TaskbarTransparency {
        param (
            [bool]$Transparency # $true = Transparent, $false = Opaque
        )
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'UseOLEDTaskbarTransparency' -Value $Transparency
    }

    function Set-WindowAnimations {
        param (
            [bool]$Enable # $true = Enable, $false = Disable
        )
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value $Enable
    }

function Create-MyDocumentsFolders {
    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    $folderNames = @("TBZ", "ÜK", "Sunrise")
    $subFolderNames = @("m242", "m122", "m226b", "m153")

    foreach ($folderName in $folderNames) {
        $newFolderPath = Join-Path -Path $documentsPath -ChildPath $folderName
        if (-not (Test-Path -Path $newFolderPath)) {
            New-Item -ItemType Directory -Path $newFolderPath
        }

        $currentSubFolderNames = @()

        if ($folderName -eq "TBZ") {
            $currentSubFolderNames = $subFolderNames
        }

        if ($folderName -eq "Sunrise") {
            $currentSubFolderNames = @("Lohnausweis", "Sunrise_Projekte")
        }

        if ($folderName -eq "ÜK") {
            $currentSubFolderNames = @("UEK106", "UEK304")
        }

        foreach ($subFolderName in $currentSubFolderNames) {
            $subFolderPath = Join-Path -Path $newFolderPath -ChildPath $subFolderName
            if (-not (Test-Path -Path $subFolderPath)) {
                New-Item -ItemType Directory -Path $subFolderPath
            }

            # Erstelle Testdokumente in jedem Unterordner
            $testDocumentName = ""

            switch ($subFolderName) {
                "m242" { $testDocumentName = "Micropython_Zusammenfassung.txt" }
                "m122" { $testDocumentName = "Powershell_Ideen.txt" }
                "m226b" { $testDocumentName = "Java_Projekt.txt" }
                "m153" { $testDocumentName = "Datenbank.txt" }
                "Lohnausweis" { $testDocumentName = "Lohnabrechnung_2022.txt" }
                "Sunrise_Projekte" { $testDocumentName = "Projektplanung_Vacation_Planner.txt" }
                "UEK106" { $testDocumentName = "ÜK_Präsentation.txt" }
                "UEK304" { $testDocumentName = "ÜK_Lehrmaterialien.txt" }
            }

            $testDocumentPath = Join-Path -Path $subFolderPath -ChildPath $testDocumentName
            if (-not (Test-Path -Path $testDocumentPath)) {
                New-Item -ItemType File -Path $testDocumentPath
            }
        }
    }







# Set Execution Policy
Set-ExecutionPolicy RemoteSigned

# Set Taskbar Transparency to Transparent
Set-TaskbarTransparency -Transparency $true

# Enable Window Animations
Set-WindowAnimations -Enable $true

# Create My Documents Folders "Schule", "ÜK", and "Sunrise"
Create-MyDocumentsFolders




