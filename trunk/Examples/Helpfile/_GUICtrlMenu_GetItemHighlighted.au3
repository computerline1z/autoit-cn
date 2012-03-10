#include <GuiMenu.au3>

_Main()

Func _Main()
	Local $hWnd, $hMain, $hFile

	; 打开记事本
	Run("notepad.exe")
	WinWaitActive("[CLASS:Notepad]")
	$hWnd = WinGetHandle("[CLASS:Notepad]")
	$hMain = _GUICtrlMenu_GetMenu($hWnd)
	$hFile = _GUICtrlMenu_GetItemSubMenu($hMain, 0)

	; Get/Set Open highlighted
	Writeln("Open is highlighted: " & _GUICtrlMenu_GetItemHighlighted($hFile, 1))
	_GUICtrlMenu_SetItemHighlighted($hFile, 1)
	Writeln("Open is highlighted: " & _GUICtrlMenu_GetItemHighlighted($hFile, 1))

EndFunc   ;==>_Main

; 写入一行文本到记事本
Func Writeln($sText)
	ControlSend("[CLASS:Notepad]", "", "Edit1", $sText & @CR)
EndFunc   ;==>Writeln
