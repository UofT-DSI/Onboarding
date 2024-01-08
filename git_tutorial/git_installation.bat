@echo off

REM Check if Git is installed and display its version
git --version 2> nul
IF %ERRORLEVEL% EQU 0 (
    echo Git is installed.
    echo Git version:
    git --version
    echo Git installation path(s):
    where git
) ELSE (
    echo Git is not installed.
    echo Please download and install Git from https://git-scm.com/download/win
)

pause
