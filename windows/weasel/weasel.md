## 小狼毫
* 新建`RimeSync`  
`C:\RimeSync`
* `坚果云` [[www.jianguoyun.com]](https://www.jianguoyun.com/s/downloads)
* ***`PowerShell`***
    ```
    cd C:\Users\a1729\AppData\Roaming
    git clone --depth 1 https://github.com/gaboolic/rime-frost Rime
    ```
* `小狼毫` [[github.com]](https://github.com/rime/weasel/releases)
* 编辑
    * `default.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\default.yaml`
        ```
        menu:
          page_size: 9
    * `rime_frost.dict.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\rime_frost.dict.yaml`
        ```
        import_tables:
          - cn_dicts/tencent
    * `weasel.custom.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\weasel.custom.yaml`
        ```
        patch:
          "style/horizontal": true
    * `installation.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\installation.yaml`
        ```
        installation_id: "DESKTOP-U3ABQQ8"
        sync_dir: 'C:\RimeSync'
* `小狼毫`
    * `重启算法服务`
    * `重新部署`
    * `用户资料同步`
    * `如何清理已删除的用户自造词` [[www.bilibili.com]](https://www.bilibili.com/video/BV1YM4m1o7BX/?vd_source=85eeb932842b5b15ade257caaa4a9ba8)
        * ***`userdb.bat`***  
        `C:\RimeSync\DESKTOP-U3ABQQ8\userdb.bat`
        * ***`userdb.ps1`***
        `C:\RimeSync\DESKTOP-U3ABQQ8\userdb.ps1`