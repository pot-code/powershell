function state { git status }

function pull { git pull --rebase --autostash }

function push { git push @Args }

function stage { git add . }

function unstage { git restore --staged '*' }

function logs {
  git log --graph --oneline --decorate --pretty=format:"%C(yellow)%h%Creset %s %C(blue)(%ad) %C(green)[%an]%Creset" --date=short
}

function gb { git branch }

function commit { git commit @Args }

function invoke-better-commit {
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
    git commit --no-verify -m "${type}: $scope"
  }
  else {
    git commit --no-verify -m "${type}($scope): $msg"
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

  invoke-better-commit "fix" $scope $msg
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

  invoke-better-commit "feat" $scope $msg
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

  invoke-better-commit "refactor" $scope $msg
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

  invoke-better-commit "refactor" $scope $msg
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

  invoke-better-commit "chore" $scope $msg
}


function amend { git commit --no-verify --amend }

function bb {
  param(
    # 迭代版本
    [Parameter(Position = 1, Mandatory)]
    [string]
    $version,

    # gitee issue id
    [Parameter(Position = 0, Mandatory)]
    [string]
    $id
  )

  git checkout -b "bugfix/$version/$id"
}
