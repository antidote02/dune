## 无畏契约
* `特战英豪` [[playvalorant.com]](https://playvalorant.com/zh-tw/download/)  
    * `RiotLocalMachine.ini`  
    `C:\Users\a1729\AppData\Local\VALORANT\Saved\Config\WindowsClient\RiotLocalMachine.ini`
        ```
        LastKnownUser=02b7512c-d600-541e-b95b-93f1ed746685
    * 编辑`GameUserSettings.ini`  
    `C:\Users\a1729\AppData\Local\VALORANT\Saved\Config\02b7512c-d600-541e-b95b-93f1ed746685-ap\WindowsClient\GameUserSettings.ini`
        ```
        [/Script/ShooterGame.ShooterGameUserSettings]

        bShouldLetterbox=False
        bLastConfirmedShouldLetterbox=False

        ResolutionSizeX=1440
        ResolutionSizeY=1080
        LastUserConfirmedResolutionSizeX=1440
        LastUserConfirmedResolutionSizeY=1080
        WindowPosX=0
        WindowPosY=0
        LastConfirmedFullscreenMode=2
        PreferredFullscreenMode=2

        FullscreenMode=2

        [ScalabilityGroups]
        sg.ViewDistanceQuality=0
        sg.AntiAliasingQuality=3
        sg.ShadowQuality=0
        sg.GlobalIlluminationQuality=0
        sg.ReflectionQuality=0
        sg.PostProcessQuality=0
        sg.TextureQuality=0
        sg.EffectsQuality=0
        sg.FoliageQuality=0
        sg.ShadingQuality=0
    * `PowerShell`
        ```
        sp 'hklm:\software\microsoft\windows nt\currentversion\image file execution options' devoverrideenable 0
        
        sp 'hklm:\software\microsoft\windows nt\currentversion\image file execution options' devoverrideenable 1
* `无畏契约` [[val.qq.com]](https://val.qq.com/main.html)