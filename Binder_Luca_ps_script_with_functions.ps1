# Set Execution Policy to allow remotely signed scripts
Set-ExecutionPolicy RemoteSigned

# Function to Enable or Disable Window Animations
function Set-WindowAnimations {
    param (
        [bool]$Enable # $true = Enable, $false = Disable
    )
    # Set the 'MinAnimate' registry key value to enable or disable animations
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value $Enable
}

# Function to create custom folders and subfolders in My Documents
function Create-MyDocumentsFolders {
    # Get My Documents folder path
    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    # Define parent folder names
    $folderNames = @("TBZ", "ÜK", "Sunrise")
    # Define subfolder names for the TBZ folder
    $subFolderNames = @("m242", "m122", "m226b", "m153")

    # Loop through each parent folder name
    foreach ($folderName in $folderNames) {
        # Construct the new folder path
        $newFolderPath = Join-Path -Path $documentsPath -ChildPath $folderName
        # If the new folder doesn't exist, create it
        if (-not (Test-Path -Path $newFolderPath)) {
            New-Item -ItemType Directory -Path $newFolderPath
        }

        # Create an array to store the current subfolder names
        $currentSubFolderNames = @()

        # Add the appropriate subfolder names depending on the parent folder
        if ($folderName -eq "TBZ") {
            $currentSubFolderNames = $subFolderNames
        }

        if ($folderName -eq "Sunrise") {
            $currentSubFolderNames = @("Lohnausweis", "Sunrise_Projekte")
        }

        if ($folderName -eq "ÜK") {
            $currentSubFolderNames = @("UEK106", "UEK304")
        }

        # Loop through each subfolder name
        foreach ($subFolderName in $currentSubFolderNames) {
            # Construct the subfolder path
            $subFolderPath = Join-Path -Path $newFolderPath -ChildPath $subFolderName
            # If the subfolder doesn't exist, create it
            if (-not (Test-Path -Path $subFolderPath)) {
                New-Item -ItemType Directory -Path $subFolderPath
            }

            # Create test documents in each subfolder using a switch statement
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

            # Construct the test document path
            $testDocumentPath = Join-Path -Path $subFolderPath -ChildPath $testDocumentName
            # If the test document doesn't exist, create it
            if (-not (Test-Path -Path $testDocumentPath)) {
                New-Item -ItemType File -Path $testDocumentPath
            }
        }
    }
}

# Function to create desktop shortcuts for the custom folders in My Documents
function Create-DesktopShortcuts {
    # Get Desktop and My Documents folder paths
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    # Define parent folder names
    $folderNames = @("TBZ", "ÜK", "Sunrise")

    # Loop through each parent folder name
    foreach ($folderName in $folderNames) {
        # Construct the source path in My Documents and the shortcut path on the Desktop
        $sourcePath = Join-Path -Path $documentsPath -ChildPath $folderName
        $shortcutPath = Join-Path -Path $desktopPath -ChildPath "$folderName.lnk"

        # If the shortcut doesn't exist, create it
        if (-not (Test-Path -Path $shortcutPath)) {
            $WshShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WshShell.CreateShortcut($shortcutPath)
            $Shortcut.TargetPath = $sourcePath
            $Shortcut.Save()
        }
    }
}

# Set Execution Policy to allow remotely signed scripts
Set-ExecutionPolicy RemoteSigned

# Enable Window Animations
Set-WindowAnimations -Enable $true

# Create My Documents Folders "TBZ", "ÜK", and "Sunrise"
Create-MyDocumentsFolders

# Create Desktop Shortcuts for "TBZ", "ÜK", and "Sunrise"
Create-DesktopShortcuts


