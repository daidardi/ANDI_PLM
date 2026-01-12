@echo off
cd /d "D:\GitHub\ANDI_PLM"

git diff-index --quiet HEAD --
if errorlevel 1 (
    git add .
    git commit -m "Commit automatico prima del pull"
)

git pull origin main --rebase

git add .
git diff-index --quiet HEAD --
if errorlevel 1 (
    for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
        set day=%%a
        set month=%%b
        set year=%%c
    )
    for /f "tokens=1-2 delims=:" %%d in ("%time%") do (
        set hour=%%d
        set min=%%e
    )
    set timestamp=%year%-%month%-%day%_%hour%-%min%
    git commit -m "Upload automatico dei file - %timestamp%"
)

powershell -ExecutionPolicy Bypass -Command ^
(Get-Content 'D:\GitHub\ANDI_PLM\ANDI_PLM_Prima_Nota_INCARICHI.html') `
-replace '<head>', '<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">' `
-replace '</head>', '<style>
body { font-family: Arial, sans-serif; }
table { width: 100%; border-collapse: collapse; }
td, th { padding: 6px; font-size: 14px; white-space: nowrap; }
div { overflow-x: auto; }
</style></head>' |
Set-Content 'D:\GitHub\ANDI_PLM\ANDI_PLM_Prima_Nota_INCARICHI.html' -Encoding UTF8

git push origin main

:end