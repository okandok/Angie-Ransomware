@ECHO OFF

REM #### VARS SETUP

SET "WINSDKKITVERSION=10"
SET "WINSDKVERSION=10.0.17763.0"

IF "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	SET "WINSDKPATH=%ProgramFiles(x86)%\Windows Kits\%WINSDKKITVERSION%"
) ELSE (
	SET "WINSDKPATH=%ProgramFiles%\Windows Kits\%WINSDKKITVERSION%"
)

IF "%VS2019INSTALLDIR%" NEQ "" (
	SET "VCINSTALLDIR=%VS2019INSTALLDIR%"
) ELSE (
	SET "VCINSTALLDIR=%VS2017INSTALLDIR%"
)

FOR /F "delims=" %%A IN ('type "%VCINSTALLDIR%\VC\Auxiliary\Build\Microsoft.VCToolsVersion.default.txt"') DO SET "VCTOOLSVERSION=%%A"
SET "VCTOOLSPATH=%VCINSTALLDIR%\VC\Tools\MSVC\%VCTOOLSVERSION%"
SET "VCTOOLSBINPATH=%VCTOOLSPATH%\bin\Hostx64"

SET "PATH=%PATH%;"
SET "WINDBG=%WINSDKPATH%\Debuggers\"

REM #### COMPILER

SET "PATH=%PATH%%VCTOOLSBINPATH%\x64;"

REM make hates spaces so fucking much that isn't funny
IF "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	SET "ICPP_COMPILER_X64=%ICPP_COMPILER19%bin\intel64\icl.exe"
	SET "ICPP_COMPILER_X86=%ICPP_COMPILER19%bin\intel64_ia32\icl.exe"
	SET "ICPP_LINKER_X64=%ICPP_COMPILER19%bin\intel64\xilink.exe"
	SET "ICPP_LINKER_X86=%ICPP_COMPILER19%bin\intel64_ia32\xilink.exe"
) ELSE (
	SET "ICPP_COMPILER_X64=%ICPP_COMPILER19%bin\ia32_intel64\icl.exe"
	SET "ICPP_COMPILER_X86=%ICPP_COMPILER19%bin\ia32\icl.exe"
	SET "ICPP_LINKER_X64=%ICPP_COMPILER19%bin\ia32_intel64\xilink.exe"
	SET "ICPP_LINKER_X86=%ICPP_COMPILER19%bin\ia32\xilink.exe"
)

SET "PATH=%PATH%%WINSDKPATH%\bin\%WINSDKVERSION%\x64;"

REM #### INCLUDE AND LIBS

SET "PATH=%PATH%%WINSDKPATH%\bin\%WINSDKVERSION%\x64;"
SET "PATH=%PATH%%WINSDKPATH%\Tools\x64;"

SET "INCLUDE=%INCLUDE%%WINSDKPATH%\Include\%WINSDKVERSION%\ucrt;"
SET "INCLUDE=%INCLUDE%%WINSDKPATH%\Include\%WINSDKVERSION%\shared;"
SET "INCLUDE=%INCLUDE%%WINSDKPATH%\Include\%WINSDKVERSION%\um;"
SET "INCLUDE=%INCLUDE%%WINSDKPATH%\Include\%WINSDKVERSION%\km;"
SET "INCLUDE=%INCLUDE%%VCTOOLSPATH%\include;"
SET "LIB_ICPP_X64=%ICPP_COMPILER19%compiler\lib\intel64_win"
SET "LIB_ICPP_X86=%ICPP_COMPILER19%compiler\lib\ia32_win"
SET "LIB_VCTOOLS_X64=%VCTOOLSPATH%\lib\x64"
SET "LIB_VCTOOLS_X86=%VCTOOLSPATH%\lib\x86"
SET "LIB_UNMANAGED_X64=%WINSDKPATH%\Lib\%WINSDKVERSION%\um\x64"
SET "LIB_UNMANAGED_X86=%WINSDKPATH%\Lib\%WINSDKVERSION%\um\x86"

REM #### Utils

SET "PATH=%PATH%%WINSDKPATH%\Tools\x64;"
SET "PATH=%PATH%%cd%\tools;"
SET "PATH=%PATH%%__GNU_MAKE%;"
SET "PATH=%PATH%%__NASM%;"

SET "PROJECT_PATH=%cd%"
SET "PROJECT_BIN_PATH=%PROJECT_PATH%\bin"
SET "PROJECT_LIB_PATH=%PROJECT_PATH%\libs"
SET "PROJECT_INCLUDE_PATH=%PROJECT_PATH%\source\include"

IF "%1%" NEQ "" (
	"tools\setbuild.bat" %1%
)

(
	TITLE Sphinx Client 0.1
)
