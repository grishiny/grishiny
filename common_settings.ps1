# Устанавливаем список языков (Русский — первый/основной, Английский — второй)
Set-WinUserLanguageList -LanguageList "ru-RU", "en-US" -Force

# Устанавливаем Английский (США) как язык ввода по умолчанию (override)
Set-WinDefaultInputMethodOverride -InputTip "0409:00000409"

# Активируем "Позволить выбирать метод ввода для каждого окна приложения"
Set-WinLanguageBarOption -UseLegacySwitchMode

# Меняем сочетание клавиш на Ctrl + Shift (код "2")
if (!(Test-Path "HKCU:\Keyboard Layout\Toggle")) { New-Item -Path "HKCU:\Keyboard Layout\Toggle" -Force }
Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value "2"
Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value "2"

# Отключаем ускорение мыши
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0"


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

#Сносим Onedrive
taskkill /f /im OneDrive.exe
winget uninstall Microsoft.OneDrive
rd /s /q "%UserProfile%\OneDrive"
rd /s /q "%LocalAppData%\Microsoft\OneDrive"
rd /s /q "%ProgramData%\Microsoft OneDrive"

#Сносим виджеты
winget uninstall "Windows Web Experience Pack"

# Ставим старый добрый cmd
reg add "HKCU\Console\%%Startup" /v "DelegationTerminal" /t REG_SZ /d "{B23D10C0-7EB8-410E-9914-24E608F90FFC}" /f
reg add "HKCU\Console\%%Startup" /v "DelegationConsole" /t REG_SZ /d "{B23D10C0-7EB8-410E-9914-24E608F90FFC}" /f
