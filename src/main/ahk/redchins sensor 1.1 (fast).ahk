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
disTrapColor = 0xFF0000
idleTrapColor = 0xFFFF00
caughtTrapColor = 0x00FF00
fallenTrapColor = 0xAA0073

PixelGetColor, trap1Pos, 291, 207
PixelGetColor, trap1Idle, 291, 210
foundTrap := []

Loop {	
	; Try to find a trap
		idleTrapColor = 0xFFFF00

	

	if(foundTrap.Count() > 0){
		positions := getAbsolutePos()
		type := foundTrap[1]
		thePosX := foundTrap[2]
		thePosY := foundTrap[3]
		;WinActivateBottom, Windows PowerShell
		;Sleep, 10
	
		Random, offsetX, -6, 6
		Random, offsetY, 0, 15
		
		if(type = "f"){
			newX := positions[1] + (thePosX-20) + offsetX
			newY := positions[2] + (thePosY+10) + offsetY
		}else {
			newX := positions[1] + thePosX + offsetX
			newY := positions[2] + thePosY + offsetY
		}
		
		
		;Send, %type%,%newX%:%newY%
		;Sleep, 50
		;Send, {Enter}
		ControlSend, ,%type%`,%newX%`:%newY%{Enter},Windows PowerShell
		if(type = "f"){
			Random, random, 2500,2550
		}else{
			Random, random, 3500,3550
		}
		Sleep, random
		Loop, 200 {
			;Loop,2{
				;foundTrap := searchTrap()
			;}
			;foundTrap := searchTrap()
	
			
			PixelSearch, hasPlacedX, hasPlacedY, 258 , 188, 270, 200, idleTrapColor, 3, Fast, RGB 
			if(!ErrorLevel) {
				Break
			}
			Sleep, 10
		}
		;foundTrap := searchTrap()
		foundTrap := []
		
		Continue
	} else {
		foundTrap := searchTrap()
	}
	

	
	Random, rand, 10, 15
	
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

searchTrap(){
	disTrapColor = 0xFF0000
	idleTrapColor = 0xFFFF00
	caughtTrapColor = 0x00FF00
	fallenTrapColor = 0xAA0073
	
		trap := []
		;PixelSearch, trapFallenX, trapFallenY,14,107,508, 365, fallenTrapColor, 1, Fast, RGB
		PixelSearch, trapFallenX, trapFallenY,162,89,369, 280, fallenTrapColor, 1, Fast, RGB

		if(ErrorLevel) {
				
			
		}else {
			trap := ["f", trapFallenX, trapFallenY]
			return trap
		}
		
		PixelSearch, trapChtX, trapChtY,14,107,508, 365, caughtTrapColor, 1, Fast
		if(ErrorLevel) {
		}else {
			trap := ["c",trapChtX, trapChtY]
			return trap
		}
		
		PixelSearch, trapDisX, trapDisY,14,107,508, 365, disTrapColor, 1, Fast, RGB
		if(ErrorLevel) {
			
		}else {
			trap := ["d",trapDisX, trapDisY]
			return trap
		}
	
}

; IMPORTANT, coords based on default zoom
searchOthers(){
	disTrapColor = 0xFF0000
	idleTrapColor = 0xFFFF00
	caughtTrapColor = 0x00FF00
	fallenTrapColor = 0xAA0073
	
	playerXMin =
	playerYMin = 
	playerXMax =
	playerYMax = 
	
	return pos
}