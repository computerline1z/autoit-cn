﻿#RequireAdmin

#Include <Array.au3>
#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

Global $hToken, $aList = 0

; 为获取对其他进程的完全访问权限而启用 "SeDebugPrivilege" 特权
$hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, 1)

; 为系统上所有进程获取命令行参数
If Not (@error Or @extended) Then
	$aList = ProcessList()
	For $i = 1 To $aList[0][0]
		$aList[$i][1] = _WinAPI_GetProcessCommandLine($aList[$i][1])
	Next
EndIf

; 默认情况下启用 SeDebugPrivilege 特权
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, 2)
_WinAPI_CloseHandle($hToken)

If IsArray($aList) Then
	_ArrayDisplay($aList, '_WinAPI_GetProcessCommandLine')
EndIf
