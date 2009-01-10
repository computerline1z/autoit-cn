#include <GuiComboBoxEx.au3>
#include <GuiConstantsEx.au3>
#include <Constants.au3>

Opt('MustDeclareVars', 1)

$Debug_CB = False ; Check ClassName being passed to ComboBox/ComboBoxEx functions, set to True and use a handle to another control to see it work

Global $iMemo

_Main()

Func _Main()
	Local $hGUI, $aItem, $Delimiter = ";", $hCombo

	Opt("GUIDataSeparatorChar", $Delimiter)

	; Create GUI
	$hGUI = GUICreate("ComboBoxEx Get List", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create ($hGUI, "", 2, 2, 394, 100)
	$iMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, 0)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; Add files
	_GUICtrlComboBoxEx_AddDir ($hCombo, "", $DDL_DRIVES, False)
	
	; Get List
	$aItem = StringSplit(_GUICtrlComboBoxEx_GetList ($hCombo), $Delimiter)
	
	For $x = 1 To $aItem[0]
		MemoWrite($aItem[$x])
	Next
	

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>_Main

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
