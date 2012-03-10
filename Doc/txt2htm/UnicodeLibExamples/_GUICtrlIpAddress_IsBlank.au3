﻿#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>

$Debug_IP = False ; 检查传递给 IPAddress 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $iMemo

_Main()

Func _Main()
	Local $hgui, $hIPAddress

	$hgui = GUICreate("IP Address Control IsBlank Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hgui, 2, 4)
	$iMemo = GUICtrlCreateEdit("", 2, 28, 396, 270, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; 看 IP 地址是否为空
	MemoWrite("Blank: " & _GUICtrlIpAddress_IsBlank($hIPAddress))

	Sleep(1000)

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	; 看 IP 地址是否为空
	MemoWrite("Blank: " & _GUICtrlIpAddress_IsBlank($hIPAddress))

	; 等待用户关闭 GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
