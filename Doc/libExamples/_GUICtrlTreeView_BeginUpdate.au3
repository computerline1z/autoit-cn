﻿#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiTreeView.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

$Debug_TV = False ; Check ClassName being passed to functions, set to True and use a handle to another control to see it work

_Main()

Func _Main()

	Local $hItem, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)
	
	GUICreate("TreeView Begin Update", 400, 300)

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)
	For $x = 1 To 100
		$hItem = _GUICtrlTreeView_Add($hTreeView, 0, StringFormat("[%02d] New Item", $x))
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main