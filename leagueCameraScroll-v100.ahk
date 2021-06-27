/*

Welcome to Spooky Noodle's Camera-Scroll Script! 

If you're reading this, I assume that means you're looking
to boost your map awareness by quickly and easily checking
in on your teammates, and you're in exactly the right place. 

But there's a few things you need to do first, before this
script will work in your games:

$ = This item is important (for if you're in a hurry)

HOW TO SET UP

1. $ Install AutoHotKey 
    
    URL: https://www.autohotkey.com/
    
    (This is the engine that drives the script. Don't worry, 
    people have been using AHK scripts in League for a decade,
    and the only ones who have received anything like a ban
    or warning are people cheesing inhuman combos. We're
    basically just remapping some of the keyboard shortcuts to
    a different key. With that being said...)

    $ !! WARNING !!
    
    I can't guarantee the safety of your League account if you're
    using AHK scripts (such as this one) during your games. It
    seems REALLY unlikely that they'd ban someone for this, but
    use at your own discretion.

2. Disable In-Game Scrolling
    
    Go to C:\Riot Games\League of Legends\Config (or wherever you
    installed the game files), and do 2 things:

    a. $ Delete PersistedSettings.json
        (Don't worry, it will be re-generated the first time you
        launch into a game, even the Practice Tool.)

    b. $ Edit input.ini and copy + paste the following to the
    bottom of the file:

[MouseSettings]
RollerButtonSpeed=0

        Just like that, with the [MouseSettings] on a line above
        the 'RollerButtonSpeed' option.
    
    Once those are both done, scrolling your mouse wheel will
    no longer zoom in/out when you're in a game. 

        (You also won't be able to scroll up or down in the in-game
        options menu, so either click-drag the scroll bar or edit
        your settings in the client.)

        NOTE: Signing out then signing in to a Riot account
        (either the same one, or a different one) will reset
        these settings, so make sure to repeat this step if you
        switch accounts regularly.

3. Set Up Your Hotkeys

    $ Either in-game or in the client, make sure the following
    camera control hotkeys are bound correctly, otherwise the
    script won't work:

        Center Camera on Champion: Spce
        Select Ally 1: F2
        Select Ally 2: F3
        Select Ally 3: F4
        Select Ally 4: F5
    
    I would also recommend binding the 'Scroll Up/Down'
    hotkeys to something other than the arrow keys. 
    Just something random on your keyboard that you
    never touch. There will sometimes be a TINY bit
    of stutter if you don't do this, so it's really
    just up to personal preference. 

HOW TO USE

Once you've got all of that taken care of, you just
double-click this ahk file, and it will start running,
watching for your commands


Here's how you use the script in-game:

At the start of the game, hold TAB and drag your little profile
to the middle of all the champions (if it's not there already.)
This makes things a little more intuitive, since the script
assumes you are the middle of the champion roster. 

$ Scroll Up/Down to cycle the camera between ally champions

$ Press or hold Space to return the camera to your champion

$ Press or hold Middle Button to unlock the camera

$ Use Ctrl + Middle Button to exit the script (in an emergency)

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

leagueScrollHotkeys() {
    ; The array of f-keys between which to cycle
    ; starts at F3 to allow quick, intuitive
    ; access to teammates
    keyArray := ["F3", "F2", "F5", "F4"]

    ; The index pointing to which ally
    ; we want to spectate, manipulated
    ; by the various hotkeys
    keyInd := 0

    if WinActive("ahk_exe League of Legends.exe") {
        WheelUp::
        if (keyInd > 0) {
            Send % "{" keyArray[keyInd] " up}"
        }
        ; Wraps around to the start of the array,
        ; if the user has reached the end
        if (keyInd >= keyArray.Length()){
            keyInd := 1
        }
        else {
            keyInd ++
        }
        Send % "{" keyArray[keyInd] " down}"
        Return

        WheelDown::
        if (keyInd > 0) {
            Send % "{" keyArray[keyInd] " up}"
        }
        ; wrap around to the end of the array,
        ; if the user has reached the start
        if (keyInd <= 1){
            keyInd := keyArray.Length()
        }
        else {
            keyInd --
        }
        Send % "{" keyArray[keyInd] " down}"
        Return

        ; Having separate hotkeys for {Space down}
        ; and {Space up} allows LoL to register the
        ; button presses, while still allowing the
        ; user to press and hold Space to center
        ; the camera on their champion as they move,
        ; if they want to do that

        Space::
        if (keyInd > 0){
            Send % "{" keyArray[keyInd] " up}"
        }
        Send {Space down}
        keyInd := 0
        Return

        Space Up::Send {Space up}

        ; Same deal here, some people want to be able
        ; to hold the MButton, so we're using separate
        ; hotkeys

        MButton::
        if (keyInd > 0) {
            Send % "{" keyArray[keyInd] " up}"
        }
        Send {MButton down}
        Return

        MButton Up::Send {MButton up}
    }
}

copyScriptToLeagueFolder(){
    ; TODO
}

main(){
    leagueScrollHotkeys()
}

main()

; Emergency exit for the script, if something goes wrong
^MButton::Exit