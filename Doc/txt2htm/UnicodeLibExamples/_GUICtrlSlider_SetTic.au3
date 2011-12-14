﻿#include <GuiConstantsEx.au3>
#include <GuiSlider.au3>

$Debug_S = False ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

_Main()

Func _Main()
	Local $iTic = Random(0, 100, 1), $hSlider

	; 创建 GUI
	GUICreate("Slider Set Tic", 400, 296)
	$hSlider = GUICtrlCreateSlider(2, 2, 396, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
	GUISetState()

	; 设置刻度
	_GUICtrlSlider_SetTic($hSlider, $iTic)

	; 获取刻度
	MsgBox(4160, "Information", "Tic: " & _GUICtrlSlider_GetTic($hSlider, $iTic))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main