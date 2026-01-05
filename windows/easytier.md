## EasyTier
* `EasyTier` [[easytier.cn]](https://easytier.cn/guide/download.html)  
`C:\Program Files\easytier-windows-x86_64`
* 以管理员身份运行***`PowerShell`***
    ```
    cd 'C:\Program Files\easytier-windows-x86_64'
    .\easytier-cli.exe service install -w abc
    ```
    * 启动服务
        ```
        .\easytier-cli.exe service start
    * 停止服务
        ```
        .\easytier-cli.exe service stop
    * 查看状态
        ```
        .\easytier-cli.exe service status
    * 卸载服务
        ```
        .\easytier-cli.exe service uninstall