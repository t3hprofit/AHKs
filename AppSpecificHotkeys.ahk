;{{{ Confluence
#IfWinActive Confluence ahk_class Chrome_WindowImpl_0
^s::
#IfWinActive Confluence ahk_class Chrome_WidgetWin_0
^s::
;debug("hi")
;Maybe we should page up to the top of the screen, but maybe not needed
ClickIfImageSearch("images\confluence\ConfluenceSaveButton.bmp", "Control")
ClickIfImageSearch("images\confluence\ConfluenceSaveButtonXP.bmp", "Control")

;Wait for webpage to load
Sleep, 2000

ClickIfImageSearch("images\confluence\ConfluenceOverwriteButton.bmp", "Control")
ClickIfImageSearch("images\confluence\ConfluenceOverwriteButtonXP.bmp", "Control")
return
#IfWinActive ;End Confluence
;}}}

;{{{ JIRA
#IfWinActive JIRA ahk_class Chrome_WindowImpl_0
!s::
#IfWinActive JIRA ahk_class Chrome_WidgetWin_0
!s::
Send, {PGDN 4}
ClickIfImageSearch("images\jira\UpdateButton.bmp", "Control")
return
#IfWinActive ;end jira
;}}}

;{{{ Cmd console
/*
;FIXME Seems that this never happens (so copy/paste doesn't work in cmd prompt (admin mode)
;NOTE seems to happen all the time now... going to disable this
;#IfWinActive Administrator: Command Prompt ahk_class ConsoleWindowClass
;d:: errord("Admin command prompt detected", "this never seems to happen", "check the logs and attempt to reproduce", "maybe you only have one cmd window open and that's why it worked")
;#IfWinActive
*/

#IfWinActive ahk_class ConsoleWindowClass
;#IfWinActive Administrator: Command Prompt ahk_class ConsoleWindowClass
;#IfWinActive C:\Windows\system32\cmd.exe ahk_class ConsoleWindowClass
^c::
WinGetActiveTitle, title
if title contains perl
{
   Send, ^c
}
else
{
   MouseClick, right, 13, 13
   Sleep 100
   Send, {UP 3}{RIGHT}{DOWN 3}
   Sleep 100
   Send, {ENTER}
   Sleep 100
   Send, {ENTER}
}
return

^v::
SendInput {Raw}%clipboard%
;MouseClick, right, 100, 100
;Send, {DOWN 3}{ENTER}
return

PGUP:: SendInput, {WHEELUP 10}
PGDN:: SendInput, {WHEELDOWN 10}
#IfWinActive ;End ahk_class ConsoleWindowClass
;}}}

;{{{ Git
;#IfWinActive MINGW32
/*
PGUP:: SendInput, {WHEELUP 10}
PGDN:: SendInput, {WHEELDOWN 10}
*/
;#IfWinActive ;End ahk_class ConsoleWindowClass
;}}}

;{{{ pgAdmin
#IfWinActive pgAdmin III ahk_class wxWindowClassNR
d::
Loop 10
{
   ;SendMode, Play
   ForceWinFocus("pgAdmin III ahk_class wxWindowClassNR")
   OpenConnectionExists := ClickIfImageSearch("images\pgAdmin\OpenDbConnection.bmp", "Right")
   if NOT OpenConnectionExists
      return
   WaitForImageSearch("images\pgAdmin\Disconnect.bmp")
   ClickIfImageSearch("images\pgAdmin\Disconnect.bmp")
   ;SendMode, Event
}
return
o::
ClickIfImageSearch("images\pgAdmin\ViewDataInTable.bmp", "Control")
ForceWinFocus("pgAdmin III ahk_class wxWindowClassNR")
;MouseMove, 0, -10, , r
return
j:: Send, {DOWN}
k:: Send, {UP}
;Select All
^a::
SendInput {Home}
SendInput ^+{End}
return
#IfWinActive ;End pgAdmin III ahk_class wxWindowClassNR

;Part of pgAdmin (windows were created by pgAdmin but don't have it in the title
#IfWinActive (Maintain|Backup|Restore) Database ahk_class #32770
^a::
SendInput ^{Home}
SendInput ^+{End}
return
#IfWinActive ;end Restore Database ahk_class #32770
;}}}

;{{{ Window Spy
#IfWinActive Active Window Info \(Shift-Alt-Tab to freeze display\) ahk_class AU3Reveal
;Select All
^a::
SendInput ^{Home}
SendInput ^+{End}
return
#IfWinActive ;end Active Window Info (Shift-Alt-Tab to freeze display) ahk_class AU3Reveal
;}}}

;{{{ ScriptWriter
#IfWinActive AutoScriptWriter II - \( by Larry Keys \)
;Select All
^a::
SendInput ^{Home}
SendInput ^+{End}
return
#IfWinActive ;end AutoScriptWriter II - ( by Larry Keys )
;}}}

;{{{ Perforce
#IfWinActive .*Perforce P4Merge ahk_class QWidget
;Previous diff
^UP:: Send, ^1

;Next diff
^DOWN:: Send, ^2
#IfWinActive ;end Perforce P4Merge ahk_class QWidget
;}}}

;{{{ Hotkeys to make svn commits easier
#IfWinActive .*\..* - TortoiseMerge
^SPACE::
^ENTER::
#IfWinActive Commit - C:\\.* ahk_class #32770
^SPACE::
^ENTER::
ENTER:: ;this keeps me from accidentally committing by hitting enter
parentWin=Commit - C:\\.* ahk_class #32770
diffWin=.*\..* - TortoiseMerge
ForceWinFocus(parentWin, "RegEx")
Send, {SPACE}
return
#IfWinActive

#IfWinActive Log Messages - C:\\.* ahk_class #32770
^LEFT::
#IfWinActive Commit - C:\\.* ahk_class #32770
^LEFT::
#IfWinActive .*\..* - TortoiseMerge
^LEFT::
parentWin=Commit - C:\\.* ahk_class #32770
diffWin=.*\..* - TortoiseMerge
parentWin2=Log Messages - C:\\.* ahk_class #32770
ForceWinFocusIfExist(parentWin, "RegEx")
ForceWinFocusIfExist(parentWin2, "RegEx")
Send, {UP}{ENTER}
return
#IfWinActive

#IfWinActive Log Messages - C:\\.* ahk_class #32770
^RIGHT::
#IfWinActive Commit - C:\\.* ahk_class #32770
^RIGHT::
#IfWinActive .*\..* - TortoiseMerge
^RIGHT::
parentWin=Commit - C:\\.* ahk_class #32770
diffWin=.*\..* - TortoiseMerge
parentWin2=Log Messages - C:\\.* ahk_class #32770
ForceWinFocusIfExist(parentWin, "RegEx")
ForceWinFocusIfExist(parentWin2, "RegEx")
Send, {DOWN}{ENTER}
return
#IfWinActive

#IfWinActive Log Messages - C:\\.* ahk_class #32770
^UP::
#IfWinActive Commit - C:\\.* ahk_class #32770
^UP::
parentWin=Commit - C:\\.* ahk_class #32770
diffWin=.*\..* - TortoiseMerge
ForceWinFocus(diffWin, "RegEx")
Send, ^{UP}
return
#IfWinActive

#IfWinActive Log Messages - C:\\.* ahk_class #32770
^DOWN::
#IfWinActive Commit - C:\\.* ahk_class #32770
^DOWN::
parentWin=Commit - C:\\.* ahk_class #32770
diffWin=.*\..* - TortoiseMerge
ForceWinFocus(diffWin, "RegEx")
Send, ^{DOWN}
return
#IfWinActive
;}}}

;{{{Pidgin Easily start a new IM
#IfWinActive ahk_class gdkWindowToplevel
;only if it doesn't contain "Buddy List"
;#IfWinActive Buddy List ahk_class gdkWindowToplevel
^m::
person := Prompt("Who would you like to IM?")
if (person=="") return

;TODO putting emails in would be the fastest way, but I don't want to put a mapping in the code
;TODO maybe we could scan the pidgin folder and find the mapping in an ini?
if InStr(person, "mel")
   person=Melinda
if InStr(person, "nat")
   person=Nathan Dyck
if InStr(person, "c4")
   person=c-4
   ;person=absinthe.10.6@gmail.com

ForceWinFocus("ahk_class gdkWindowToplevel")
SendInput, ^m
WinWaitActive, Pidgin
SendInput, %person%

;FIXME ugly, and did I mention: ugly
Sleep, 1000

SendInput, {DOWN}{ENTER 2}
return

^w::
;don't kill chat windows accidentally with hotkeys
return

^v::
;don't paste into irc or gchat - experiment to see the habits i have with pidgin
return
#IfWinActive
;}}}

;{{{ Vim
#IfWinActive ahk_class Vim

;remap undo
^z::
Send, {ESC 6}u
return

#IfWinActive ;end Vim
;}}}

;{{{ Irssi
#IfWinActive Irssi ahk_class PuTTY
^g::
Run, %Clipboard%
return
#IfWinActive
;}}}

;{{{ SSMS
#IfWinActive Microsoft SQL Server Management Studio ahk_class wndclass_desked_gsk
^n::
if ClickIfImageSearch("images\ssms\DropdownDefaultSelected.bmp")
{
   Sleep, 200
   ClickIfImageSearch("images\ssms\EpmsDb.bmp")
   Sleep, 100
}
ClickIfImageSearch("images\ssms\NewQueryButton.bmp")
Sleep, 900
if ClickIfImageSearch("images\ssms\DropdownDefaultSelected.bmp")
{
   Sleep, 200
   ClickIfImageSearch("images\ssms\EpmsDb.bmp")
   Sleep, 100
}
return
#IfWinActive
;}}}

;{{{ MSPaint
#IfWinActive ahk_class MSPaintApp
NumpadMult::
if (GetOS() == "WIN_7")
   Send, ^+x
else
   Send, ^x^e1{TAB}1{ENTER}^v
return

NumpadAdd::
if (GetOS() == "WIN_7")
   Send, ^{PGUP}
else
   Send, {ALT}vzu6{ENTER}
return

NumpadSub::
if (GetOS() == "WIN_7")
   Send, ^{PGDN}
else
   Send, ^{PGUP}
return
#IfWinActive
;}}}

;{{{EPMS stuff for Melinda
#IfWinActive EPMS Shop
;#IfWinActive Mozilla Firefox
^+e::
SendInput, {CTRL UP}{SHIFT UP}Based on the Leasing Professional's presentation, would you have leased this apartment? Why or Why Not? Please answer based on the presentation only, not on the apartment or community.
return
#IfWinActive
;}}}
