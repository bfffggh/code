@echo off
:DEMO
color 0a
cls
title TextEdit
set /p choice="[C(Create),E(Exit),O(Open),D(Delete),T(Trash),P(Copy)]: "
if %choice% == E exit 
if %choice% == C goto FILENAME
if %choice% == O goto Open
if %choice% == D goto Delete
if %choice% == T goto Trash
if %choice% == P goto Copy
goto MAIN
:FILENAME
cls
set /p fn="Filename: " 
cls
goto UI
:UI
cls
color 1F
echo :=================-     %fn%      -===========================:
if not exist %fn% (echo. >%fn%)
if exist %fn%.tmp (type %fn%.tmp) else (type %fn% >%fn%.tmp&attrib +s +h %fn%.tmp&type %fn%.tmp)
set /p uichoi="[S(Save),E(Exit),L(Write a line)]: "
if %uichoi% == E (goto exit)
if %uichoi% == L (goto line)
if %uichoi% == S (goto save2)
goto MAIN


:SAVE
TYPE %FN%.TMP >%FN%
DEL %FN%.TMP
GOTO DEMO



:exit
set /p exit="Exit without saving (Y/N): "
if %exit% == Y (attrib -s -h %fn%.tmp&del %fn%.tmp&goto DEMO)
if %exit% == N (goto UI)
goto MAIN
:line
cls
color 1F
echo :=================-     %fn%      -===========================:
if not exist %fn% (echo. >%fn%)
if exist %fn%.tmp (type %fn%.tmp) else (type %fn% >%fn%.tmp&attrib +s +h %fn%.tmp&type %fn%.tmp)
set /p line=""
echo %line% >> %fn%.tmp
goto UI


:save2
del %fn%
type %fn%.tmp >%fn%
attrib -s -h %fn%.tmp
del %fn%.tmp
goto DEMO

:Open
set /p fn="Filename: " 
cls
if exist %fn% (goto UI) else (goto DEMO)

:Delete
cls
echo This action will be REVERSIBLE, Deleted files will be moved to Trash. (You can delete files from trash)
set /p pathtrash="File: "
if not exist .\Trash\ (mkdir Trash)
if exist %pathtrash% (move %pathtrash% .\Trash\)
goto DEMO

:Trash
cd Trash
cls
echo In Trash:
echo.
dir /w /b
echo.
set /p do="[D(Delete Permanently),R(Restore),E(Exit)]: "
if %do% == D (goto remove)
if %do% == R (goto undelete)
if %do% == E (cd..&goto DEMO)

:undelete
cls
echo Restore File
set /p pathtrash="File: "
if exist %pathtrash% (move %pathtrash% ..\)
cd ..
goto Trash





:remove
cls
echo Are you sure?
set /p del="[Y/N]: "
if %del% == Y (del %file%)
if %del% == N (cd ..&goto Trash)

:Copy
cls
echo File:
set /p filecopy=""
cls
echo Destination (Path to file):
set /p dest=""
cls
copy %filecopy% %dest%
goto DEMO


