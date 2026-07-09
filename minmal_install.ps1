# Устанавливаем winget
powershell -c "irm https://github.com/asheroto/winget-install/releases/latest/download/winget-install.ps1 | iex"

# Ставим Mozilla Firefox с uBlock
winget install -e --id Mozilla.Firefox.ESR

$policiesPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox\Extensions"
$jsonFile = @{
    "uBlock0@raymondhill.net" = @{
        "installation_mode" = "normal_installed"
        "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
    }
}
if (-not (Test-Path $policiesPath)) {
    New-Item -Path $policiesPath -Force | Out-Null
}
Set-ItemProperty -Path $policiesPath -Name "uBlock0@raymondhill.net" -Value ($jsonFile | ConvertTo-Json -Compress) -Force
Write-Host "Предустановка uBlock Origin настроена. Расширение предложит установку при запуске Firefox." -ForegroundColor Cyan

# Устанавливаем приложения
winget install -e --id FarManager.FarManager
winget install -e --id 7zip.7zip
winget install -e --id CodecGuide.K-LiteCodecPack.Full
winget install -e --id clsid2.mpc-hc
winget install -e --id Telegram.TelegramDesktop
winget install -e --id MatsuriDayo.NekoRay
