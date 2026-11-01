## 小狼毫
* 新建`RimeSync`  
`C:\RimeSync`
* `坚果云` [[www.jianguoyun.com]](https://www.jianguoyun.com/s/downloads)
* ***`PowerShell`***
    ```
    cd C:\Users\a1729\AppData\Roaming
    git clone https://github.com/gaboolic/rime-frost Rime
    ```
* `小狼毫` [[github.com]](https://github.com/rime/weasel/releases)
* `
* 编辑
    * `custom_phrase.txt`  
    `C:\Users\a1729\AppData\Roaming\Rime\custom_phrase.txt`
        ```
        a1729304580@gmail.com	ph	3
    * `default.custom.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\default.custom.yaml`
        ```
        patch:
          menu/page_size: 5
    * `installation.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\installation.yaml`
        ```
        installation_id: "DESKTOP-S4GBLV2"
        sync_dir: 'D:\RimeSync'
    * `rime_frost.dict.yaml`  
    `C:\Users\a1729\AppData\Roaming\Rime\rime_frost.dict.yaml`
        ```
        import_tables:
          - cn_dicts/tencent
    * `weasel.yaml` [[hero20072.github.io]](https://hero20072.github.io/edit4weasel/)  
    `C:\Program Files\Rime\weasel-0.17.4\data\weasel.yaml`  
     `weasel.yaml`重命名`weasel.yaml.bak`
    * `万象语法模型` [[github.com]](https://github.com/amzxyz/RIME-LMDG/releases/tag/LTS)  
    `C:\Users\a1729\AppData\Roaming\Rime\wanxiang-lts-zh-hans.gram`
    * 新建`rime_frost.custom.yaml`
        ```
        patch:
          grammar:
            language: wanxiang-lts-zh-hans
            collocation_max_length: 6
            collocation_min_length: 3
            collocation_penalty: -14
            non_collocation_penalty: -6
            weak_collocation_penalty: -100
            rear_penalty: -20
          translator/contextual_suggestions: true
          translator/max_homophones: 8
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