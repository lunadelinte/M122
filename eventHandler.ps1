function eventHandler()
{
    Write-Host "Hallo"
}

function mouseMoveHandler()
{
    $msg = "X: {0} Y: {1}" -f $_.X, $_.Y
    Write-host $msg
}

function KeyDownHandler()
{
    Write-host $_.KeyData
}

$f = New-Object System.Windows.Forms.Form
$f.Add_MouseMove({ mouseMoveHandler})

$b = New-Object System.Windows.Forms.Button
$b.Text = "OK"
$b.Add_Click({ eventHandler })
$f.Controls.Add($b)

$tb = New-Object System.Windows.Forms.TextBox
$f.Controls.Add($tb)
$tb.Add_KeyDown({ KeyDownHandler})

$f.ShowDialog()

# $f = $null