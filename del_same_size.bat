@echo off

set "path=c:\backup2\sites\"  REM Change this to your desired folder path
set "vbscript=%temp%\deledup.vbs"
set "dups=0"

copy /Y nul "%vbscript%" >nul

>>"%vbscript%" echo Option Explicit
>>"%vbscript%" echo Dim fso, dict, folder, file, size
>>"%vbscript%" echo Dim path, dups
>>"%vbscript%" echo path = "%path%"
>>"%vbscript%" echo dups = 0
>>"%vbscript%" echo Set fso = CreateObject("Scripting.FileSystemObject")
>>"%vbscript%" echo Set dict = CreateObject("Scripting.Dictionary")
>>"%vbscript%" echo Set folder = fso.GetFolder(path)
>>"%vbscript%" echo For Each file in folder.Files
>>"%vbscript%" echo     size = file.Size
>>"%vbscript%" echo     If dict.Exists(size) Then
>>"%vbscript%" echo         file.Delete True
>>"%vbscript%" echo         WScript.Echo "Deleting " & file.Path & " with size " & size
>>"%vbscript%" echo         dups = dups + 1
>>"%vbscript%" echo     Else
>>"%vbscript%" echo         dict.Add size, 1
>>"%vbscript%" echo     End If
>>"%vbscript%" echo Next
>>"%vbscript%" echo WScript.Echo dups & " duplicate(s) based on size has been deleted."

echo Deleting duplicate files based on size...
"c:\windows\system32\cscript.exe" //nologo "%vbscript%"
del "%vbscript%" >nul

pause