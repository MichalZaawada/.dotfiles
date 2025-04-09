Import-Module -Name Terminal-Icons
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Alias lg lazygit
Set-Alias vi nvim

Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"

$ExecutionContext.InvokeCommand.PreCommandLookupAction = {
    param($commandName, $commandLookupEventArgs)
    switch ($commandName)
    {
        'nvim'
        { 
            $host.UI.RawUI.WindowTitle = "nvim"
            break
        }
        'npm'
        { 
            $host.UI.RawUI.WindowTitle = "npm"
            break
        }
    }
}

$prompt = ""

function Invoke-Starship-PreCommand
{
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem")
    {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

$oldPrompt = $function:prompt

function prompt
{
    $currentFolder = Split-Path -Leaf (Get-Location)
    $host.UI.RawUI.WindowTitle = $currentFolder
    & $oldPrompt
}
