$file = FileOpen("test.txt", 1)

; ����Ƿ��ļ�Ϊ�����Ա�ô�
If $file = -1 Then
	MsgBox(0, "����", "���ܴ��ļ�.")
	Exit
EndIf

FileWriteLine($file, "Line1")
FileWriteLine($file, "Line2" & @CRLF)
FileWriteLine($file, "Line3")

FileClose($file)