﻿; *******************************************************
; 例 1 - 打开带有基本示例的浏览器, 读取文档HTML
;    (所有HTML包含<HEAD>和脚本)并在MsgBox中显示
; *******************************************************
;
#include <IE.au3>
$oIE = _IE_Example ("basic")
$sHTML = _IEDocReadHTML ($oIE)
MsgBox(0, "文档的源代码", $sHTML)