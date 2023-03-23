# Define the name and description of the task
$TaskName = "Open Outlook"
$TaskDescription = "This task opens Outlook every weekday morning at 07:50"

# Define the action to be taken by the task
$Action = New-ScheduledTaskAction -Execute "runas.exe" -Argument "/savecred /user:Administrator `"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE`""

# Define the trigger for the task
$Trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At 7:50am

# Create the scheduled task
Register-ScheduledTask -TaskName $TaskName -Description $TaskDescription -Action $Action -Trigger $Trigger
