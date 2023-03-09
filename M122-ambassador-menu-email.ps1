$email_text = ""
$url = "https://www.ambassador-restaurant.ch/de/menuplan/"
$response = Invoke-WebRequest -Uri $url
$menu_item = ($response.ParsedHtml.getElementsByTagName('h2') | Where {$_.ClassName -eq "menu-title"}).InnerText
$menu_line = ($response.ParsedHtml.getElementsByTagName('span') | Where {$_.ClassName -eq "menuline"}).InnerText
$menu_text = ($response.ParsedHtml.getElementsByTagName('p') | Where {$_.ClassName -eq "menu-description"}).InnerText
$menu_line = $menu_line -split '\r?\n' | Select-Object -First 5
$menu_item = $menu_item -split '\r?\n' | Select-Object -First 5
$menu_text = $menu_text -split '\r?\n' | Select-Object -First 5
for ($i = 0; $i -lt $menu_line.Length; $i++){
    $email_text += @"
----------------------
Küche: $($menu_line[$i])
Titel: $($menu_item[$i])
----------------------
$($menu_text[$i])
----------------------
"@
}
$email_text = $email_text -replace "Unsere Klassiker bieten wir Ihnen täglich an.", ""
# Create an Outlook application object
$ol = New-Object -ComObject Outlook.Application
# Create an email object
$mail = $ol.CreateItem(0)
# Set email properties
$mail.To = "luca.binder.privat@gmail.com"
$date = Get-Date -Format "dd/MM/yyyy"
$mail.Subject = "Menu from " + $date
$mail.Body = $email_text
$mail.Importance = 1
# Send the email
$mail.Send()
