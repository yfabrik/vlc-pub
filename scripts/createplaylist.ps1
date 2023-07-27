$mirror="g:\mirror"
$playDir="g:\playlist"
$playlist="g:\playlist.xspf"

taskkill /im vlc.exe
#faut un mirroir sinon on peut pas del les video en cours
Write-host "remove et recrée le dossier $mirror"
#copy le content de la playlist dans miroir
if(Test-Path -Path $mirror){
	Remove-Item $mirror -recurse -Force
}
New-Item -ItemType Directory -Force -Path $mirror
Write-host copy $playDir to $mirror
Copy-Item $playDir\* $mirror -force -recurse

write-host "create playlist"

echo @"
<?xml version="1.0" encoding="UTF-8"?>
<playlist xmlns="http://xspf.org/ns/0/" xmlns:vlc="http://www.videolan.org/vlc/playlist/ns/0/" version="1">
	<title>Liste de lecture</title> 
    <trackList>
"@ > $playlist

$dir= Get-ChildItem $mirror |%{$_.FullName}
$countloop=0
foreach ($file in $dir){
echo @"
        <track>
			<location>file:///${file}</location>
			<duration>10000</duration>
			<extension application="http://www.videolan.org/vlc/playlist/0">
				<vlc:id>${countloop}</vlc:id>
			</extension>
		</track>
"@ >>$playlist
$countloop++
}
echo @"
	</trackList>
	<extension application="http://www.videolan.org/vlc/playlist/0">
"@>>$playlist
$countloop2=0
foreach($file in $dir){
"<vlc:item tid='${countloop2}'/>" >>$playlist
$countloop2++
}
echo @"
	</extension>
</playlist>
"@ >>$playlist
