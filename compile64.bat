@echo off

rem  Inno Setup
rem  Copyright (C) 1997-2019 Jordan Russell
rem  Portions by Martijn Laan
rem  For conditions of distribution and use, see LICENSE.TXT.
rem
rem  Batch file to compile the help files and all projects

setlocal

if exist compilesettings.bat goto compilesettingsfound
:compilesettingserror
echo compilesettings.bat is missing or incomplete. It needs to be created
echo with the following line, adjusted for your system:
echo.
echo   set DELPHIXEROOT=C:\Program Files\Embarcadero\RAD Studio\20.0 [Path to Delphi 10.3 Rio (or later)]
goto failed2

:compilesettingsfound
set DELPHIXEROOT=
call .\compilesettings.bat
if "%DELPHIXEROOT%"=="" goto compilesettingserror

rem -------------------------------------------------------------------------

rem  Compile each project separately because it seems Delphi
rem  carries some settings (e.g. $APPTYPE) between projects
rem  if multiple projects are specified on the command line.

set DELPHIXEDISABLEDWARNINGS=-W-SYMBOL_DEPRECATED -W-SYMBOL_PLATFORM -W-UNSAFE_CAST -W-EXPLICIT_STRING_CAST -W-EXPLICIT_STRING_CAST_LOSS -W-IMPLICIT_INTEGER_CAST_LOSS -W-IMPLICIT_CONVERSION_LOSS -W-POINTER_CAST_MIGRATION -W-POINTER_CAST_NARROWER -DTRUSTALL -DPS_PANSICHAR -DPS_MINIVCL -DSUPPORTLZMAEXE

if exist "%~dp0\__Clean.bat" call "%~dp0\__Clean.bat"

cd Projects
if errorlevel 1 goto exit

echo - ISSigTool.dpr
mkdir Dcu\ISSigTool.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components\UniPs\Source" -E..\Files64 -NUDcu\ISSigTool.dpr ISSigTool.dpr
if errorlevel 1 goto failed

echo - ISPP.dpr
mkdir Dcu\ISPP.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components\UniPs\Source" -E..\Files64 -NUDcu\ISPP.dpr ISPP.dpr
if errorlevel 1 goto failed

echo - ISIDE.dpr
mkdir Dcu\ISIDE.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSSystem;System.Win;Winapi;Vcl;Vcl.Imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components\UniPs\Source" -E..\Files64 -NUDcu\ISIDE.dpr -DISIDEPROJ;VCLSTYLES;PS_NOGRAPHCONST;PS_NOINTERFACEGUIDBRACKETS ISIDE.dpr
if errorlevel 1 (
if not exist ISIDE.res cls& echo.	execute the "GetIT64.exe" or "GetIT32.exe" to get the styles from official InnoSetup
goto failed
)

echo - ISCC.dpr
mkdir Dcu\ISCC.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components;..\Components\UniPs\Source" -E..\Files64 -DPS_NOGRAPHCONST;PS_NOINTERFACEGUIDBRACKETS -NUDcu\ISCC.dpr ISCC.dpr
if errorlevel 1 goto failed

echo - ISCmplr.dpr
mkdir Dcu\ISCmplr.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components;..\Components\UniPs\Source" -E..\Files64 -DPS_NOGRAPHCONST;PS_NOINTERFACEGUIDBRACKETS -NUDcu\ISCmplr.dpr ISCmplr.dpr
if errorlevel 1 goto failed

echo - SetupLdr.dpr
mkdir Dcu\SetupLdr.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components;..\FastMM;..\SAPMM;..\XXHASH4Delphi;..\d7zip-master;../IShashes" -E..\Files64 -DSETUPLDRPROJ -NUDcu\SetupLdr.dpr SetupLdr.dpr
if errorlevel 1 goto failed

echo - Setup.dpr
mkdir Dcu\Setup.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components;..\Components\UniPs\Source" -E..\Files64 -NUDcu\Setup.dpr -DSETUPPROJ;PS_NOGRAPHCONST;PS_NOINTERFACEGUIDBRACKETS Setup.dpr
if errorlevel 1 goto failed

echo - SetupCustomStyle.dpr
mkdir Dcu\SetupCustomStyle.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components;..\Components\UniPs\Source" -E..\Files64 -NUDcu\SetupCustomStyle.dpr -DSETUPPROJ;VCLSTYLES;PS_NOGRAPHCONST;PS_NOINTERFACEGUIDBRACKETS SetupCustomStyle.dpr
if errorlevel 1 (
if not exist SetupCustomStyle.res cls& echo.	execute the "GetIT64.exe" or "GetIT32.exe" to get the styles from official InnoSetup
goto failed
)

echo - Renaming E64 files
cd ..\Files64
if errorlevel 1 goto failed
move SetupLdr.exe SetupLdr.e64
if errorlevel 1 goto failed
move Setup.exe Setup.e64
if errorlevel 1 goto failed
move SetupCustomStyle.exe SetupCustomStyle.e64
if errorlevel 1 goto failed

cd ..\Projects
if errorlevel 1 goto exit

echo - ISTestTool.dpr
mkdir Dcu\ISTestTool.dpr 2>nul
"%DELPHIXEROOT%\bin\dcc64.exe" --no-config -NSsystem;system.win;winapi;vcl;vcl.imaging -Q -B -H -W %DELPHIXEDISABLEDWARNINGS% -U"%DELPHIXEROOT%\lib\win64\release;..\Components\UniPs\Source" -E..\Files64 -NUDcu\ISTestTool.dpr -DISTESTTOOLPROJ ISTestTool.dpr
if errorlevel 1 goto failed

cd ..

echo - Copy Files64 back to Files
for %%W in ( ISCC.exe ISCmplr.dll ISIDE.exe ISPP.dll ISSigTool.exe ISTestTool.exe Setup.e64 SetupCustomStyle.e64 SetupLdr.e64 ) do if exist "Files64\%%W" copy /y "Files64\%%W" "Files\%%W"
echo - Copy Files64\*.e64 to Files32\*.e64
for %%W in ( Setup.e64 SetupCustomStyle.e64 SetupLdr.e64 ) do if exist "Files64\%%W" copy /y "Files64\%%W" "Files32\%%W"

echo Success!
cd ..
goto exit

:failed
echo *** FAILED ***
cd ..
:failed2
::exit /b 1

:exit
pause
