# 1. 安装依赖
winget install ajeetdsouza.zoxide
Install-Module -Name PSFzf -RequiredVersion 2.6.7

# 2. 注册模块地址
$modulePath = "$PSScriptRoot\Modules"
[Environment]::SetEnvironmentVariable(
  'PSModulePath',
  "$($env:PSModulePath);$modulePath",
  [System.EnvironmentVariableTarget]::Machine
)

# 3. 链接 profile
$target = $PROFILE

if (Test-Path $target) {
  Copy-Item $target $target.bak -Force
  Remove-Item $target
}

New-Item -Path $PROFILE -ItemType SymbolicLink -Target $PSScriptRoot\Profile.ps1
Write-Output "配置已链接到 $PROFILE，请重新打开 PowerShell"