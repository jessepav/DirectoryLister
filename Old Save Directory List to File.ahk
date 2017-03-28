;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Jesse Pavel <jpavel@alum.mit.edu>
;

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

EnvGet, userHome, HOMEPATH

FileSelectFolder, folder, %userHome%, 0, Select a Folder to Create a Listing
If ErrorLevel
    Exit, 1

fileList := ""
Loop, %folder%\*.*, 0, 0
{
    fileList := fileList . A_LoopFileName . "`n"
}

Sort, fileList, D`n
SplitPath, folder, folderName  ; folderName contains just the base name of the path
listingName := folderName . " - File List.txt"
listingPath = %folder%\%listingName%

FileSelectFile, listingPath, S, %listingPath%, Choose a filename to save the listing, Text Files (*.txt)
If ErrorLevel
    Exit, 1

IfExist, %listingPath%, FileDelete, %listingPath%
FileAppend, %fileList%, %listingPath%
MsgBox, 0, Listing Saved, The file list was saved to `n`n     %listingPath%`n`n

Exit, 0
