@echo off
		rem Исходные данные
set DRIVE=D:
set FROM=\Bace_1c
set OUT=F:\Backup\FOR_AWS
set S3_OUT="s3://unac.1c/2023/"
set COUNT_FOLDER=2
	rem DRIVE=D: - имя диска,ОТКУДА будем архивировать
	rem FROM=\Bace_1c - каталог, который будем архивировать. БЕЗ ИМЕНИ ДИСКА
	rem OUT=F:\Backup\FOR_AWS - каталог, в который будем архивировать
	rem S3_OUT - имя AWS bucket
	rem COUNT_FOLDER=2 сколько каталогов оставить 

rem ---------------------Constanta------------------------------

taskkill /f /im 1c*

	rem Записываем текущую дату в переменную %CUR_DATE_TIME% set CUR_DATE_TIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%time:~0,2%-%time:~3,2%
set CUR_DATE_TIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%

	rem Переопределяем выходной каталог
set OUT_ORGN=%OUT%
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
cd /d %OUT_ORGN%
dir /O-D /AD /B > files.txt
for /f "skip=%COUNT_FOLDER% delims=" %%G in (files.txt) do rmdir /q/s "%%G"
del  files.txt


	rem Синхронизация с AWS

"C:\Program Files\Amazon\AWSCLIV2\aws" s3 sync %OUT%  %S3_OUT% --storage-class GLACIER 
"C:\Program Files\Amazon\AWSCLIV2\aws" s3 sync %OUT%  %S3_OUT% --storage-class GLACIER --delete


exit 0

