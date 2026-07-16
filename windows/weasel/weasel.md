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
    * `default.custom.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\default.custom.yaml`
        ```
        patch:
          menu:
            page_size: 9
          ascii_composer:
            switch_key:
              Shift_L: commit_code
              Shift_R: commit_code
    * `installation.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\installation.yaml`
        ```
        installation_id: "DESKTOP-U3ABQQ8"
        sync_dir: 'C:\RimeSync'
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
          "style/font_face": "Cascadia Code"
          "style/font_point": 13
          "style/label_font_face": "Cascadia Code"
          "style/label_font_point": 12
* 后续更新
    ```
    cd "$env:APPDATA\Rime"
    git fetch origin
    git reset --hard origin/master
* `小狼毫`
    * `重启算法服务`
    * `重新部署`
    * `用户资料同步`
    * `gpedit.msc` / `用户配置` / `管理模板` / `Windows 组件` / `Windows PowerShell` / `启用脚本执行`
    * `如何清理已删除的用户自造词` [[www.bilibili.com]](https://www.bilibili.com/video/BV1YM4m1o7BX/?vd_source=85eeb932842b5b15ade257caaa4a9ba8)
        * ***`userdb.bat`***  
        `C:\RimeSync\DESKTOP-U3ABQQ8\userdb.bat`
        * ***`userdb.ps1`***
        `C:\RimeSync\DESKTOP-U3ABQQ8\userdb.ps1`