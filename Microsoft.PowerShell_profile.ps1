# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

Import-Module PSReadLine
Import-Module PSFzf

# For zoxide v0.8.0+
Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
    })

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PSReadlineOption -EditMode vi
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete

function state { git status }

function pull { git pull --rebase --autostash }

function push() {
    git push @Args 
}

function stage { git add . }

function logs {
    git log --graph --oneline --decorate --pretty=format:"%C(yellow)%h%Creset %s %C(blue)(%ad) %C(green)[%an]%Creset" --date=short
}

function gb { git branch }

function untrack {
    git update-index --assume-unchanged @Args
}

function track {
    git update-index --no-assume-unchanged @Args
}

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

function docs {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$no,
        [string]$msg
    )
    if ([string]::IsNullOrEmpty($msg)) {
        git commit -m "docs: $no"
    }
    else {
        git commit -m "docs($no): $msg"
    }
}

function chore {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$no,
        [string]$msg
    )
    if ([string]::IsNullOrEmpty($msg)) {
        git commit -m "chore: $no"
    }
    else {
        git commit -m "chore($no): $msg"
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

function fpa {
    flutter pub add @Args
}

function fpr {
    flutter pub remove @Args
}

function fpg {
    Invoke-Expression "flutter pub get"
}

function fp {
    flutter pub @Args
}

function dev {
    pnpm dev
}

function amend {
    git commit --no-verify --amend
}

function serve {
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$folder,
        [string]$port
    )
    if ([string]::IsNullOrEmpty($port)) {
        caddy file-server --root $folder --listen :3000
    }
    else {
        caddy file-server --root $folder --listen $port
    }
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
