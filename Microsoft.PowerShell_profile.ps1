# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Import-Module posh-git
Import-Module PSReadLine
# Import-Module PSFzf
# Import-Module Terminal-Icons
# Import-Module git-aliases -DisableNameChecking
# Invoke-Expression (&starship init powershell)

# For zoxide v0.8.0+
Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
    })

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PSReadlineOption -EditMode vi
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete

# oh-my-posh init pwsh --config 'C:\Users\HP\Documents\PowerShell\Themes\hul10.omp.json' | Invoke-Expression
# oh-my-posh init pwsh --config 'C:\Users\HP\AppData\Local\Programs\oh-my-posh\themes\microverse-power.omp.json' | Invoke-Expression
# oh-my-posh init pwsh --config 'C:\Users\HP\AppData\Local\Programs\oh-my-posh\themes\peru.omp.json' | Invoke-Expression
# oh-my-posh init pwsh --config 'C:\Users\HP\AppData\Local\Programs\oh-my-posh\themes\sonicboom_dark.omp.json' | Invoke-Expression

function state { git status }

function pull { git pull --rebase --autostash }

function push() {
    git push @Args 
}

function stage { git add . }

function glog { git log --oneline --decorate --graph }

function gb { git branch }

function commit() {
    git commit @Args
}

function fix {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$no,
        [string]$msg
    )
    if ([string]::IsNullOrEmpty($msg)) {
        git commit -m "fix: $no"
    }
    else {
        git commit -m "fix($no): $msg"
    }
}

function feat {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$no,
        [string]$msg
    )
    if ([string]::IsNullOrEmpty($msg)) {
        git commit -m "feat: $no"
    }
    else {
        git commit -m "feat($no): $msg"
    }
}

function refactor {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$no,
        [string]$msg
    )
    if ([string]::IsNullOrEmpty($msg)) {
        git commit -m "refactor: $no"
    }
    else {
        git commit -m "refactor($no): $msg"
    }
}

function pi {
    $PackagesString = $args -join ' '

    Invoke-Expression "pnpm install $PackagesString"
}

function pdi {
    $PackagesString = $args -join ' '

    Invoke-Expression "pnpm install -D $PackagesString"
}

function prm {
    $PackagesString = $args -join ' '

    Invoke-Expression "pnpm rm $PackagesString"
}

function pui {
    $PackagesString = $args -join ' '

    Invoke-Expression "pnpm upgrade --interactive $PackagesString"
}

function pd { pnpm dev }

# dart run build_runner
function drb {
    dart run build_runner build
}

function fpa {
    flutter pub add @Args
}

function fpr {
    flutter pub remove @Args
}

function fp {
    flutter pub @Args
}

function proxy {
    if ($null -eq [System.Environment]::GetEnvironmentVariable('HTTP_PROXY')) {
        [System.Environment]::SetEnvironmentVariable('HTTP_PROXY', "http://127.0.0.1:7890")
    }
    if ($null -eq [System.Environment]::GetEnvironmentVariable('HTTPS_PROXY')) {
        [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY', "http://127.0.0.1:7890")
    }
}

function unproxy {
    [System.Environment]::SetEnvironmentVariable('HTTP_PROXY', $null)
    [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY', $null)
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

