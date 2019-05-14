#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#InstallKeybdHook
#KeyHistory 0
ListLines Off
#SingleInstance Force
SetBatchLines, 1
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
CoordMode, Tooltip, Screen
DetectHiddenWindows, On

IniRead, Black, HPTracker.ini, Colour, Black
IniRead, EmulatorTopX, HPTracker.ini, Coordinates, LeftX
IniRead, EmulatorTopY, HPTracker.ini, Coordinates, LeftY
IniRead, BlackSensitivity, HPTracker.ini, Colour, BlackSensitivity

Tooltip, ++++++++++++++`n++Finding HP Bar++`n++++++++++++++, EmulatorTopX, EmulatorTopY
RunWait, AutoIt3.exe FindHP.au3


IniRead, Final_HP_Left_X, HPTracker.ini, HP, HPLeftX
IniRead, Final_HP_Right_X, HPTracker.ini, HP, HPRightX
IniRead, Final_HP_Right_Y, HPTracker.ini, HP, HPRightY
Final_HP_Left_X--
Final_HP_Right_X++


HP_Max := Final_HP_Right_X-Final_HP_Left_X
HP_Current := HP_Max
HP_Right_X := Final_HP_Right_X+2
HP_Right_Y := Final_HP_Right_Y
Track_HP:
loop{
	HP_Percent := Round((HP_Current/HP_Max)*100,1)
	Tooltip, ~%HP_Percent%`%, Final_HP_Right_X-((Final_HP_Right_X-Final_HP_Left_X)/1.5),HP_Right_Y+11
	HP_Current--
	HP_Right_X--
	countblack :=0
	loop{
		PixelGetColor, PGCXY, HP_Right_X, HP_Right_Y, RGB
		if (PGCXY = Black)
			countblack++
	} until countblack > BlackSensitivity
} until HP_Percent <= 0.5

Tooltip, Congrats on the Win`n Ctrl+Space to reload`, Ctrl+Shift+Space to exit, Final_HP_Right_X-((Final_HP_Right_X-Final_HP_Left_X)/1.5),Final_HP_Right_Y+10

^Space::Reload
^+Space::
IniRead, KillPID, HPTracker.ini, HP, PID
WinClose, ahk_pid %KillPID%
Exitapp
