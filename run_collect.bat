@echo off
echo Starting AWS Inventory Collection...
powershell.exe -ExecutionPolicy Bypass -File .\Collect-AwsInventory.ps1
pause
