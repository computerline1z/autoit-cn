﻿#include <Constants.au3>
#NoTrayIcon

Opt("TrayAutoPause",0)	; 当点击托盘图标时脚本不会暂停.

Local $valitem	= TrayCreateItem("值:")
TrayCreateItem("")
Local $aboutitem	= TrayCreateItem("关于")

TraySetState()

TrayItemSetText($TRAY_ITEM_EXIT,"退出程序")
TrayItemSetText($TRAY_ITEM_PAUSE,"暂停程序")

While 1
	Local $msg = TrayGetMsg()
	Select
		Case $msg = 0
			ContinueLoop
		Case $msg = $valitem
			TrayItemSetText($valitem,"值:" & Int(Random(1,10,1)))
		Case $msg = $aboutitem
			MsgBox(64,"关于:","AutoIt3-托盘-例子")
	EndSelect
WEnd

Exit
