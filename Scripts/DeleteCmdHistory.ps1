# 删除最近 100 条历史命令之前的所有历史命令

# 定义历史文件路径
$historyPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"

# 读取全部历史命令
$allHistory = Get-Content -Path $historyPath

# 保留最后 100 行
$recentHistory = $allHistory | Select-Object -Last 100

# 覆盖原始历史文件
$recentHistory | Set-Content -Path $historyPath -Encoding UTF8
