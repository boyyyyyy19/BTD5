@echo off
setlocal enabledelayedexpansion

title Bloons TD 5 Deluxe - Portable Setup (No Serial - No Admin)

echo.
echo ====================================================
echo     Bloons TD 5 Deluxe - Portable Installer
echo     Clean Setup ^| No Admin ^| No Serial Key
echo ====================================================
echo.

:: === CONFIG ===
set "ZIPFILE=%~dp0BTD5 Deluxe.zip"
set "GAME_FOLDER=%~dp0Bloons TD 5 Deluxe"
set "APPDATA_FOLDER=%APPDATA%\com.ninjakiwi.BloonsTD5Deluxe"
set "TEMP_EXTRACT=%~dp0TEMP_BTD5_EXTRACT"

:: Check if ZIP exists
if not exist "%ZIPFILE%" (
    echo [ERROR] BTD5 Deluxe.zip was not found next to this .bat file!
    echo.
    echo Please place this .bat file in the same folder as your BTD5 Deluxe.zip
    pause
    exit /b 1
)

echo [1/4] Preparing folders...
if exist "%GAME_FOLDER%" rd /s /q "%GAME_FOLDER%" 2>nul
if exist "%TEMP_EXTRACT%" rd /s /q "%TEMP_EXTRACT%" 2>nul
if exist "%APPDATA_FOLDER%" rd /s /q "%APPDATA_FOLDER%" 2>nul

mkdir "%GAME_FOLDER%" 2>nul
mkdir "%TEMP_EXTRACT%" 2>nul

echo [2/4] Extracting game files (this may take 30-60 seconds)...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%TEMP_EXTRACT%' -Force"

if errorlevel 1 (
    echo [ERROR] Extraction failed. Make sure PowerShell is installed and enabled.
    rd /s /q "%TEMP_EXTRACT%" 2>nul
    pause
    exit /b 1
)

echo [3/4] Installing clean game files...
:: Handling the common double-nested structure
xcopy "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\Bloons TD 5 Deluxe\*" "%GAME_FOLDER%\" /E /I /H /Y /Q >nul 2>&1

:: Copy save/profile data (clean install - old profiles removed above)
if exist "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\com.ninjakiwi.BloonsTD5Deluxe" (
    mkdir "%APPDATA_FOLDER%" 2>nul
    xcopy "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\com.ninjakiwi.BloonsTD5Deluxe\*" "%APPDATA_FOLDER%\" /E /I /H /Y /Q >nul 2>&1
)

:: Copy Readme if it exists
if exist "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\Readme.txt" (
    copy "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\Readme.txt" "%~dp0\Readme - Bloons TD 5 Deluxe.txt" >nul 2>&1
)

echo [4/4] Cleaning up temporary files...
rd /s /q "%TEMP_EXTRACT%" 2>nul

echo.
echo ====================================================
echo                  SETUP COMPLETE!
echo ====================================================
echo.
echo Game folder:   %GAME_FOLDER%
echo Save data:     %APPDATA_FOLDER%
echo.
echo All old profiles and save data have been cleared for a clean start.
echo This version is pre-cracked - no serial key required.
echo.

echo Launching Bloons TD 5 Deluxe...
cd /d "%GAME_FOLDER%"
start "" "BloonsTD5Deluxe.exe"

echo.
echo If the game doesn't launch automatically, run BloonsTD5Deluxe.exe
echo from the "Bloons TD 5 Deluxe" folder.
echo.
pause
exit
