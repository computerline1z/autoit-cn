﻿#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

$Debug_Ed = False ; 检查传递给 Edit 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $StatusBar, $hEdit, $hGUI
	Local $Wow64 = ""
	If @AutoItX64 Then $Wow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\changelog.txt"
	Local $aPartRightSide[6] = [50, 130, 210, 290, 378, -1], $aRect

	; 创建 GUI
	$hGUI = GUICreate("Edit Get RECT", 400, 300)
	$hEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	$StatusBar = _GUICtrlStatusBar_Create($hGUI, $aPartRightSide)
	_GUICtrlStatusBar_SetIcon($StatusBar, 5, 97, "shell32.dll")
	_GUICtrlStatusBar_SetText($StatusBar, "Rect")
	GUISetState()

	; 获取矩形
	$aRect = _GUICtrlEdit_GetRECT($hEdit)
	$aRect[0] += 10
	$aRect[1] += 10
	$aRect[2] -= 10
	$aRect[3] -= 10

	; 设置矩形
	_GUICtrlEdit_SetRECT($hEdit, $aRect)

	; 添加文本
	_GUICtrlEdit_AppendText($hEdit, FileRead($sFile))
	_GUICtrlEdit_LineScroll($hEdit, 0, _GUICtrlEdit_GetLineCount($hEdit) * - 1)

	; 获取矩形
	$aRect = _GUICtrlEdit_GetRECT($hEdit)
	_GUICtrlStatusBar_SetText($StatusBar, "Left: " & $aRect[0], 1)
	_GUICtrlStatusBar_SetText($StatusBar, "Topt: " & $aRect[1], 2)
	_GUICtrlStatusBar_SetText($StatusBar, "Right: " & $aRect[2], 3)
	_GUICtrlStatusBar_SetText($StatusBar, "Bottom: " & $aRect[3], 4)

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main