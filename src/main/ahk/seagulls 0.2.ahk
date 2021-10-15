; ---------- START SCRIPT
f5::
birdcol = 0x8E8E80
chickCol1 = 0x00FFFF

Loop {
	PixelGetColor, hitBar,261 ,176
	PixelGetColor, hitBar2, 261, 186
	
	if(hitBar != 0x00FF00 AND hitBar != 0xFF0000 AND hitBar2 != 0x00FF00 AND hitBar2 != 0xFF0000){
		PixelSearch, foundX, foundY, 24, 47, 514, 362, chickCol1,0, Fast, RGB
		if(!ErrorLevel){
			Sleep, 200
			PixelGetColor, foundCol, foundX, foundY
			if(foundCol = 0xFFFF00){
				positions := getAbsolutePos()
				Random, offsetX, -3, 3
				Random, offsetY, 0, 6
				newX := positions[1] + foundX + offsetX
				newY := positions[2] + foundY + offsetY
				ControlSend, ,click`,%newX%`:%newY%{Enter},Windows PowerShell
				Sleep, 4000
				Continue
			}
			
		}
		
	}
	
	
	
	Random, rand, 1000, 1010
	
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