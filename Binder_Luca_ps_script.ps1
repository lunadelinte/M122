# Taskleistenposition ändern (0 = Links, 1 = Oben, 2 = Rechts, 3 = Unten)
$taskbarPosition = 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3' -Name Settings -Value ([byte[]](Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3' -Name Settings).Settings -replace '^..', ("0x{0:x2}" -f $taskbarPosition))

# Farbschema ändern (Werte von 1 bis 24, wobei 1 = Blau, 2 = Grün, 3 = Rot usw.)
$colorScheme = 2
Set-ItemProperty -Path 'HKCU:\Control Panel\Colors' -Name "ColorTable{0:D2}" -f $colorScheme -Value "255 0 0"

# Mauszeigergröße ändern (1 = Klein, 2 = Mittel, 3 = Groß)
$cursorSize = 3
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'CursorSize' -Value $cursorSize

# Transparenz der Taskleiste ändern (0 = undurchsichtig, 1 = transparent)
$taskbarTransparency = 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'UseOLEDTaskbarTransparency' -Value $taskbarTransparency

# Fensteranimationen aktivieren (1 = aktiviert, 0 = deaktiviert)
$enableAnimations = 1
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value $enableAnimations

# Alt+Tab-Design ändern (1 = Kacheln, 0 = klassisches Design)
$altTabTiles = 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'AltTabSettings' -Value $altTabTiles

# Lautstärkeregler-Design ändern (1 = Windows 10-Stil, 0 = klassischer Stil)
$volumeControlStyle = 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion' -Name 'EnableMtcUvc' -Value $volumeControlStyle

# Startmenü im Vollbildmodus anzeigen (1 = aktiviert, 0 = deaktiviert)
$fullscreenStart = 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'FullScreenStart' -Value $fullscreenStart

# Versteckte Dateien und Ordner anzeigen (1 = aktiviert, 0 = deaktiviert)
$showHiddenFiles = 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value $showHiddenFiles

# Geschützte Betriebssystemdateien anzeigen (1 = aktiviert, 0 = deaktiviert)
$showProtectedSystemFiles = 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Value $showProtectedSystemFiles

# Desktop-Icons vergrößern
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'LogPixels' -Value 120
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 1, True

$wallpaperPath = "C:\Pfad\zum\Hintergrundbild.jpg"
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'Wallpaper' -Value $wallpaperPath
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters 1, True

$disabledItems = "appwiz.cpl", "timedate.cpl"
foreach ($item in $disabledItems) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name ("DisallowCpl_{0}" -f $item) -Value 1
}

function Create-Folders {
    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    $folderNames = @("Schule", "ÜK", "Sunrise")

    foreach ($folderName in $folderNames) {
        $newFolderPath = Join-Path -Path $documentsPath -ChildPath $folderName
        if (-not (Test-Path -Path $newFolderPath)) {
            New-Item -ItemType Directory -Path $newFolderPath
        }
    }
}

Create-Folders

function Install-SoftwarePackages {
    $softwarePackages = @(
        @{ Name = "Google Chrome"; Search = "Google Chrome"; Installer = "https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe"; Arguments = "/silent /install" },
        @{ Name = "VLC"; Search = "VLC media player"; Installer = "https://get.videolan.org/vlc/last/win64/vlc-3.0.16-win64.exe"; Arguments = "/L=1031 /S" }
    )

    foreach ($package in $softwarePackages) {
        $searchResult = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like $package.Search }
        if ($searchResult -eq $null) {
            Write-Host "Installing $($package.Name)"
            $installerPath = Join-Path -Path $env:TEMP -ChildPath "$($package.Name)_installer.exe"
            Invoke-WebRequest -Uri $package.Installer -OutFile $installerPath
            Start-Process -FilePath $installerPath -ArgumentList $package.Arguments -Wait
            Remove-Item -Path $installerPath
        } else {
            Write-Host "$($package.Name) is already installed"
        }
    }
}

Install-SoftwarePackages
