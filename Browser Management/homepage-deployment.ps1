#This will set give.kudosnow.com as the secondary start page for the big three browsers.
#The goal is to set this as a persistent page without disturbing the current Citrix homepage.

#####For IE
#Secondary start page for IE
$Secondary = "https://give.kudosnow.com/users/sign_in/"
set-itemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\Main' -Name "Secondary Start Pages" -Value $Secondary
#####End IE

#####For FireFox
#Navigate to random profile folder
$env:APPDATA
cd $env:appdata
cd 'Mozilla\Firefox\Profiles'
$Profile = dir
cd $Profile

#Check for Citrix Homepage
$Check = (get-content prefs.js) 
$Match = ($Check -match 'https://citrix.effexms.com')
$kudos = 'user_pref("browser.startup.homepage", "https://give.kudosnow.com");'
If ($Check -match'"https://citrix.effexms.com | https://give.kudosnow.com"'){
	write-host "Homepages already set"
}
ElseIf ($Check -match'https://citrix.effexms.com'){
	(get-content prefs.js) | foreach-object {$_ -replace "https://citrix.effexms.com", "https://citrix.effexms.com | https://give.kudosnow.com"} | set-content prefs.js
} 
ElseIf ($Check -match'"https://citrix2.effexms.com | https://give.kudosnow.com"'){
	write-host "Homepages already set"
}
ElseIF ($Check -match'https://citrix2.effexms.com') { 
	(get-content prefs.js) | foreach-object {$_ -replace "https://citrix2.effexms.com", "https://citrix2.effexms.com | https://give.kudosnow.com"} | set-content prefs.js
} 
ElseIf ($Check -match'"https://ctx3.effexms.com | https://give.kudosnow.com"'){
	write-host "Homepages already et"
}
ElseIF ($Check -match'https://ctx3.effexms.com') { 
	(get-content prefs.js) | foreach-object {$_ -replace "https://ctx3.effexms.com", "https://ctx3.effexms.com | https://give.kudosnow.com"} | set-content prefs.js
} 
Else {
	$Kudos | add-content prefs.js
	}
#####End FireFox

#####For Chrome
#Navigate to local appdata folder
$env:LOCALAPPDATA
cd $env:localappdata\google\chrome\user` data\default

#Check Citrix Homepage
$File = (get-content preferences)
$Changes1 = ',"session":{"restore_on_startup":4,"startup_urls":["https://citrix.effexms.com/","https://give.kudosnow.com/"]}}'
$Changes2 = ',"session":{"restore_on_startup":4,"startup_urls":["https://citrix2.effexms.com/","https://give.kudosnow.com/"]}}'
$Changes3 = ',"session":{"restore_on_startup":4,"startup_urls":["https://ctx3.effexms.com/","https://give.kudosnow.com/"]}}'
$CKudos = '"session":{"restore_on_startup":4,"startup_urls":["https://give.kudosnow.com/"]},'
IF ($File -match 'https://citrix.effexms.com'){
	$file.substring(0,$file.length-1) + $Changes | new-item preferences -type file -force
} 
ElseIf ($File -match 'https://citrix2.effexms.com'){
	$file.substring(0,$file.length-1) + $Changes2 | new-item preferences -type file -force
} 
Elseif ($File -match 'https://ctx3.effexms.com'){
	$file.substring(0,$file.length-1) + $Changes3 | new-item preferences -type file -force
} 
Else {
	write-host "No Citrix set"
}
#If a citrix tab is not found in Chrome, do nothing. Chrome hashes default homepages so finding
#where it could be would only result in corrupted prefences.
#####End Chrome

cd $env:userprofile\desktop