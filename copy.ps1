$param = 1
# 如果没有传入参数，则默认为1
if ($args.Count -ne 0) {
    $param = $args[0]
}

# 检查 out-dir 是否存在，如果不存在则创建
if (-not (Test-Path -Path "out-dir" -PathType Container)) {
    New-Item -ItemType Directory -Path "out-dir"
}

# 清空 out-dir 目录内的文件
Remove-Item -Path "out-dir\*" -Force

# 复制文件到 out-dir

$filePaths = $(git diff --name-only --diff-filter=d HEAD~$param)
foreach ($file in $filePaths) {
    Write-Host "Copy ""$file"" to out-dir"
    Copy-Item $file out-dir 
}