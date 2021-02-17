$dir = Read-Host "Project Directory"
$token = Read-Host "Name of original project"
$newtoken = Read-Host "Name of new project"

#renames all items with your newtoken that matches the old token
get-childitem -Path "$dir" -Recurse | where-object { $_.Name -like "*" + $token + "*" } | Rename-Item -NewName {$_.name -replace $token, $newtoken} 

#gets all files not in the bin or obj folders
get-childitem -Path "$dir" -Recurse | where { ! $_.PSIsContainer -and $_.FullName -notmatch '\\bin\\' -and $_.FullName -notmatch '\\obj\\' } |

Foreach-Object {  
    (Get-Content -path $_.FullName) -replace $token, $newtoken | Set-Content -Path $_.FullName
}