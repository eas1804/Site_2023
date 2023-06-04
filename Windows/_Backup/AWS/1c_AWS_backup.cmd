@echo off
set DRIVE=C:
set FROM=\Base
set OUT=C:\Backup\AWS_1c
set COUNT_FOLDER=2

	rem DRIVE= 	имя диска,ОТКУДА будем архивировать
	rem FROM=	каталог, который будем архивировать. БЕЗ ИМЕНИ ДИСКА
	rem OUT=	каталог, в который будем архивировать
	rem COUNT_FOLDER	 сколько каталогов оставить 
	rem ---------------------Constanta------------------------------
taskkill /f /im 1c*
	rem Записываем текущую дату в переменную %CUR_DATE_TIME% set CUR_DATE_TIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%time:~0,2%-%time:~3,2%
set CUR_DATE_TIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%

	rem Переопределяем выходной каталог
set OUT=%OUT%\%CUR_DATE_TIME%

	rem For viwe test
cls
echo DRIVE=%DRIVE%
echo FROM=%FROM%
echo OUT=%OUT%
echo -------------------------

	rem Архивируем в каталог
mkdir %OUT%
%DRIVE%
for /d %%X in (%FROM%\*) do "c:\Program Files\7-Zip\7z.exe" a -ssw -mx7 "%OUT%\%%X.7z" "%%X\"

	rem оставить %COUNT_FOLDER% самых свежик каталога
cd /d %OUT%
dir /O-D /AD /B > files.txt
for /f "skip=%COUNT_FOLDER% delims=" %%G in (files.txt) do rmdir /q/s "%%G"



rem AWS s3
set BUCKET=bilonoga/1c/
aws s3 sync %OUT% s3://%BUCKET% --storage-class STANDARD_IA
aws s3 sync %OUT% s3://%BUCKET% --storage-class STANDARD_IA --delete


exit 0

