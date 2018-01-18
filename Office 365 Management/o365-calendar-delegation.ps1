# Add Delegation to Calendar in Office365 environment.
# User is identity ADUser.Name. Could potentially use SamAccountName.

$Cred = Get-Credential
$Calendar = read-host -prompt 'Which calendar are we modifying?'
$User = read-host -prompt 'Which user is getting the delegation?'
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Authentication Basic -Credential $Cred -AllowRedirection
Import-PSSession -session $Session
Set-CalendarProcessing -Identity $Calendar -ResourceDelegates $User
Get-PSSession | Remove-PSSession