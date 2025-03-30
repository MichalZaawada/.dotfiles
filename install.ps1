function Install-ConfigLink
{
	param (
		[string]$Path,
		[string]$Target,
		[string]$Name,
		[ValidateSet('SymbolicLink', 'Junction')]
		[string]$LinkType
	)

	if (-not (Test-Path -Path $Path))
	{
		New-Item -ItemType $LinkType -Path $Path -Target $Target
		Write-Host "=> Create $Name config"
	} else
	{
		Write-Host "=> $Name config exist..."
	}
}

$Current_Path = $PSScriptRoot

if (-not (Get-Command scoop -ErrorAction SilentlyContinue))
{
	Write-Host "=> Installs Scoop..."
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	Write-Host "=> Scoop has been installed"
} else
{
	Write-Host "=> Scoop was installed..."
}
 

$scoopApps = @("wezterm", "neovim-nightly", "glazewm", "zed", "zig", "starship", "zebar", "lazygit")
foreach ($app in $scoopApps) {
	Write-Host "=> Installing $app..."
	scoop install $app
}


Install-ConfigLink `
	-Path "$HOME\Documents\PowerShell\Profile.ps1" `
	-Target "$Current_Path\Profile.ps1" `
	-Name "Powershell" `
	-LinkType "SymbolicLink"

Install-ConfigLink `
	-Path "$HOME\.config\wezterm" `
	-Target "$Current_Path\wezterm\" `
	-Name "Wezterm" `
	-LinkType "Junction"

Install-ConfigLink `
	-Path "$HOME\AppData\Local\nvim" `
	-Target "$Current_Path\nvim\" `
	-Name "Neovim" `
	-LinkType "Junction"

Install-ConfigLink `
	-Path "$HOME\AppData\Roaming\Zed\themes" `
	-Target "$Current_Path\zed\themes\" `
	-Name "Zed themes" `
	-LinkType "Junction"

Install-ConfigLink `
	-Path "$HOME\AppData\Roaming\Zed\keymap.json" `
	-Target "$Current_Path\zed\keymap.json" `
	-Name "Zed keymap.json" `
	-LinkType "SymbolicLink"

Install-ConfigLink `
	-Path "$HOME\AppData\Roaming\Zed\settings.json" `
	-Target "$Current_Path\zed\settings.json" `
	-Name "Zed settings.json" `
	-LinkType "SymbolicLink"
