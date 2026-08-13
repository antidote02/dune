$rimesync = get-location
$rime = "$env:appdata\rime"
$weasel = "c:\program files\rime\weasel-0.17.4"
cd $rime
if (test-path build) {
    try {
        rm -recurse -force build -erroraction stop
    } catch {
        & "$weasel\weaselserver.exe" /q
    }
}
if (test-path rime_frost.userdb) {
    try {
        rm -recurse -force rime_frost.userdb -erroraction stop
    } catch {
        & "$weasel\weaselserver.exe" /q
    }
}
cd $rimesync
cp rime_frost.userdb.txt rime_frost.userdb.txt.backup
git-bash -c "sed -i '/c=-[0-9]*/d;s/c=[0-9][0-9]*/c=1/g;s/d=[0-9.]*/d=1/g;s/t=[0-9]*//g' rime_frost.userdb.txt"
$time = get-date -format "yyyyMMddHHmmss"
cp rime_frost.userdb.txt .\sync\rime_frost.userdb.txt.$time
pause