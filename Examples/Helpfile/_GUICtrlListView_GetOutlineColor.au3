
#AutoIt3Wrapper_au3check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 
6 
#include  <GuiConstantsEx.au3> 
#include  <GuiListView.au3> 
#include  <GuiImageList.au3> 

Opt ( 'MustDeclareVars' ,  1 ) 

$Debug_LV  =  False  ; 检查传递给函数的类名, 设置为真并使用另一控件的句柄观察其工作 

_Main () 

Func _Main () 
    Local  $iX ,  $iY ,  $hImage ,  $hListView 
    
    GUICreate ( "ListView Get Outline Color" ,  400 ,  300 ) 
    $hListView  =  GUICtrlCreateListView ( "" ,  2 ,  2 ,  394 ,  268 ) 
  
  GUICtrlSetStyle ( $hListView ,  $LVS_ICON ) 
    ; 使扩展控件样式有效 
    _GUICtrlListView_SetExtendedListViewStyle ( $hListView ,  $LVS_EX_BORDERSELECT ) 
    GUISetState () 

  
  ; 加载图像 
    $hImage  =  _GUIImageList_Create () 
    _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0xFF0000 ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0x00FF00 ,  16 ,  16 )) 
  
  _GUIImageList_Add ( $hImage ,  _GUICtrlListView_CreateSolidBitMap ( $hListView ,  0x0000FF ,  16 ,  16 )) 
  
  _GUICtrlListView_SetImageList ( $hListView ,  $hImage ,  0 ) 

    ; 添加列 
    _GUICtrlListView_AddColumn ( $hListView ,  "Items" ,  100 ) 

    ; 添加项目 
    _GUICtrlListView_AddItem ( $hListView ,  "Item 1" ,  0 ) 
    _GUICtrlListView_AddItem ( $hListView ,  "Item 2" ,  1 ) 
    _GUICtrlListView_AddItem ( $hListView ,  "Item 3" ,  2 ) 

    ; 设置边框色 
    _GUICtrlListView_SetOutlineColor ( $hListView ,  0x0000FF ) 
    MsgBox ( 4160 ,  "Information" ,  "Outline Color: "  &  Hex ( _GUICtrlListView_GetOutlineColor ( $hListView ))) 

  
  ; 循环至用户退出 
    Do 
    Until  GUIGetMsg ()  =  $GUI_EVENT_CLOSE 
    GUIDelete () 
EndFunc    ;==>_Main 

