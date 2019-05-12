#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         BaconCatBug

 Script Function:
	Find HP bar position

#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Misc.au3>


; Script Start - Add your code below here
$iniFile = @ScriptDir & "\HPTracker.ini"
$KillPid	= IniRead ( $iniFile, "HP", "PID", 99999999 )
IniWrite ($iniFile, "HP", "PID", @AutoItPID)
ProcessClose ($KillPid)

$AltCords = IniRead ( $iniFile, "EnableAltCoordinates", "EnableAltCoordinates", 0 )
$CordMode = "Coordinates"
if($AltCords = 1) then
   $CordMode="AltCoordinates"
EndIf
$X1 	= IniRead ( $iniFile, $CordMode, "LeftX", 0 )
$Y1 	= IniRead ( $iniFile, $CordMode, "LeftY", 0 )
$X2 	= IniRead ( $iniFile, $CordMode, "RightX", 0 )
$Y2 	= IniRead ( $iniFile, $CordMode, "RightY", 0 )
$Red	= IniRead ( $iniFile, "Colour", "Red", 0x000000 )
$Yellow = IniRead ( $iniFile, "Colour", "Yellow", 0x000000 )

Global $YY = 0
Do
Global $aCoord = PixelSearch($X1, $Y2, $X2, $Y1, $Red, 3)
If Not @error Then
   $YY = $aCoord[1]
EndIf
Sleep(10)
Until $YY > 0
$YY = 0
Sleep (100)
Do
Global $aCoord = PixelSearch($X1, $Y2, $X2, $Y1, $Red, 3)
If Not @error Then
   $YY = $aCoord[1]
EndIf
Sleep(10)
Until $YY > 0
Global $ZZ = 0
Do
Global $bCoord = PixelSearch($X2, $YY, $X1, $YY, $Yellow, 3)
If Not @error Then
   $ZZ = $bCoord[1]
EndIf
Sleep(10)
Until $ZZ > 0
IniWrite ( "HPTracker.ini", "HP", "HPLeftX", $aCoord[0] )
IniWrite ( "HPTracker.ini", "HP", "HPLeftY", $aCoord[1] )
IniWrite ( "HPTracker.ini", "HP", "HPRightX", $bCoord[0] )
IniWrite ( "HPTracker.ini", "HP", "HPRightY", $bCoord[1] )
Sleep (100)


Func Terminate()
    Exit
EndFunc   ;==>Terminate