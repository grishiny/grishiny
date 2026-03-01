# Устанавливаем список языков (Английский — первый/основной, Русский — второй)
Set-WinUserLanguageList -LanguageList "en-US", "ru-RU" -Force

# Меняем сочетание клавиш на Ctrl + Shift (код "2")
if (!(Test-Path "HKCU:\Keyboard Layout\Toggle")) { New-Item -Path "HKCU:\Keyboard Layout\Toggle" -Force }
Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value "2"
Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value "2"

# Применяем настройки для экрана входа и новых пользователей
# Создаем временный файл ответов для системной утилиты
# Запускаем копирование настроек (требуются права администратора)
# Удаляем временный файл
$XmlPath = "$env:TEMP\LanguageSettings.xml"
$XmlContent = '<gs:GlobalizationServices xmlns:gs="urn:longhornGlobals"><gs:UserList><gs:User UserID="Current" CopySettingsToSystem="true" CopySettingsToDefaultUser="true" /></gs:UserList></gs:GlobalizationServices>'
[System.IO.File]::WriteAllText($XmlPath, $XmlContent)
Start-Process -FilePath "control.exe" -ArgumentList "intl.cpl,,/f:`"$XmlPath`"" -Wait
Remove-Item $XmlPath

# Убираем Пуск влево
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0

# Убираем строку поиска с панели задач
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

# Устанавливаем winget
powershell -c "irm https://github.com/asheroto/winget-install/releases/latest/download/winget-install.ps1 | iex"

# Устанавливаем приложения
winget install -e --id Mozilla.Firefox.ESR
winget install -e --id FarManager.FarManager
winget install -e --id Notepad++.Notepad++
winget install -e --id Git.Git
winget install -e --id 7zip.7zip
winget install -e --id CodecGuide.K-LiteCodecPack.Full
winget install -e --id clsid2.mpc-hc
winget install -e --id Apache.OpenOffice
winget install -e --id Telegram.TelegramDesktop
winget install -e --id Nvidia.app
winget install -e --id Valve.Steam
winget install -e --id Abbodi1406.vcredistRepo
winget install -e --id Dropbox.Dropbox
winget install -e --id Boxcryptor.Boxcryptor
