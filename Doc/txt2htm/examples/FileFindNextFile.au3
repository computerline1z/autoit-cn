; ��ʾ��ǰĿ¼�������ļ����ļ���
Local $search = FileFindFirstFile("*.*")

; ��������Ƿ�ɹ�
If $search = -1 Then
	MsgBox(0, "����", "û���ļ�/Ŀ¼ ƥ������")
	Exit
EndIf

While 1
	Local $file = FileFindNextFile($search)
	If @error Then ExitLoop

	MsgBox(4096, "�ļ�:", $file)
WEnd

; �ر��������
FileClose($search)