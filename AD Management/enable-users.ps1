# Enables disabled accounts in entire domain
# Be sure to check for system-generated accounts and add them to the filter terms

$DisabledUsers = (Get-ADUser -Filter 'enabled -eq $false -and SAMAccountName -ne "Guest" -and SAMAccountName -ne "krbtgt"')


ForEach ($U in $DisabledUsers) {
    Enable-ADAccount -Identity $U.SamAccountName}