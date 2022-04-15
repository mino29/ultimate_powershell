$path = "~\Documents\Powershell"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}


Copy-Item .\Microsoft.PowerShell_profile.ps1 ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
Write-Host "powershell 5.1 updated"
Copy-Item .\Microsoft.PowerShell_profile.ps1 ~\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1
Write-Host "vscode powershell 5.1 updated"
Copy-Item .\Microsoft.Powershell_profile.ps1 ~\Documents\PowerShell\Microsoft.Powershell_profile.ps1
Write-Host "powershell 7 updated"
Copy-Item .\Microsoft.Powershell_profile.ps1 ~\Documents\PowerShell\Microsoft.VSCode_profile.ps1
Write-Host "vscode powershell 7 updated"
Copy-Item .\Microsoft.Powershell_profile.ps1 ~\Documents\Powershell\coc.vim_profile.ps1
Write-Host "coc-powershell updated"
