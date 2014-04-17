@echo off
echo.This script enables running powershell scripts in Unrestricted mode.
powershell.exe Set-ExecutionPolicy -ExecutionPolicy Unrestricted
powershell.exe -file .\PC_Deploy.ps1