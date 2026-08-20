@echo off
chcp 65001 >nul
echo ==========================================
echo Hermes Studio Mobile - 安装脚本
echo ==========================================
echo.

:: 检测 Hermes Studio 安装路径
set "HERMES_PATH=%LOCALAPPDATA%\Programs\Hermes Studio\resources\webui\dist\client"
if not exist "%HERMES_PATH%" (
    echo [错误] 未找到 Hermes Studio 安装目录
    echo 请确认 Hermes Studio 已安装
    pause
    exit /b 1
)

echo [信息] Hermes Studio 路径: %HERMES_PATH%
echo.

:: 检查是否已存在 mobile 目录
if exist "%HERMES_PATH%\mobile" (
    echo [警告] mobile 目录已存在
    choice /C YN /M "是否删除并重新安装"
    if errorlevel 2 (
        echo [取消] 安装已取消
        pause
        exit /b 0
    )
    rmdir /S /Q "%HERMES_PATH%\mobile"
    echo [信息] 已删除旧版本
)

:: 创建 junction 链接（推荐，更新安全）
echo [信息] 创建目录链接...
mklink /J "%HERMES_PATH%\mobile" "%~dp0mobile"
if %errorlevel% == 0 (
    echo [成功] 目录链接创建完成
    echo.
    echo 访问地址:
    echo   局域网: http://<电脑IP>:8748/mobile/
    echo   外网:   http://<服务器IP>:8748/mobile/
) else (
    echo [警告] 目录链接创建失败，尝试直接复制...
    xcopy /E /I /Y "%~dp0mobile" "%HERMES_PATH%\mobile"
    if %errorlevel% == 0 (
        echo [成功] 文件复制完成
        echo [注意] 桌面版更新后需要重新运行此脚本
    ) else (
        echo [错误] 安装失败
        pause
        exit /b 1
    )
)

echo.
echo ==========================================
echo 安装完成！请用手机浏览器访问上述地址
echo ==========================================
pause
