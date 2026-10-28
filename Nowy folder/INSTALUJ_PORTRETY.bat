@echo off
chcp 65001 >nul
where py >nul 2>nul
if %errorlevel% EQU 0 (
 py -3 "%~dp0INSTALUJ_PORTRETY.py" %*
) else (
 python "%~dp0INSTALUJ_PORTRETY.py" %*
)
echo.
pause
