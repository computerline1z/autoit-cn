﻿#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

$Debug_CB = False ; 检查传递给 ComboBox/ComboBoxEx 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $hCombo

	; 创建 GUI
	GUICreate("ComboBox Set Horizontal Extent", 400, 296)
	$hCombo = GUICtrlCreateCombo("", 2, 2, 396, 296, BitOR($CBS_SIMPLE, $CBS_DISABLENOSCROLL, $WS_HSCROLL))
	GUISetState()

	; 添加文件
	_GUICtrlComboBox_BeginUpdate($hCombo)
	_GUICtrlComboBox_AddDir($hCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($hCombo)

	; 获取水平范围
	MsgBox(4160, "Information", "Horizontal Extent: " & _GUICtrlComboBox_GetHorizontalExtent($hCombo))

	; 设置水平范围
	_GUICtrlComboBox_SetHorizontalExtent($hCombo, 500)

	; 获取水平范围
	MsgBox(4160, "Information", "Horizontal Extent: " & _GUICtrlComboBox_GetHorizontalExtent($hCombo))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main