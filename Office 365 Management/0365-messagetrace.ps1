# Will search through the $Sender's Office 365 emails starting from the $Start and ending on the $End
# The times are UTC, not local

$LiveCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $LiveCred -Authentication Basic -AllowRedirection
$Start = "03/15/2017 9:50 AM"
$End = "03/15/2017 6:02 PM"
$Sender = "sender@domain.com"
Import-PSSession $Session
Get-MessageTrace -SenderAddress $Sender -StartDate $Start -EndDate $End | Select-Object Received, SenderAddress, RecipientAddress, Subject, Status, MessageID, MessageTraceID | export-csv -Path output.csv