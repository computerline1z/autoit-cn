﻿DirCreate("c:\dir_test\dir1")
FileWrite("c:\dir_test\dir1\test.txt",'test')
DirMove("c:\dir_test\dir1", "c:\dir_test\dir2", 1)
MsgBox(32,"","文件夹已移动")
;移除创建的文件夹
DirRemove("c:\dir_test",1)