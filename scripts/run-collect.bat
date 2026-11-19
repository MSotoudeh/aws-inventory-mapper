@echo off
rem Run from the repository root so output lands in .\aws_inventory
pushd "%~dp0.."
echo Starting AWS Inventory Collection...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0collect-aws-inventory.ps1"
popd
pause
