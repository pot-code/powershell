# 1. 安装依赖
if (-not (Get-Command zoxide -ErrorAction SilentlyContinue)) {
  winget install ajeetdsouza.zoxide
}

if (-not (Get-Module -ListAvailable -Name PSFzf)) {
  Install-Module -Name PSFzf -RequiredVersion 2.6.7
}

# 2. 注册模块地址
$modulePath = "$PSScriptRoot\Modules"
[Environment]::SetEnvironmentVariable(
  'PSModulePath',
  "$($env:PSModulePath);$modulePath",
  [System.EnvironmentVariableTarget]::User
)

# 3. 链接 profile
$target = $PROFILE

if (Test-Path $target) {
  Remove-Item $target
}

New-Item -Path $target -ItemType SymbolicLink -Target $PSScriptRoot\Profile.ps1
Write-Output "配置已链接到 $PROFILE，请重新打开 PowerShell"