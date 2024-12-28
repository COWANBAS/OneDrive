@Echo File by Kauan Fonseca

taskkill /f /im OneDrive.exe
@Echo Off

:: Detectando se o sistema e 64 ou 32 bits ::
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT GOTO 32BIT
if %OS%==64BIT GOTO 64BIT

:: Desinstalando Aplicativo do OneDrive ::
:32BIT
   echo.
   echo Esse e o arquivo 32 bits do OneDrive
   echo Removendo aplicativo do OneDrive
   
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
GOTO CLEAN
:64BIT
   echo.
   echo Esse e o arquivo 64 bits do OneDrive
   echo Removendo aplicativo do OneDrive
   
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
GOTO CLEAN

:: Limpando todos as pastas relacionadas ao OneDrive ::
:CLEAN
   echo.
   echo Removendo pastas do OneDrive
   rd "%UserProfile%\OneDrive" /s /q
   rd "%LocalAppData%\Microsoft\OneDrive" /s /q
   rd "%ProgramData%\Microsoft OneDrive" /s /q
   rd "C:\OneDriveTemp" /s /q
   del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /s /f /q

 :: Tirando o atalho do one drive do menu explorer ::
echo Tirando atalho do OneDrive do menu Explorer
   REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > nul 2>&1
   REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > nul 2>&1
   REG ADD "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /d "0" /t REG_DWORD /f
echo Concluido! OneDrive foi removido de seu computador com sucesso!
pause