function Set-TaskbarPosition {
    param([int]$position)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3' -Name Settings -Value ([byte[]](Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3' -Name Settings).Settings -replace '^..', ("0x{0:x2}" -f $position))
}

function Set-ColorScheme {
    param([int]$colorScheme)
    Set-ItemProperty -Path 'HKCU:\Control Panel\Colors' -Name "ColorTable{0:D2}" -f $colorScheme -Value "255 0 0"
}

function Set-CursorSize {
    param([int]$size)
    Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'CursorSize' -Value $size
}

function Set-TaskbarTransparency {
    param([int]$transparency)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'UseOLEDTaskbarTransparency' -Value $transparency
}

function Enable-WindowAnimations {
    param([int]$enable)
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Value $enable
}

function Set-AltTabDesign {
    param([int]$tiles)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'AltTabSettings' -Value $tiles
}

function Set-VolumeControlStyle {
    param([int]$style)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion' -Name 'EnableMtcUvc' -Value $style
}

function Set-FullscreenStart {
    param([int]$fullscreen)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'FullScreenStart' -Value $fullscreen
}

function Show-HiddenFilesAndFolders {
    param([int]$show)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value $show
}

function Show-ProtectedSystemFiles {
    param([int]$show)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -Value $show
}