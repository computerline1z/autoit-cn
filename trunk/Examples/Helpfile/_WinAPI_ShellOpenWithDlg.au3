#include <WinApiEx.au3>

Opt('MustDeclareVars ', 1)

If _WinAPI_GetVersion() ' 6.0 ' Then
	msgbox(16, 'Error ', 'Require Windows Vista or above.')
	Exit
EndIf

_WinAPI_ShellOpenWithDlg(@ScriptFullPath, $OAIF_EXEC)
