#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

VERSION = 1.0

EnvGet, userHome, HOMEPATH

FolderPath := ""
ListingPath := ""
IncludeDirectories := ""

Gui, Font, s12
Gui, Add, Text,, 1. Select a folder to generate a directory listing`n   (or drag && drop a folder):
Gui, Font
Gui, Add, Button, gChooseFolderButton, Source Folder
Gui, Add, Edit, section X+10 yp r1 vFolderPath W300

Gui, Font, s12
Gui, Add, Text, xm Y+25, 2. Select a file to save the listing:
Gui, Font
Gui, Add, Button, gChooseListingButton, Listing File
Gui, Add, Edit, xs yp r1 vListingPath W300

Gui, Add, Checkbox, xm vIncludeDirectories, Include Directories in Listing (as opposed to files only)?

Gui, Font, s12
Gui, Add, Text, xm Y+25, 3. 
Gui, Add, Button, yp X+10 gGoButton, Go!

Menu, FileMenu, add, E&xit, GuiClose
Menu, HelpMenu, add, About, AboutDialog
Menu, MenuBar, Add, &File, :FileMenu
Menu, MenuBar, Add, &Help, :HelpMenu
Gui, Menu, MenuBar

Gui, Show, , Directory Listing Generator
return

GuiClose:
ExitApp

AboutDialog:
AboutText =
(
Directory Lister v%VERSION%

(c) 2015  jesse@humidmail.com
)
MsgBox,,About, %AboutText%
return

ChooseFolderButton:
GuiControlGet, folder,, FolderPath
If not folder
    folder=%userHome%
FileSelectFolder, folder, *%folder%, 0, Select a Folder to Create a Listing
If not ErrorLevel
    SetFolderPath(folder)
return

ChooseListingButton:
GuiControlGet, ListingPath
FileSelectFile, ListingPath, S, %ListingPath%, Choose a filename to save the listing, Text Files (*.txt)
If not ErrorLevel
    SetListingPath(ListingPath)
return

GoButton:
GuiControlGet, FolderPath
GuiControlGet, IncludeDirectories
GuiControlGet, ListingPath

if (not FolderPath OR not ListingPath)
{
    MsgBox, You need to select a Folder and a Listing file.
    return
}
fileList := ""
Loop, %FolderPath%\*.*, % (IncludeDirectories ? 1 : 0), 0
{
    fileList := fileList . A_LoopFileName . "`n"
}
Sort, fileList, D`n

IfExist, %ListingPath%, FileDelete, %ListingPath%
FileAppend, %fileList%, %ListingPath%
MsgBox, 0, Listing Saved, The file list was saved to `n`n     %listingPath%`n`n
return

GuiDropFiles:
Loop, parse, A_GuiEvent, `n
{
    FirstFile=%A_LoopField%
    break
}
FileGetAttrib, attributes, %FirstFile%
IfNotInString, attributes, D
{
    MsgBox, You can only drop directories, not files.
}
else
{
    SetFolderPath(FirstFile)
}
return


SetFolderPath(newPath)
{
    GuiControl,,FolderPath,%newPath%
    SplitPath, newPath, folderName  ; folderName contains just the base name of the path
    listingName := folderName . " - File List.txt"
    listingPath = %newPath%\%listingName%
    SetListingPath(listingPath)
}

SetListingPath(newPath)
{
    GuiControl,,ListingPath,%newPath%
}
