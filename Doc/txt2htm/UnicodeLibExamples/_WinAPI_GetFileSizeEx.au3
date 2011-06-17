﻿#include <WinAPI.au3>

Global $sFile, $hFile, $sText, $nBytes, $tBuffer, $size

; 1) 创建文件并向其中写入数据
$sFile = @ScriptDir & '\test.txt'
$sText = 'abcdefghijklmnopqrstuvwxyz'
$tBuffer = DllStructCreate("byte[" & StringLen($sText) & "]")
DllStructSetData($tBuffer, 1, $sText)
$hFile = _WinAPI_CreateFile($sFile, 1)
$size = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), StringLen($sText), $nBytes)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('1):' & $size & ' ' & FileRead($sFile) & @CRLF)

; 2) 从位置 3 中读取 6 字节
$tBuffer = DllStructCreate("byte[6]")
$hFile = _WinAPI_CreateFile($sFile, 2, 2)
$size = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_ReadFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$sText = BinaryToString(DllStructGetData($tBuffer, 1))
ConsoleWrite('2):' & $size & ' ' & $sText & @CRLF)

; 3) 写入之前从位置 3 读取的 6 字节到相同位置, 但使用大写形式
DllStructSetData($tBuffer, 1, StringUpper($sText))
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
$size = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$tBuffer = 0
ConsoleWrite('3):' & $size & ' ' & FileRead($sFile) & @CRLF)

; 4) 截取文件大小到 12 字节
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 12)
_WinAPI_SetEndOfFile($hFile)
$size = _WinAPI_GetFileSizeEx($hFile)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('4):' & $size & ' ' & FileRead($sFile) & @CRLF)

FileDelete($sFile)
