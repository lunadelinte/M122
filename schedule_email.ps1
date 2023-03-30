# Define the name and description of the task
$TaskName = "Send menu Email"
$TaskDescription = "This task sends an Email with the Ambassador menu every weekday morning at 08:00"

# Define the action to be taken by the task
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file `"$PSScriptRoot\send_mail.ps1`""

# Define the trigger for the task
$Trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At 8:00am

# Create the scheduled task
Register-ScheduledTask -TaskName $TaskName -Description $TaskDescription -Action $Action -Trigger $Trigger
