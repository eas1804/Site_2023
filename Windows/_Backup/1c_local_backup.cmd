rem ������� ������� � ������� �����. ������ ��������� ��� ����������� �� ������� ����. ������� ������ ��������

@echo off
set DRIVE=C:
set FROM=\Base
set OUT=C:\Backup\Local_1c
set COUNT_FOLDER=12

	rem DRIVE= 	��� �����,������ ����� ������������
	rem FROM=	�������, ������� ����� ������������. ��� ����� �����
	rem OUT=	�������, � ������� ����� ������������
	rem COUNT_FOLDER	 ������� ��������� �������� 
	rem ---------------------Constanta------------------------------
taskkill /f /im 1c*
	rem ���������� ������� ���� � ���������� %CUR_DATE_TIME% set CUR_DATE_TIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%time:~0,2%-%time:~3,2%
set CUR_DATE_TIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%

	rem �������������� �������� �������
set OUT=%OUT%\%CUR_DATE_TIME%

	rem For viwe test
cls
echo DRIVE=%DRIVE%
echo FROM=%FROM%
echo OUT=%OUT%
echo -------------------------

	rem ���������� � �������
mkdir %OUT%
%DRIVE%
for /d %%X in (%FROM%\*) do "c:\Program Files\7-Zip\7z.exe" a -ssw -mx7 "%OUT%\%%X.7z" "%%X\"

	rem �������� %COUNT_FOLDER% ����� ������ ��������
cd /d %OUT%
dir /O-D /AD /B > files.txt
for /f "skip=%COUNT_FOLDER% delims=" %%G in (files.txt) do rmdir /q/s "%%G"

exit 0

