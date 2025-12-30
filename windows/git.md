## Git
* `Git` [[git-scm.com]](https://git-scm.com/install/windows)
* ***`PowerShell`***
    ```
    git config --global http.proxy http://127.0.0.1:7897
    git config --global https.proxy https://127.0.0.1:7897
    git config --global user.name "antidote02"
    git config --global user.email "a1729304580@gmail.com"
    ```
* Main
    ```
    git checkout --orphan temp_branch
    git add -A
    git commit -m "2025/12/30 21:43:20"
    git branch -D main
    git branch -m main
    git push -f origin main