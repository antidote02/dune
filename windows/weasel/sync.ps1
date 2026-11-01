echo "& 'c:\program files\rime\weasel-0.17.4\weaseldeployer' /sync"
& 'c:\program files\rime\weasel-0.17.4\weaseldeployer' /sync
pause
echo @'
git-bash -c "sed -E -i '/c=-/d;s/^#@\/tick\t[0-9]+/#@\/tick\t1/;s/([cdt])=[0-9.]+/\1=1/g' rime_frost.userdb.txt"
'@
git-bash -c "sed -E -i '/c=-/d;s/^#@\/tick\t[0-9]+/#@\/tick\t1/;s/([cdt])=[0-9.]+/\1=1/g' rime_frost.userdb.txt"
pause
echo 'winmergeu rime_frost.userdb.winmerge'
winmergeu rime_frost.userdb.winmerge
pause
echo "& 'c:\program files\rime\weasel-0.17.4\weaseldeployer' /deploy"
& 'c:\program files\rime\weasel-0.17.4\weaseldeployer' /deploy
pause
echo 'gci sync\*|? lastwritetime -lt(date).adddays(-7)|ri'
gci sync\*|? lastwritetime -lt(date).adddays(-7)|ri
echo 'cp rime_frost.userdb.txt sync\rime_frost.userdb.txt'
cp rime_frost.userdb.txt sync\rime_frost.userdb.txt
echo 'cp rime_frost.userdb.txt sync\rime_frost.userdb.txt.$(date -f yyyyMMddHHmmss)'
cp rime_frost.userdb.txt sync\rime_frost.userdb.txt.$(date -f yyyyMMddHHmmss)