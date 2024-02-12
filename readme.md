# le but 
lire une playlist VLC en plein écran sur un pc sans souris/clavier dès le démarrage et pouvoir la modifier

## besoin
- VLC
- un dossier partagé  (donc un password sur le compte)
- auto log-in ( https://windowsreport.com/auto-login-windows-10/ )  

#### auto log-in en simple:  
 - win + r => netplwiz  
 - décocher la checkbox "Users must enter a user name and password to use this computer"  
si elle est pas la => add the checkbox en executant dans powershell en admin:
```
reg ADD “HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device” /v DevicePasswordLessBuildVersion /t REG_DWORD /d 0 /f
```

## réglage
#### dossier partagé
créer un dossier partagé, lui assigner la lettre G  
cloner le repo dans le dossier partagé  

#### autostart
windows+r shell:startup 

creer un raccourci avec   
Target: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "G:\scripts\script.ps1"

## qu'est-ce ça fait
**vlc.bat** lance la playlist en plein écran sans son et sans le bandeau du nom de fichier.  

**monitor-playlist.ps1** surveille le dossier où on dépose les vidéos/images et lance create-playlist.ps1 quand il détecte un changement et relance vlc.bat.

**create-playlist.ps1** copie le contenu du dossier playlist dans un dossier mirror qui est la source de la playlist vlc, (parce que sinon on pourrait pas supprimer les fichier vu que ils sont en cours d'utilisation par vlc)
et recré le fichier playlist de vlc avec les fichier présent dans mirror
