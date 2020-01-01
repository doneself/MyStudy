;;my autohotkey setting

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;Lwin & Tab::Send, ^!{Tab}
;;LWin & Tab::Send {LCtrl Down}{LAlt Down}{Tab}{LCtrl Up}{LAlt Up}
;;LCtrl & `::Send {LCtrl Down}{LAlt Down}{Tab}{LCtrl Up}{LAlt Up}
;;LWin & Tab::Send {LAlt Down}{Esc}{LAlt Up}

;;#IfWinActive emacs  ; if in emacs
;;	`::LAlt
;;	>^`:: Send ``
;;	>+`:: Send ~
;;    ;;+Capslock::Capslock ; make shift+Caps-Lock the Caps Lock toggle
;;	^Capslock::Capslock
;;    Capslock::RAlt   ; make Caps Lock the control button
;;	;;LCtrl::Alt
;;    #IfWinActive        ; end if in emacs

#MaxHotkeysPerInterval 200

#IfWinActive ahk_class Notepad2	
;;	Lctrl & 0::
;;	Send ^a ; Select All
;;	Sleep 30 ; Wait 30 ms.
;;	Send ^x ; Copy incident text to clipBoard
;;	ClipWait ; Wait for clipboard to fillYou pressed
;;	Send {Esc} ;
;;	return
	F12::
	Send ^a ; Select All
	Sleep 30 ; Wait 30 ms.
	Send ^x ; Copy incident text to clipBoard
	ClipWait ; Wait for clipboard to fillYou pressed
	Send {Esc} ;
	Run, https://mail.qq.com
	return
#IfWinActive

;;#IfWinNotActive  AkelPad  ; if in akelpad
	^Capslock::Capslock
	Capslock::LCtrl
 ;;   #IfWinActive        ; end if in akelpad

;;#\::
;;run D:\Zero\Software\Notepad2\Notepad2.exe
;;sleep 500
;;Send ^{Space}
;;return


