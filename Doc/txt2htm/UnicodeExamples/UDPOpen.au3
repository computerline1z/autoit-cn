﻿;客户端!!!!!!!! 先打开服务器端... dummy!!
Local $g_IP = "127.0.0.1"

; 开始 UDP 服务
;==============================================
UDPStartup()

; 连接到一个监听的套接字("SOCKET")
;==============================================
Local $socket = UDPOpen($g_IP, 65432)
If @error <> 0 Then Exit
