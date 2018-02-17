# Variables
$Choice = Read-Host -Prompt "We are creating a new user. Are you sure? (y/n)"
$FN = Read-Host -Prompt "What is the new user's first name?"
$LN = Read-Host -Prompt "What is the new user's last name?"
$Pass = Read-Host -AsSecureString "What shall we set this user's password to?"
$FullName = $FN +" " + $LN
$UN = Read-Host -Prompt "What username would you like to assign to the new user?"
$Roles = Read-Host -Prompt "What department will this user be in?"
$Enable = Read-Host -Prompt "$UN was created in the $Roles department. Would you like to enable this user (y/n)?"

# Retreive basic user details
If ($Choice -eq "y") {
    New-ADUser -Name $FullName -SamAccountName $UN -AccountPassword $Pass -ChangePasswordAtLogon $true
} elseif ($Choice -eq "n") {
    Write-Host "Okay then, cancelling request"
} else { Write-Host "I'm sorry, I didn't catch that. Please try again" }

# Assign security groups
if ($Roles -eq "IT") {
    Add-ADGroupMember -Identity $Roles $UN -Confirm
} else { Add-ADGroupMember -Identity $Roles $UN }
 

# Enable account now or later
If ($Enable -eq "y") {
    Enable-ADAccount -Identity $UN 
} else {Write-Host "$UN will not be activated at this time."}

