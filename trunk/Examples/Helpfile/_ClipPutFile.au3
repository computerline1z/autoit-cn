#include <Misc.au3>
Local $fTest
$fTest = _ClipPutFile(@ScriptFullPath)
If Not $fTest Then
	MsgBox(0,"_ClipPutFile() 调用失败","错误代码存放于 @error = " & @error)
Else
	MsgBox(0,"_ClipPutFile()","内容已经放到剪切板了:" & ClipGet())
EndIf


;汉化说明,反正我没有成功...系统显示无法读取源盘...以后再研究...