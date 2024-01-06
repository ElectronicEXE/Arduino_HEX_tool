@echo off
echo ############################################################
echo ###  CODE BY @Electronic_EXE  aka  Furdui Bogdan Andrei  ###
echo ############################################################
echo.
echo version: 3.2
echo.
echo.
echo.
echo #############################################################################
echo.
echo.
echo.
echo _____________________avrdude memory reader/writer/verifier for Arduino________________
echo.
echo.
echo.
pause

setlocal enabledelayedexpansion
set count=0
set folders=normal-upload/download/verifying arduino-as-isp 

for %%i in (%folders%) do (
    set /a count=count+1
    set choice[!count!]=%%i
)

echo.
echo select upload/download/verifying type:
echo.

for /l %%x in (1,1,!count!) do (
    echo [%%x] !choice[%%x]!
)
echo.

set /p chose= 
echo.

echo You chose !choice[%chose%]!
set folder=!choice[%chose%]!

if %chose% == 1 (
    set cvar=-c arduino
    set bvar=
) 

if %chose% == 2 (
    set cvar=-c avrisp
    set bvar=-b 19200
) 

echo _______________________________serial port list_________________________________
echo #############################################################################
setlocal enabledelayedexpansion 
echo.
for /f "tokens=2 delims=COM:" %%i in ('mode ^| findstr /RC:"\C\O\M[0-9*]"') do set "_com=%%i" & echo/ COM!_com! 
echo.
echo.
echo.
echo _________________________________set serial port________________________________
echo #############################################################################
echo.
set /p input=
echo.
echo serial port is: %input%
echo.
echo.
echo.
echo ____________________________set microcontroller architecture___________________________
echo #############################################################################
echo.
set count1=0
set foldersss=atmega328p/ARDUINO_UNO/NANO m2560/ARDUINO_MEGA else

for %%i in (%foldersss%) do (
    set /a count1=count1+1
    set choiceee[!count1!]=%%i
)

echo.
echo select option:
echo.

for /l %%x in (1,1,!count1!) do (
    echo [%%x] !choiceee[%%x]!
)
echo.

set /p choseee= 
echo.

echo You chose !choiceee[%choseee%]!
set folderrr=!choiceee[%choseee%]!

echo.
echo.
echo selected microcontroller architecture: %choseee%
if %choseee% == 1 (
    set chip=atmega328p
)

if %choseee% == 2 (
    set chip=m2560
)

if %choseee% == 3 (
    echo.
    echo #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
    echo Please write the name of the microcontroller for avrdude to use.
    echo #-----------------------------------------------------------------------------------------#
    echo If not known, continue with atmega328p. If it is not correct, avrdude will throw an error 
    echo and attempt to auto-detect the chip and print it to the terminal. 
    echo Write the chip down and run the program again and set the right chip.
    echo #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
    echo.
    echo.
    set /p "input4=Enter the microcontroller name: "
    for /f "delims=" %%A in ("!input4!") do set "input4=%%A"
    echo.
    echo selected microcontroller architecture: !input4!
    set chip=!input4!
)
echo.
echo.
echo.
echo _________________________________set operation type________________________________
echo #############################################################################
echo.
set count1=0
set foldersss=FLASH/Normal_Sketch_Memory EEPROM/non-volatile/electrically_erasable_programmable_read-only_memory

for %%i in (%foldersss%) do (
    set /a count1=count1+1
    set choiceee[!count1!]=%%i
)

echo.
echo select option:
echo.

for /l %%x in (1,1,!count1!) do (
    echo [%%x] !choiceee[%%x]!
)
echo.

set /p choseee= 
echo.

echo You chose !choiceee[%choseee%]!
set folderrr=!choiceee[%choseee%]!
if %choseee% == 1 (
    set mode=flash
)

if %choseee% == 2 (
    set mode=eeprom
)
echo.
echo.
echo.
echo.
echo.
echo ______________________________output file type___________________
echo ##############################################################################
echo.
echo.
set count=0
set folderss=.bin .hex

for %%i in (%folderss%) do (
    set /a count=count+1
    set choicee[!count!]=%%i
)

echo.
echo select option:
echo.

for /l %%x in (1,1,!count!) do (
    echo [%%x] !choicee[%%x]!
)
echo.

set /p chosee= 
echo.

echo You chose !choicee[%chosee%]!
set folderr=!choicee[%chosee%]!

echo.
echo.
echo.
echo file type is: %chosee%
if %chosee% == 1 (
    set type=bin
)

if %chosee% == 3 (
    set type=hex
)
echo.
echo.
echo.

echo ______________________________set file name for .%type% file___________________
echo ##############################################################################
echo.
echo Please place your writing binaries on Desktop if you want to flash them.
set /p input2=
echo.
echo file name for .%type% file is: %input2%
echo.
echo.
echo.
setlocal enabledelayedexpansion

set count=0
set folderss=write read verify

for %%i in (%folderss%) do (
    set /a count=count+1
    set choicee[!count!]=%%i
)

echo.
echo select option:
echo.

for /l %%x in (1,1,!count!) do (
    echo [%%x] !choicee[%%x]!
)
echo.

set /p chosee= 
echo.

echo You chose !choicee[%chosee%]!
set folderr=!choicee[%chosee%]!

echo.
echo.
echo selected mode is: %chosee%

if %chosee% == 3 (
    set input3=v
)

if %chosee% == 2 (
    set input3=r
)

if %chosee% == 1 (
    set input3=w
    xcopy %USERPROFILE%\Desktop\%input2%.%type% %~dp0
)
echo ##############################################################################
echo.
echo command to be executed:
echo avrdude -p %chip% %cvar% %bvar% -P %input% -U %mode%:%input3%:%input2%.%type%:i
echo.
echo.
pause
avrdude -p %chip% %cvar% %bvar% -P %input% -U %mode%:%input3%:%input2%.%type%:i
xcopy %input2%.%type% %USERPROFILE%\Desktop
echo.
echo.
echo.
echo ###############################################################################
echo.
echo.
echo File saved on Desktop.
echo.
echo.
echo.
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                              OPERATION COMPLETED
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
pause
