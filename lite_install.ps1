# Устанавливаем winget
powershell -c "irm https://github.com/asheroto/winget-install/releases/latest/download/winget-install.ps1 | iex"

# Устанавливаем приложения
winget install -e --id Notepad++.Notepad++
winget install -e --id Git.Git
winget install -e --id Apache.OpenOffice
