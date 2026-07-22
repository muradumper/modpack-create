@echo off
chcp 65001 > nul
echo =========================================
echo    AUTOMATOR PACKWIZ + GIT (LF FIX)
echo =========================================
echo.

:: 1. Pergunta a mensagem do commit
set /p msg="Mensagem do commit (ou aperte ENTER pra mensagem padrao): "
if "%msg%"=="" set msg=oi eu sou jamal e esqueci de colocar comentario

echo.
echo [1/4] Convertendo quebras de linha no disco para LF...
powershell -Command "Get-ChildItem -Recurse -File | Where-Object { $_.Extension -notmatch '\.(jar|png|zip|gz)$' } | ForEach-Object { $c = [System.IO.File]::ReadAllText($_.FullName) -replace '`n', '`n'; [System.IO.File]::WriteAllText($_.FullName, $c, (New-Object System.Text.UTF8Encoding $false)) }"

echo [2/4] Atualizando o Packwiz...
packwiz refresh

echo [3/4] Adicionando arquivos ao Git...
git add .

echo [4/4] Enviando alterações para o GitHub...
git commit -m "%msg%"
git push

echo.
echo =========================================
echo    Tudo pronto e atualizado no GitHub!
echo =========================================
pause