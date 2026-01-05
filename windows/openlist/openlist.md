## OpenList
* `OpenList` [[github.com]](https://github.com/OpenListTeam/OpenList/releases)  
`C:\Program Files\openlist-windows-amd64`
* `环境变量`
* ***`启动`***
* ***`停止`***
* ***`PowerShell`***
    ```
    cd 'C:\Program Files\openlist-windows-amd64'
    openlist admin # 显示管理员用户的信息及管理员用户密码相关操作
    openlist kill # 强制通过守护进程 / 进程 ID 文件终止 OpenList 服务器进程
    openlist restart # 通过守护进程 / 进程 ID 文件重启 OpenList 服务器
    openlist server # 启动指定地址的服务器
    openlist start # 静默启动 OpenList 服务器，使用 `--force-bin-dir`
    openlist stop # 与 kill 命令相同
    openlist storage # 管理存储
    openlist version # 显示当前 OpenList 版本
    openlist admin
    openlist admin random
    openlist admin set NEW_PASSWORD