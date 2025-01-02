$Current_Path = $PSScriptRoot

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "=> Installs Scoop..."
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Write-Host "=> Scoop has been installed"
}

if (-not (Test-Path -Path "$HOME\.config\wezterm")) {
	New-Item -ItemType Junction -Path "$HOME\.config\wezterm" -Target "$Current_Path\wezterm\"
	Write-Host "=> Create Wezterm config"
}

if (-not (Test-Path -Path "$HOME\AppData\Local\nvim")) {
	New-Item -ItemType Junction -Path "$HOME\AppData\Local\nvim" -Target "$Current_Path\nvim\"
	Write-Host "=> Create Neovim config"
}

