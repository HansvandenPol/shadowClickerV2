^+LButton::  ; Control+Alt+Z hotkey.
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
MsgBox %color% (%MouseX%, %MouseY%).
return

; ---------- Set trap1 tile
^LButton:: 
MouseGetPos, startX, startY
KeyWait, RButton, D 
MouseGetPos, endX, endY
middleX := startX+((endX-startX)/2)
middleY := startY+((endY-startY)/2)
return

; ---------- Set trap2 tile
^!LButton:: 
MouseGetPos, start2X, start2Y
KeyWait, RButton, D 
MouseGetPos, end2X, end2Y
middle2X := start2X+((end2X-start2X)/2)
middle2Y := start2Y+((end2Y-start2Y)/2)
return

; ---------- Set trap3 tile
!LButton:: 
MouseGetPos, start3X, start3Y
KeyWait, RButton, D 
MouseGetPos, end3X, end3Y
middle3X := start3X+((end3X-start3X)/2)
middle3Y := start3Y+((end3Y-start3Y)/2)
return

; ---------- START SCRIPT
f5::

Loop {	
	disTrapColor = 0xFF0000
	idleTrapColor = 0xFFFF00
	caughtTrapColor = 0x00FF00
	fallenTrapColor = 0xAA00FF
	;disTrapColor = 0x2B3DAC
	;idleTrapColor = 0x2EA6B3
	;caughtTrapColor = 0x2AA047
	
	PixelGetColor, trap1Pos, 291, 207
	PixelGetColor, trap1Idle, 291, 210
	Random, randSleep, 8900, 8950
	positions := getAbsolutePos()
	
	PixelSearch, trapFallenX, trapFallenY,187,86,422, 306, fallenTrapColor, 1, Fast, RGB
	if(ErrorLevel) {
		
	}else {
		
		WinActivateBottom, Windows PowerShell
		Sleep, 50
	
		Random, offsetX, -6, 6
		Random, offsetY, 0, 15
		newX := positions[1] + (trapFallenX-20) + offsetX
		newY := positions[2] + (trapFallenY+10) + offsetY
		
		Send, fallen,%newX%:%newY%
		Sleep, 50
		Send, {Enter}
		Random, sleeptime, 9500, 10000
		Sleep, sleeptime
		
		
		Continue
	}
	
	PixelSearch, trapChtX, trapChtY,187,86,422, 306, caughtTrapColor, 1, Fast
	if(ErrorLevel) {
		
	}else {
		
		WinActivateBottom, Windows PowerShell
		Sleep, 50
		
		Random, offsetX, -6, 6
		Random, offsetY, 0, 15
		newX := positions[1] + trapChtX + offsetX
		newY := positions[2] + trapChtY + offsetY
		Send, caught,%newX%:%newY%
		Sleep, 50
		Send, {Enter}
		
		Random, sleeptime, 9500, 10000
		Sleep, sleeptime
		
		Continue
	}
	
	PixelSearch, trapDisX, trapDisY,187,86,422, 306, disTrapColor, 1, Fast, RGB

	if(ErrorLevel) {
		
	}else {
		
		WinActivateBottom, Windows PowerShell
		Sleep, 50
		
		Random, offsetX, -6, 6
		Random, offsetY, 0, 15
		newX := positions[1] + trapDisX + offsetX
		newY := positions[2] + trapDisY + offsetY
		Send, dis,%newX%:%newY%
		Sleep, 50
		Send, {Enter}
		
		Random, sleeptime, 9500, 10000
		Sleep, sleeptime
		
		Continue
	}
	
	Random, rand, 200, 210
	
	Sleep, rand
}		

; ---------- STOP THE SCRIPT
f12::
ExitApp

getAbsolutePos(){
	WinGetPos, X, Y, width, heigth, RuneLite
	ar := [X,Y]
	return ar	
}