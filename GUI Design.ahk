#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

FolderPath := ""
ListingPath := ""

Gui, Add, Text,, Select a folder to generate a directory listing:
Gui, Add, Button, gChooseFolderButton, Source Folder
Gui, Add, Edit, section X+10 yp r1 vFolderPath W300

Gui, Add, Text, xm Y+25, Select a file to save the listing:
Gui, Add, Button, gChooseListingButton, Listing File
Gui, Add, Edit, xs yp r1 vListingPath W300

Gui, Show, , Directory Listing Generator
return

GuiClose:
ExitApp

ChooseFolderButton:
return

ChooseListingButton:
return
