﻿#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为真并使用另一控件的句柄可以看出它是否有效

Global $hListView

_Main()

Func _Main()
	Local $hImage, $iTime

	GUICreate("ListView Cancel Edit", 392, 322)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268, BitOR($LVS_EDITLABELS, $LVS_REPORT))
	GUISetState()

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; 加载图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($hListView), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($hListView), 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($hListView), 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)

	; 添加列
	_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)
	_GUICtrlListView_InsertColumn($hListView, 1, "Column 2", 100)
	_GUICtrlListView_InsertColumn($hListView, 2, "Column 3", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Row 1: Col 1", 0)
	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 2", 1)
	_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 3", 2)
	_GUICtrlListView_AddItem($hListView, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($hListView, 1, "Row 2: Col 2", 1)
	_GUICtrlListView_AddItem($hListView, "Row 3: Col 1", 2)

	; 编辑第一项标签超时了
	_GUICtrlListView_EditLabel($hListView, 0)
	$iTime = TimerInit()

	; 循环直到用户退出
	Do
		If _GUICtrlListView_GetEditControl($hListView) <> 0 Then
			If TimerDiff($iTime) > 3000 Then _GUICtrlListView_CancelEditLabel($hListView)
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
	$hWndListView = $hListView
	If Not IsHWnd($hListView) Then $hWndListView = GUICtrlGetHandle($hListView)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				Case $LVN_COLUMNCLICK ; 点击了一列
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					_DebugPrint("$LVN_COLUMNCLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; 没有返回值
				Case $LVN_ITEMCHANGING ; 正在改变一项
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					_DebugPrint("$LVN_ITEMCHANGING" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					Return True ; 阻止改变
					;Return False ; 允许改变
				Case $LVN_KEYDOWN ; 按下了一个按键
					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
					_DebugPrint("$LVN_KEYDOWN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->VKey:" & @TAB & DllStructGetData($tInfo, "VKey") & @LF & _
							"-->Flags:" & @TAB & DllStructGetData($tInfo, "Flags"))
					; 没有返回值
				Case $NM_CLICK ; 当用户用鼠标左键点击了一项时由列表视图控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_CLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; 没有返回值
				Case $NM_DBLCLK ; 当用户用鼠标左键双击了一项时由列表视图控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_DBLCLK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; 没有返回值
				Case $NM_KILLFOCUS ; 控件失去了输入焦点
					_DebugPrint("$NM_KILLFOCUS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					; 没有返回值
				Case $NM_RCLICK ; 当用户用鼠标右键点击了一项时由列表视图发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_RCLICK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;Return 1 ; 不允许进行默认处理
					Return 0 ; 允许进行默认处理
				Case $NM_RDBLCLK ; 当用户用鼠标右键双击了一项时由列表视图控件发送
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_DebugPrint("$NM_RDBLCLK" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode & @LF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @LF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @LF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @LF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @LF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @LF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @LF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @LF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @LF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; 没有返回值
				Case $NM_RETURN ; 控件有输入焦点且用户按下了回车键
					_DebugPrint("$NM_RETURN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					; 没有返回值
				Case $NM_SETFOCUS ; 控件接收到输入焦点
					_DebugPrint("$NM_SETFOCUS" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @LF & _
							"-->Code:" & @TAB & $iCode)
					; 没有返回值
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_text, $line = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $line) & "):" & @TAB & $s_text & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_DebugPrint