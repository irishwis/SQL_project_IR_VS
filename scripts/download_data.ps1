# Скачивает 8 файлов Berka и описание в data\raw.
# Запуск из корня репозитория в PowerShell:
#   powershell -ExecutionPolicy Bypass -File scripts\download_data.ps1
$base = "https://raw.githubusercontent.com/jlacko/berka-dataset/master"
$dest = Join-Path $PSScriptRoot "..\data\raw"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
$files = "account.asc","client.asc","disp.asc","order.asc","trans.asc","loan.asc","card.asc","district.asc","Financial Data description.pdf"
foreach ($f in $files) {
    $url = "$base/" + [uri]::EscapeDataString($f)
    Write-Host "Скачиваю $f ..."
    Invoke-WebRequest -Uri $url -OutFile (Join-Path $dest $f) -UseBasicParsing
}
Write-Host "Готово: файлы в $dest"
