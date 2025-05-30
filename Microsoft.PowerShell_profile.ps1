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

function push {
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

function commit {
    git commit @Args
}

function Invoke-Better-Commit {
    param(
        # 提交类型，例如 feat、fix
        [Parameter(Position = 0, Mandatory)]
        [string]
        $type,

        # 提交 scope 或信息（如果没有提供第三个参数）
        [Parameter(Position = 1, Mandatory)]
        [string]
        $scope,

        # 提交信息，对应 subject，如果没有提供则默认为 scope
        [Parameter(Position = 2)]
        [string]
        $msg
    )
    if ([string]::IsNullOrEmpty($msg)) {
        git commit -m "${type}: $scope"
    }
    else {
        git commit -m "${type}($scope): $msg"
    }
}

function fix {
    param(
        # 提交 scope 或信息（如果没有提供第三个参数）
        [Parameter(Position = 1, Mandatory)]
        [string]
        $scope,

        # 提交信息，对应 subject，如果没有提供则默认为 scope
        [Parameter(Position = 2)]
        [string]
        $msg
    )

    Invoke-Better-Commit "fix" $scope $msg
}

function feat {
    param(
        # 提交 scope 或信息（如果没有提供第三个参数）
        [Parameter(Position = 1, Mandatory)]
        [string]
        $scope,

        # 提交信息，对应 subject，如果没有提供则默认为 scope
        [Parameter(Position = 2)]
        [string]
        $msg
    )

    Invoke-Better-Commit "feat" $scope $msg
}

function refactor {
    param(
        # 提交 scope 或信息（如果没有提供第三个参数）
        [Parameter(Position = 1, Mandatory)]
        [string]
        $scope,

        # 提交信息，对应 subject，如果没有提供则默认为 scope
        [Parameter(Position = 2)]
        [string]
        $msg
    )

    Invoke-Better-Commit "refactor" $scope $msg
}

function docs {
    param(
        # 提交 scope 或信息（如果没有提供第三个参数）
        [Parameter(Position = 1, Mandatory)]
        [string]
        $scope,

        # 提交信息，对应 subject，如果没有提供则默认为 scope
        [Parameter(Position = 2)]
        [string]
        $msg
    )

    Invoke-Better-Commit "refactor" $scope $msg
}

function chore {
    param(
        # 提交 scope 或信息（如果没有提供第三个参数）
        [Parameter(Position = 1, Mandatory)]
        [string]
        $scope,

        # 提交信息，对应 subject，如果没有提供则默认为 scope
        [Parameter(Position = 2)]
        [string]
        $msg
    )

    Invoke-Better-Commit "chore" $scope $msg
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
