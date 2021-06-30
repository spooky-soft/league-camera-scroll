# USER GUIDE

NOTE: This user guide is only for version 1, for if you want to set up dependencies yourself. 

There's a few things you need to do first, before this script will work in your games:

⭐ = This item is important (for if you're in a hurry)

## HOW TO SET UP

### ⭐ Install AutoHotKey

(`.ahk` versions only)

URL: https://www.autohotkey.com/

⭐ (Optionally, you can download the `.exe` version, which includes the AHK interpreter.)

This is the engine that drives the script. Don't worry, people have been using AHK scripts in League for a decade, and the only ones who have received anything like a ban or warning are people cheesing inhuman combos. We're basically just remapping some of the keyboard shortcuts to a different key. With that being said...

#### ⭐ !! WARNING !!

I can't guarantee the safety of your League account if you're using AHK scripts (such as this one) during your games. It seems REALLY unlikely that they'd ban someone for this, but use at your own discretion.

### Disable In-Game Scrolling

Go to `C:\Riot Games\League of Legends\Config` (or wherever you installed the game files), and do 2 things:

#### ⭐ Delete `PersistedSettings.json`

Don't worry, it will be re-generated the first time you launch into a game, even the Practice Tool.

#### ⭐ Edit `input.ini` and copy + paste the following to the bottom of the file:

```
[MouseSettings]
RollerButtonSpeed=0
```

Just like that, with the `[MouseSettings]` on a line above the `RollerButtonSpeed=0` option.

Once those are both done, scrolling your mouse wheel will no longer zoom in/out when you're in a game.

⭐ (You also won't be able to scroll up or down in the in-game options menu or shop, so either click-drag the scroll bar or edit your settings in the client.)

##### NOTE:

Signing out then signing in to a Riot account (either the same one, or a different one) will reset these settings, so make sure to repeat this step if you switch accounts regularly.

### Set Up Your Hotkeys

⭐ Either in-game or in the client, make sure the following camera control hotkeys are bound correctly, otherwise the script won't work:

```
Center Camera on Champion: Spce
Select Ally 1: F2
Select Ally 2: F3
Select Ally 3: F4
Select Ally 4: F5
```
