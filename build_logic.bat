@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul
cd /d "%~dp0"

rem AGM_SUPRA_HOME may override the automatically detected AGM tool package.
set "SUPRA_HOME=%AGM_SUPRA_HOME%"
if defined SUPRA_HOME goto check_tools
if defined PLATFORMIO_PACKAGES_DIR if exist "%PLATFORMIO_PACKAGES_DIR%\tool-agrv_logic\bin\af.exe" set "SUPRA_HOME=%PLATFORMIO_PACKAGES_DIR%\tool-agrv_logic"
if defined SUPRA_HOME goto check_tools
if defined PLATFORMIO_CORE_DIR if exist "%PLATFORMIO_CORE_DIR%\packages\tool-agrv_logic\bin\af.exe" set "SUPRA_HOME=%PLATFORMIO_CORE_DIR%\packages\tool-agrv_logic"
if defined SUPRA_HOME goto check_tools
if exist "D:\ProgramData\agrv\AgRV_pio\packages\tool-agrv_logic\bin\af.exe" set "SUPRA_HOME=D:\ProgramData\agrv\AgRV_pio\packages\tool-agrv_logic"
if defined SUPRA_HOME goto check_tools
if exist "%USERPROFILE%\.platformio\packages\tool-agrv_logic\bin\af.exe" set "SUPRA_HOME=%USERPROFILE%\.platformio\packages\tool-agrv_logic"

:check_tools
if not defined SUPRA_HOME goto missing_tools
if not exist "%SUPRA_HOME%\python_dist\python.exe" goto missing_tools
echo AGM tools: %SUPRA_HOME%
"%SUPRA_HOME%\python_dist\python.exe" "%~dp0tools\build_logic.py" --tool-home "%SUPRA_HOME%"
set "BUILD_RESULT=%ERRORLEVEL%"
goto finish

:missing_tools
echo ERROR: AGM tool package not found.
echo Set AGM_SUPRA_HOME to the tool-agrv_logic directory, then run this file again.
set "BUILD_RESULT=1"

:finish
if not "%BUILD_RESULT%"=="0" echo LOGIC BUILD FAILED. See the error and .pio\native_logic_build logs.
if /i not "%~1"=="--no-pause" pause
exit /b %BUILD_RESULT%
