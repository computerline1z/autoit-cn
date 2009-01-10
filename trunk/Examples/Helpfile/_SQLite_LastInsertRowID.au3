#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <Array.au3>

Local $aResult, $iRows, $iColumns, $iRval

_SQLite_Startup ()
If @error > 0 Then
	MsgBox(16, "SQLite Error", "SQLite.dll Can't be Loaded!")
	Exit - 1
EndIf
ConsoleWrite("_SQLite_LibVersion=" &_SQLite_LibVersion() & @CR)
_SQLite_Open () ; Open a :memory: database
If @error > 0 Then
	MsgBox(16, "SQLite Error", "Can't Load Database!")
	Exit - 1
EndIf

;Example Table
; 	Name        | Age
; 	-----------------------
; 	Alice       | 43
; 	Bob         | 28
; 	Cindy       | 21

; _SQLite_Exec() and _SQLite_Execute() are quite similar
If Not _SQLite_Exec (-1, "CREATE TEMP TABLE persons (Name, Age);") = $SQLITE_OK Then _
		MsgBox(16, "SQLite Error", _SQLite_ErrMsg ())
If Not _SQLite_Exec (-1, "INSERT INTO persons VALUES ('Alice','43');") = $SQLITE_OK Then _
		MsgBox(16, "SQLite Error", _SQLite_ErrMsg ())
If Not _SQLite_Exec (-1, "INSERT INTO persons VALUES ('Bob','28');") = $SQLITE_OK Then _
		MsgBox(16, "SQLite Error", _SQLite_ErrMsg ())
If Not _SQLite_Exec (-1, "INSERT INTO persons VALUES ('Cindy','21');") = $SQLITE_OK Then _
		MsgBox(16, "SQLite Error", _SQLite_ErrMsg ())

; _SQLite_LastInsertRowID() tells us Cindy's row
MsgBox( 0, "_SQLite_LastInsertRowID()", _SQLite_LastInsertRowID() )

; Query
$iRval = _SQLite_GetTable (-1, "SELECT * FROM persons;", $aResult, $iRows, $iColumns)
If $iRval = $SQLITE_OK Then
;~ 	$aResult Looks Like this:
;~ 		[0]    = 8
;~ 		[1]    = Name
;~ 		[2]    = Age
;~ 		[3]    = Alice
;~ 		[4]    = 43
;~ 		[5]    = Bob
;~ 		[6]    = 28
;~ 		[7]    = Cindy
;~ 		[8]    = 21
	_ArrayDisplay($aResult, "Query Result")
Else
	MsgBox(16, "SQLite Error: " & $iRval, _SQLite_ErrMsg ())
EndIf

_SQLite_Close ()
_SQLite_Shutdown ()