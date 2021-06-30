/*

Welcome to Spooky Noodle's Camera-Scroll Script! 

If you're reading this, I assume that means you're looking
to boost your map awareness by quickly and easily checking
in on your teammates, and you're in exactly the right place. 

HOW TO USE

There are 2 versions of the script:

For this version (FLICK):
Scrolling just taps the associated Fkey, moving your camera
to the target ally, but without holding in place over them.
Tapping the Middle Mouse Button doesn't do anything special,
beyond what you have it bound to in League.

Here's how you use the script in-game:

At the start of the game, hold TAB and drag your little profile
to the middle of all the champions (if it's not there already.)
This makes things a little more intuitive, since the script
assumes you are the middle of the champion roster. 

$ Scroll Up/Down to cycle the camera between ally champions

$ Press or hold Space to return the camera to your champion

$ Use Ctrl + Alt + Middle Mouse Button to exit the script (in an emergency)

And that's everything. Supreme map awareness is at your
fingertips, summoner! Good luck, and have fun.


Here there be dragons...

!! DON'T EDIT ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING !!

*/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SendMode Event ; Only way to get AHK scripts working in LoL

; This is a good key delay, gives enough time between commands that
; the game can register them, but is still lightning-fast 
SetKeyDelay, 35, 0 

#UseHook, On; Also required for working LoL AHK scripts

findLeague(){
    ; If we're not running the script from the LoL
    ; install folder, copies itself to there, and
    ; creates a desktop shortcut
    if not InStr(A_ScriptFullPath, "League of Legends\" A_ScriptName) {
        locationsArray := ["C:\Riot Games\League of Legends", "C:\Program Files\Riot Games\League of Legends", "C:\Program Files (x86)\Riot Games\League of Legends", "D:\Riot Games\League of Legends", "D:\Program Files\Riot Games\League of Legends", "D:\Program Files (x86)\Riot Games\League of Legends"]
        for index, loc in locationsArray {
            if InStr(FileExist(loc), "D"){
                Return loc
            }
        }
        MsgBox, 0x10, League Camera Scroll, % "League Camera Scroll could not locate your LoL installation.`n`nPlease copy the file to your installation, create an easily-accessible shortcut, and run LCS again."
        ExitApp
    }
    Return A_ScriptDir
}

adjustLeagueSettings(){
    ; double-check to make sure the user's settings
    ; are set up compatibly, and that League's
    ; scrolling is disabled
    SetWorkingDir % findLeague()
    edited := False
    cameraControls := ["evtSelectAlly4=[F5]", "evtSelectAlly3=[F4]", "evtSelectAlly2=[F3]", "evtSelectAlly1=[F2]", "evtCameraSnap=[Space]"]
    ; I know it seems redundant to have these two lists
    ; but it was seriously the only way I could get the
    ; Regex to cooperate
    cameraRegex := ["evtSelectAlly4=.+", "evtSelectAlly3=.+", "evtSelectAlly2=.+", "evtSelectAlly1=.+", "evtCameraSnap=.+"]
    FileRead, leagueInput, % "Config\input.ini"
    for index, setting in cameraControls {
        if not InStr(leagueInput, setting){
            edited := True
            leagueInput := RegExReplace(leagueInput, cameraRegex[index], setting)
        }
    }
    ; now check to see if scrolling is disabled
    rollerButton := "RollerButtonSpeed=0"
    rollerButtonSetting := "`n`n[MouseSettings]`nRollerButtonSpeed=0"
    if not InStr(leagueInput, rollerButton){
        edited := True
        leagueInput .= rollerButtonSetting
    }
    if edited {
        inputFile := FileOpen("Config\input.ini", "w")
        inputFile.Write(leagueInput)
        inputFile.Close()
    }
}

adjustLeagueSettings()

warnString = 
(
People have been using AHK scripts in League for a decade, and the only ones who have received anything like a ban or warning are people cheesing inhuman combos. 

We're basically just remapping some of the keyboard shortcuts to a different key.

    HOWEVER:

I can't guarantee the safety of your League account if you're using AHK scripts (such as this one) during your games. 

It seems REALLY unlikely that they'd ban someone for this, but use at your own discretion.
)
MsgBox, 0x111, WARNING, %warnString%
IfMsgBox, Cancel
    ExitApp

; The array of f-keys between which to cycle
; starts at F3 to allow quick, intuitive
; access to teammates
keyArray := ["F3", "F2", "F5", "F4"]

; The index pointing to which ally
; we want to spectate, manipulated
; by the various hotkeys
keyInd := 0

WheelUp::
if WinActive("ahk_exe League of Legends.exe") {
    ; Wraps around to the start of the array,
    ; if the user has reached the end
    if (keyInd >= keyArray.Length()){
        keyInd := 1
    }
    else {
        keyInd ++
    }
    Send % "{" keyArray[keyInd] "}"
}
else {
    Send {WheelUp}
}
Return

WheelDown::
if WinActive("ahk_exe League of Legends.exe") {
    ; wrap around to the end of the array,
    ; if the user has reached the start
    if (keyInd <= 1){
        keyInd := keyArray.Length()
    }
    else {
        keyInd --
    }
    Send % "{" keyArray[keyInd] "}"
}
else {
    Send {WheelDown}
}
Return

; Having separate hotkeys for {Space down}
; and {Space up} allows LoL to register the
; button presses, while still allowing the
; user to press and hold Space to center
; the camera on their champion as they move,
; if they want to do that

Space::
Send {Space down}
keyInd := 0
Return

Space Up::Send {Space up}

; Emergency exit for the script, if something goes wrong
^!MButton::Exit