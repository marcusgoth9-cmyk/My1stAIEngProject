@echo off
cd /d "%~dp0"

set "CMAKE=cmake"
where cmake >nul 2>&1
if errorlevel 1 set "CMAKE=%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
if not "%CMAKE%"=="cmake" if not exist "%CMAKE%" (
    echo CMake wurde nicht gefunden. Bitte installiere CMake oder fuege es zu PATH hinzu.
    goto error
)

"%CMAKE%" -S . -B build
if errorlevel 1 goto error

"%CMAKE%" --build build --config Debug
if errorlevel 1 goto error

.\build\Debug\classifier.exe
if errorlevel 1 goto error

echo.
pause
exit /b 0

:error
echo.
echo Ein Fehler ist aufgetreten. Siehe Ausgabe oben.
pause
exit /b 1
