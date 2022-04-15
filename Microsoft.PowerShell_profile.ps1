
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}




<#
 * FileName: Microsoft.PowerShell_profile.ps1
 * Author: Wu Zhongzheng
 * Email: zhongzheng.wu@outlook.com
 * Date: 2022, Mar. 6
 * Copyright: No copyright. You can use this code for anything with no warranty.
#>


#------------------------------- Import Modules BEGIN -------------------------------
# 引入 posh-git
Import-Module posh-git

# 引入 oh-my-posh
Import-Module oh-my-posh

# 引入 ps-read-line
Import-Module PSReadLine

# 引入terminal-icons
Import-Module -Name Terminal-Icons

# 引入Zlocation (powerful cd)
# full command-let is invoke-Zlocation, z for short
# z c: will get you to c drive
Import-Module ZLocation


# 设置 PowerShell 主题
# Set-PoshPrompt ys
Set-PoshPrompt -Theme atomicBit
# Set-PoshPrompt -Theme C:\Users\Scarlet\.config\oh-my-posh_custom\powerlevel10k_rainbow.omp.json
#------------------------------- Import Modules END   -------------------------------





#-------------------------------  Set Hot-keys BEGIN  -------------------------------
# 设置预测文本来源为历史记录
# Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionSource History


# vim binding to powershell, uncoment one or the other
Set-PSReadlineOption -EditMode vi
# Set-PSReadLineOption -EditMode Windows

# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# 设置 Ctrl+d 为退出 PowerShell
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit

# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# 设置列表历史选项, F2切换
set-psreadlineoption -PredictionViewStyle ListView
set-psreadlineoption -PredictionViewStyle InlineView

#-------------------------------  Set Hot-keys END    -------------------------------





#-------------------------------    Functions BEGIN   -------------------------------
# Python 直接执行
$env:PATHEXT += ";.py"

# 更新系统组件
function Update-Packages {
	# update conda packages (avoid conflit)
	Write-Host "Step 1: Update conda " -ForegroundColor Magenta -BackgroundColor Cyan
    conda update --all
    
	# update pip (comment out this if you use conda)
	# Write-Host "Step 1: 更新 pip" -ForegroundColor Magenta -BackgroundColor Cyan
	# $a = pip list --outdated
	# $num_package = $a.Length - 2
	# for ($i = 0; $i -lt $num_package; $i++) {
	# 	$tmp = ($a[2 + $i].Split(" "))[0]
	# 	pip install -U $tmp
	# }

	# update TeX Live
	$CurrentYear = Get-Date -Format yyyy
	Write-Host "Step 2: Update TeX Live" $CurrentYear -ForegroundColor Magenta -BackgroundColor Cyan
	tlmgr update --self
	tlmgr update --all

	# update Chocolotey
	Write-Host "Step 3: Update Chocolatey" -ForegroundColor Magenta -BackgroundColor Cyan
	choco outdated
    choco upgrade --all

	# update Scoop
	Write-Host "Step 4: Update Scoop" -ForegroundColor Magenta -BackgroundColor Cyan
    scoop update --all
}
#-------------------------------    Functions END     -------------------------------





#-------------------------------   Set Alias BEGIN    -------------------------------
# 1. 编译函数 make
function MakeThings {
	nmake.exe $args -nologo
}
Set-Alias -Name make -Value MakeThings

# 2. 更新系统 os-update
Set-Alias -Name os-update -Value Update-Packages

# 3. 查看目录 ls & ll
function ListDirectory {
	(Get-ChildItem).Name
	Write-Host("")
}
Set-Alias -Name ls -Value ListDirectory -Option AllScope
Set-Alias -Name ll -Value Get-ChildItem

# 4. 打开当前工作目录
function OpenCurrentFolder {
	param
	(
		# 输入要打开的路径
		# 用法示例：open C:\
		# 默认路径：当前工作文件夹
		$Path = '.'
	)
	Invoke-Item $Path
}
Set-Alias -Name open -Value OpenCurrentFolder

# 5. neovim aliases/ change nvim to vim if you use vim

Set-Alias -Name v -Value nvim
Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim

# 6. more "aliases"
# Set-Alias -Name ":q" -Value "exit"
Set-Alias -Name cc -Value clear

#-------------------------------    Set Alias END     -------------------------------





#-------------------------------   Set Network BEGIN    -------------------------------
# 1. 获取所有 Network Interface
function Get-AllNic {
	Get-NetAdapter | Sort-Object -Property MacAddress
}
Set-Alias -Name getnic -Value Get-AllNic

# 2. 获取 IPv4 关键路由
function Get-IPv4Routes {
	Get-NetRoute -AddressFamily IPv4 | Where-Object -FilterScript { $_.NextHop -ne '0.0.0.0' }
}
Set-Alias -Name getip -Value Get-IPv4Routes

# 3. 获取 IPv6 关键路由
function Get-IPv6Routes {
	Get-NetRoute -AddressFamily IPv6 | Where-Object -FilterScript { $_.NextHop -ne '::' }
}
Set-Alias -Name getip6 -Value Get-IPv6Routes
#-------------------------------    Set Network END     -------------------------------


#-------------------------------   Set z.lua BEGIN    -------------------------------

# Invoke-Expression (& { (lua ~/z.lua/z.lua --init powershell) -join "`n" })


#-------------------------------    Set z.lua END     -------------------------------



#-------------------------------   Set starship BEGIN    -------------------------------

# $ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
# # $ENV:STARSHIP_DISTRO = " 者 x 💀 "
# Invoke-Expression (&starship init powershell)

#-------------------------------   Set starship END    -------------------------------

