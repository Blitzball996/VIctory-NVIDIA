@echo off
rem One-click GTA VI on VIctory-NVIDIA (DLSS + frame generation). ASCII only.
rem   PLAY_FRAMEGEN.bat          menu
rem   PLAY_FRAMEGEN.bat 1..8     start that mode directly
rem   PLAY_FRAMEGEN.bat check    only show paths and what is ready
setlocal
set "PS1=%~dp0scripts\play-gta6-framegen.ps1"
set "PSH=powershell"
where pwsh >nul 2>nul && set "PSH=pwsh"
if not exist "%PS1%" (
  echo Not found: %PS1%
  pause
  exit /b 1
)
if /i "%~1"=="check" (
  %PSH% -NoProfile -File "%PS1%" -Check
  pause
  exit /b 0
)
set "PICK=%~1"
if not "%PICK%"=="" goto :run

echo ================================================
echo   GTA VI - VIctory-NVIDIA, DLSS + frame generation
echo   (RTX 50: frame generation 4x automatically)
echo   [inside] = resolution the game renders at
echo ================================================
echo   1. Series X 1440p + DLSS Quality + frame gen       [960p]  (best picture)
echo   2. Series X 1440p + DLSS Quality, no frame gen     [960p]
echo   3. Series S + DLSS Quality + frame gen             [720p]
echo   4. Series X 1440p + DLSS Performance + frame gen   [720p]
echo   5. EXTREME Series S, DLSS Performance              [540p]
echo   6. EXTREME Series X, DLSS Performance              [720p]
echo   7. EXTREME Series X, DLSS Ultra Performance        [480p]
echo   8. EXTREME Series S, DLSS Ultra Performance        [360p]  (lowest)
echo   EXTREME = frame gen + no cap + big pools + High priority
echo   Q. Quit
echo.
choice /c 12345678Q /n /m "Choose 1-8 or Q: "
if errorlevel 9 goto :end
if errorlevel 8 (set "PICK=8") else if errorlevel 7 (set "PICK=7") else if errorlevel 6 (set "PICK=6") else if errorlevel 5 (set "PICK=5") else if errorlevel 4 (set "PICK=4") else if errorlevel 3 (set "PICK=3") else if errorlevel 2 (set "PICK=2") else (set "PICK=1")

:run
echo.
%PSH% -NoProfile -File "%PS1%" -Mode %PICK%

:end
echo.
pause
