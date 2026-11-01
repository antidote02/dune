$rimesync=get-location
$rime='$env:appdata\rime'
$weasel='c:\program files\rime\weasel-0.17.4'
'build','rime_frost.userdb'|?{test-path $_}|%{try{ri $_ -r -fo -ea stop}catch{& "$r\weaselserver.exe" /q}}
cd $rimesync
cp rime_frost.userdb.txt sync\rime_frost.userdb.txt.$(date -f yyyyMMddHHmmss)