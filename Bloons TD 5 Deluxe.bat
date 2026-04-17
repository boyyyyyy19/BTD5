@echo off
setlocal enabledelayedexpansion

title Bloons TD 5 Deluxe - Portable Setup (No Serial - No Admin)

echo.
echo ====================================================
echo Bloons TD 5 Deluxe Portable Installer + Launcher
echo (Extracts + runs without admin rights or serial key)
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
    echo Please put this .bat file in the same folder as your BTD5 Deluxe.zip
    pause
    exit /b 1
)

:: Create folders
if not exist "%GAME_FOLDER%" mkdir "%GAME_FOLDER%"
if not exist "%TEMP_EXTRACT%" mkdir "%TEMP_EXTRACT%"

echo [1/4] Extracting the ZIP file (this may take 30-60 seconds)...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%TEMP_EXTRACT%' -Force"

if errorlevel 1 (
    echo [ERROR] Extraction failed. Make sure PowerShell is enabled.
    rd /s /q "%TEMP_EXTRACT%" 2>nul
    pause
    exit /b 1
)

echo [2/4] Installing game files to a user-writable folder (no Program Files = no admin needed)...
:: The ZIP has a double-nested BTD5Dfree folder
xcopy "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\Bloons TD 5 Deluxe\*" "%GAME_FOLDER%\" /E /I /H /Y /Q >nul 2>&1

echo [3/4] Setting up save data in AppData (no admin required)...
if exist "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\com.ninjakiwi.BloonsTD5Deluxe" (
    if not exist "%APPDATA_FOLDER%" mkdir "%APPDATA_FOLDER%"
    xcopy "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\com.ninjakiwi.BloonsTD5Deluxe\*" "%APPDATA_FOLDER%\" /E /I /H /Y /Q >nul 2>&1
)

:: Copy readme to root for convenience
if exist "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\Readme.txt" copy "%TEMP_EXTRACT%\BTD5Dfree\BTD5Dfree\Readme.txt" "%~dp0\Readme - Bloons TD 5 Deluxe.txt" >nul 2>&1

echo [4/4] Cleaning up temporary files...
rd /s /q "%TEMP_EXTRACT%" 2>nul

echo.
echo ====================================================
echo SETUP COMPLETE!
echo ====================================================
echo.
echo Game is now in: %GAME_FOLDER%
echo Saves are safely stored in your AppData (no admin rights needed)
echo This version is pre-cracked - no serial key will be asked.
echo.
echo Launching Bloons TD 5 Deluxe now...
echo (You can run BloonsTD5Deluxe.exe anytime from the game folder)
echo.

:: Launch the game directly (runs as current user = no admin prompt)
cd /d "%GAME_FOLDER%"
start "" "BloonsTD5Deluxe.exe"

echo.
echo If the game doesn't start, just double-click BloonsTD5Deluxe.exe
echo in the "Bloons TD 5 Deluxe" folder next to this .bat.
pause
exit