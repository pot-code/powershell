Import-Module PSReadLine
Import-Module PSFzf

Import-Module GitTools
Import-Module SystemTools
Import-Module NpmTools

# For zoxide v0.8.0+
Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
    })

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PSReadlineOption -EditMode vi
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
