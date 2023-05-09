set dd=%DATE:~0,2%
set mm=%DATE:~3,2%
set yyyy=%DATE:~6,4%
set HH=%time:~0,2%
set MM=%time:~3,2%
set CUR_DATE_TIME=%yyyy%-%mm%-%dd%_%HH%-%MM%

cd /d C:\Users\exch_adm\Мой диск\Drive_Sli\Site_2023
git add .
git commit  -m "%CUR_DATE_TIME%"
git push



timeout 15