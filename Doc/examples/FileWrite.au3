$file = FileOpen("test.txt", 1)

; ����ļ������Ƿ�Ϊд
If $file = -1 Then
	MsgBox(0, "����", "���ܴ��ļ�.")
	Exit
EndIf

FileWrite($file, "Line1")
FileWrite($file, "Still Line1" & @CRLF)
FileWrite($file, "Line2")

FileClose($file)