@echo off
setlocal enabledelayedexpansion

REM 获取脚本所在的目录和备份文件路径
set "scriptPath=%~dp0"
set "backupFile=%scriptPath%GPU备份勿删.txt"

REM 检查是否有管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 需要管理员权限才能运行此脚本
    echo 请右键点击脚本，选择"以管理员身份运行"
    pause
    exit /b 1
)

:MAIN_MENU
cls
echo ==============================================
echo            NVIDIA显卡型号修改工具
echo ==============================================
echo 请选择要执行的操作：
echo   1. 修改显卡型号
echo   2. 恢复默认显卡型号
echo   3. 一键修改为1050ti
echo   4. 退出
echo ==============================================
echo 基于B站UP凯文不是死宅做出的整合（二创：疾风扳机）
echo ==============================================

set /p "choice=请输入选择 (1-4): "
if "%choice%"=="1" goto MODIFY_GPU
if "%choice%"=="2" goto RESTORE_GPU
if "%choice%"=="3" goto MODIFY_1050TI
if "%choice%"=="4" exit /b 0

echo 输入无效，请重新输入
timeout /t 2 >nul
goto MAIN_MENU

:MODIFY_GPU
cls
echo 开始获取NVIDIA显卡相关的注册信息...
echo ==============================================
echo 基于B站UP凯文不是死宅做出的整合（二创：疾风扳机）
echo ==============================================

REM 检查备份文件是否存在
set "writeBackup=1"
if exist "%backupFile%" (
    echo 已存在备份文件，将不重复写入
    set "writeBackup=0"
)

echo 正在搜索NVIDIA显卡，请稍候...
echo.

REM 使用简单的方法查找NVIDIA显卡
set "count=0"
set "tempFile=%temp%\gpu_list.txt"

REM 先获取所有包含VEN_10DE的路径
reg query "HKLM\SYSTEM\ControlSet001\Enum\PCI" /s | findstr "VEN_10DE" > "%tempFile%"

for /f "usebackq delims=" %%a in ("%tempFile%") do (
    set "currentPath=%%a"
    call :CheckNvidiaPath "!currentPath!"
)

del "%tempFile%" >nul 2>&1

if !count! equ 0 (
    echo 未找到NVIDIA显卡设备
    pause
    goto MAIN_MENU
)

echo ==============================================
echo 共找到 !count! 个NVIDIA显卡设备
echo ==============================================
echo.

REM 显示显卡列表
for /l %%i in (1,1,!count!) do (
    echo [%%i] !gpu_desc[%%i]!
)

echo.
set /p "choice=请选择要修改的显卡序号 (1-!count!): "

REM 验证输入
set /a "choice=!choice!" 2>nul
if !errorlevel! neq 0 goto INPUT_ERROR
if !choice! lss 1 goto INPUT_ERROR
if !choice! gtr !count! goto INPUT_ERROR

REM 获取选择的路径
set "selectedPath=!gpu_path[%choice%]!"
set "currentDesc=!gpu_desc[%choice%]!"

echo.
echo 当前显卡: !currentDesc!
echo.
set /p "newName=请输入新的显卡名称: "

if "!newName!"=="" (
    echo 名称不能为空
    pause
    goto MAIN_MENU
)

echo.
echo ==============================================
echo 确认修改：
echo 路径: !selectedPath!
echo 新名称: !newName!
echo ==============================================
set /p "confirm=确认修改？(y/n): "
if /i not "!confirm!"=="y" goto MAIN_MENU

echo.
echo 正在修改...
reg add "!selectedPath!" /v "DeviceDesc" /t REG_SZ /d "!newName!" /f >nul
if !errorlevel! equ 0 (
    echo 修改成功！需要重启电脑生效
) else (
    echo 修改失败，请检查权限
)

pause
goto MAIN_MENU

:CheckNvidiaPath
set "testPath=%~1"
reg query "!testPath!" /v "DeviceDesc" >nul 2>&1
if !errorlevel! neq 0 exit /b

for /f "tokens=2,*" %%A in ('reg query "!testPath!" /v "DeviceDesc" 2^>nul ^| findstr "REG_SZ"') do (
    set "desc=%%B"
    if not "!desc!"=="" (
        echo !desc! | findstr /i "nvidia" >nul
        if !errorlevel! equ 0 (
            set /a count+=1
            set "gpu_path[!count!]=!testPath!"
            set "gpu_desc[!count!]=!desc!"
            
            if !writeBackup! equ 1 (
                echo !testPath! >> "%backupFile%"
                echo !desc! >> "%backupFile%"
                echo --- >> "%backupFile%"
            )
            
            echo 找到: !desc!
        )
    )
)
exit /b

:MODIFY_1050TI
cls
echo ==============================================
echo           一键修改为1050ti
echo ==============================================

echo 正在搜索NVIDIA显卡，请稍候...
echo.

set "count=0"
set "tempFile=%temp%\gpu_list.txt"

reg query "HKLM\SYSTEM\ControlSet001\Enum\PCI" /s | findstr "VEN_10DE" > "%tempFile%"

for /f "usebackq delims=" %%a in ("%tempFile%") do (
    set "currentPath=%%a"
    call :CheckNvidiaPath2 "!currentPath!"
)

del "%tempFile%" >nul 2>&1

if !count! equ 0 (
    echo 未找到NVIDIA显卡设备
    pause
    goto MAIN_MENU
)

echo ==============================================
echo 共找到 !count! 个NVIDIA显卡设备
echo ==============================================
echo.

for /l %%i in (1,1,!count!) do (
    echo [%%i] !gpu_desc[%%i]!
)

echo.
set /p "choice=请选择要修改的显卡序号 (1-!count!): "

set /a "choice=!choice!" 2>nul
if !errorlevel! neq 0 goto INPUT_ERROR
if !choice! lss 1 goto INPUT_ERROR
if !choice! gtr !count! goto INPUT_ERROR

set "selectedPath=!gpu_path[%choice%]!"
set "currentDesc=!gpu_desc[%choice%]!"
set "newName=NVIDIA GeForce GTX 1050 Ti"

echo.
echo 当前显卡: !currentDesc!
echo 将修改为: !newName!
echo.
set /p "confirm=确认修改为1050ti？(y/n): "
if /i not "!confirm!"=="y" goto MAIN_MENU

echo.
echo 正在修改...
reg add "!selectedPath!" /v "DeviceDesc" /t REG_SZ /d "!newName!" /f >nul
if !errorlevel! equ 0 (
    echo 修改成功！需要重启电脑生效
) else (
    echo 修改失败，请检查权限
)

pause
goto MAIN_MENU

:CheckNvidiaPath2
set "testPath=%~1"
reg query "!testPath!" /v "DeviceDesc" >nul 2>&1
if !errorlevel! neq 0 exit /b

for /f "tokens=2,*" %%A in ('reg query "!testPath!" /v "DeviceDesc" 2^>nul ^| findstr "REG_SZ"') do (
    set "desc=%%B"
    if not "!desc!"=="" (
        echo !desc! | findstr /i "nvidia" >nul
        if !errorlevel! equ 0 (
            set /a count+=1
            set "gpu_path[!count!]=!testPath!"
            set "gpu_desc[!count!]=!desc!"
            echo 找到: !desc!
        )
    )
)
exit /b

:RESTORE_GPU
cls
echo ==========================================
echo           恢复默认显卡型号
echo ==========================================

if not exist "%backupFile%" (
    echo 错误：未找到备份文件 "GPU备份勿删.txt"
    echo.
    echo 请先使用"修改显卡型号"功能创建备份
    pause
    goto MAIN_MENU
)

echo 正在读取备份文件...
set /a lineNum=0
set "regPath="
set "deviceName="

for /f "usebackq delims=" %%a in ("%backupFile%") do (
    set /a lineNum+=1
    if !lineNum! equ 1 set "regPath=%%a"
    if !lineNum! equ 2 set "deviceName=%%a"
    if !lineNum! equ 3 goto BREAK_READ
)
:BREAK_READ

if "!regPath!"=="" (
    echo 备份文件格式错误
    pause
    goto MAIN_MENU
)

if "!deviceName!"=="" (
    echo 备份文件格式错误
    pause
    goto MAIN_MENU
)

echo.
echo ==========================================
echo 恢复信息：
echo 路径: !regPath!
echo 原名称: !deviceName!
echo ==========================================
echo.
set /p "confirm=确认恢复？(y/n): "
if /i not "!confirm!"=="y" goto MAIN_MENU

echo.
echo 正在恢复...
reg add "!regPath!" /v "DeviceDesc" /t REG_SZ /d "!deviceName!" /f >nul
if !errorlevel! equ 0 (
    echo 恢复成功！需要重启电脑生效
) else (
    echo 恢复失败，请检查权限
)

pause
goto MAIN_MENU

:INPUT_ERROR
echo 输入无效，请重新输入
pause
goto MAIN_MENU

endlocal