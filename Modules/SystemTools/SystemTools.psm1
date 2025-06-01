function proxy {
  if ($null -eq [System.Environment]::GetEnvironmentVariable('HTTP_PROXY')) {
    [System.Environment]::SetEnvironmentVariable('HTTP_PROXY', "http://127.0.0.1:7890")
  }
  if ($null -eq [System.Environment]::GetEnvironmentVariable('HTTPS_PROXY')) {
    [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY', "http://127.0.0.1:7890")
  }
}

function remove-proxy {
  [System.Environment]::SetEnvironmentVariable('HTTP_PROXY', $null)
  [System.Environment]::SetEnvironmentVariable('HTTPS_PROXY', $null)
}