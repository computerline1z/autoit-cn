AdlibRegister("MyAdlib")
;...
AdlibUnRegister("MyAdlib")

Func MyAdlib()
	;... 运行中尽量避免使用等待效果的函数, 例如 Wait(), MsgBox(), InputBox()等...
EndFunc   ;==>MyAdlib
