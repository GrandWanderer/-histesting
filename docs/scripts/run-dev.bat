@echo off
setlocal

rem Start a simple local server for the static site from the repository root.

if "%PORT%"=="" set PORT=8000

set SCRIPT_DIR=%~dp0
for %%I in ("%SCRIPT_DIR%\..\..") do set REPO_ROOT=%%~fI

cd /d "%REPO_ROOT%"

echo Serving static site from: %REPO_ROOT%
echo Local URL: http://localhost:%PORT%
echo Stop the server with Ctrl+C

where py >nul 2>nul
if %errorlevel%==0 (
    py -3 -m http.server %PORT%
    goto :eof
)

where python >nul 2>nul
if %errorlevel%==0 (
    python -m http.server %PORT%
    goto :eof
)

where http-server >nul 2>nul
if %errorlevel%==0 (
    http-server "%REPO_ROOT%" -p %PORT%
    goto :eof
)

echo Error: Python 3 or Node.js http-server is required for local preview.
echo Install Python 3, or install Node.js and then run: npm install -g http-server
exit /b 1
