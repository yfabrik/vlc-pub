# le but 
lire une playlist VLC en plein écran sur un pc sans souris/clavier dès le démarrage et pouvoir la modifier

## besoin
VLC
un dossier partagé  (donc un password sur le compte)
auto log in 
https://windowsreport.com/auto-login-windows-10/

netplwiz
add the checkbox
reg ADD “HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device” /v DevicePasswordLessBuildVersion /t REG_DWORD /d 0 /f

## réglage
windows+r shell:startup copier vlc.bat 

et pour le script powershell 
creer un raccourci avec 
Target: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "C:\scripts\script.ps1"

## qu'est-ce qui fait
vlc.bat lance la playlist en plein écran sans son sans le bandeau du nom de fichier
monitor-playlist.ps1 surveille le dossier où on dépose les vidéos/images et lance créate-playlist.ps1 quand il détecte un changement et relance vlc.bat
crete-playlist copy le contenu du dossier playlist dans un dossier mirror qui est la source de la playlist vlc parce que sinon on pourrait pas supprimer les fichier vu que ils sont en cours d'utilisation par vlc
et recré le fichier playlist de vlc avec les fichier présent
