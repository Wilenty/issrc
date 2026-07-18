@echo off

rem  Inno Setup
rem  Copyright (C) 1997-2026 Jordan Russell
rem  Portions by Martijn Laan
rem  For conditions of distribution and use, see LICENSE.TXT.
rem
rem  Batch file to compile and run ISTestTool unit tests

setlocal

Files32\ISTestTool.exe Projects\Bin\Script.Test.iss
if errorlevel 1 exit /b 1
echo Testing %~1 Inno Setup done

::exit /b
pause