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


