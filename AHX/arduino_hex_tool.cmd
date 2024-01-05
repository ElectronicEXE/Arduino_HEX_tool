@echo off
echo          ############################################################
echo          ###  CODE BY @Electronic_EXE  aka  Furdui Bogdan Andrei  ###
echo          ############################################################
echo.
echo version: 3.0
echo.
echo.
echo.
echo #############################################################################
echo.
echo.
echo.
echo _____________________avrdude memory reader/writer/verifyer for arduino________________
echo.
echo.
echo.
pause

setlocal enabledelayedexpansion
set count=0
set folders=normal-upload/download/veryfing arduino-as-isp 

for %%0 in (%folders%) do (
    set /a count=count+1
    set choice[!count!]=%%0
)

echo.
echo select upload/download/veryfing type:
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

echo _______________________________com port list_________________________________
echo #############################################################################
setlocal enabledelayedexpansion 
echo.
for /f "tokens=2delims=COM:" %%i in ('mode ^| findstr /RC:"\C\O\M[0-9*]"') do set "_com=%%i" & echo/ COM!_com! 
echo.
echo.
echo.
echo _________________________________set com port________________________________
echo #############################################################################
echo.
set /p input=
echo.
echo com port is: %input%
echo.
echo.
echo.
echo ____________________________set microcontroller architecture___________________________
echo #############################################################################
echo.
set count1=0
set foldersss=atmega328p/ARDUINO_UNO/NANO m2560/ARDUINO_MEGA else

for %%0 in (%foldersss%) do (
    set /a count1=count1+1
    set choiceee[!count1!]=%%0
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
echo selected microcontroller architecture : %choseee%
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
    echo and attempt to auto detect the chip and print it to the terminal. 
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

for %%0 in (%foldersss%) do (
    set /a count1=count1+1
    set choiceee[!count1!]=%%0
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
echo ______________________________set file name for .hex file___________________
echo ##############################################################################
echo.
set /p input2=
echo.
echo file name for .hex file is: %input2%
echo.
echo.
echo.
setlocal enabledelayedexpansion

set count=0
set folderss=write read verify

for %%0 in (%folderss%) do (
    set /a count=count+1
    set choicee[!count!]=%%0
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
echo selected mode is : %chosee%

if %chosee% == 3 (
set input3=v
)

if %chosee% == 2 (
set input3=r
)

if %chosee% == 1 (
set input3=w
)
echo ##############################################################################
echo.
echo comand to be executed:
echo avrdude -p %chip% %cvar% %bvar% -P %input% -U %mode%:%input3%:%input2%.hex:i
echo.
echo.
pause
avrdude -p %chip% %cvar% %bvar% -P %input% -U %mode%:%input3%:%input2%.hex:i
echo.
echo.
echo.
echo ###############################################################################
echo.
echo.
echo.
echo.
echo.
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                              OPERATION COMPLETEED
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
pause 