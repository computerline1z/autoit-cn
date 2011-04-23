#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include "WinHttp.au3"
#include <Array.au3>

Opt("MustDeclareVars", 1)

; Internet Explorer proxy configuration for the current user:
Global $aIEproxy = _WinHttpGetIEProxyConfigForCurrentUser()
_ArrayDisplay($aIEproxy, "Internet Explorer proxy configuration")