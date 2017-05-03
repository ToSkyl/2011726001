#!/bin/bash

echo "=== print file infomation ==="
echo "current directorty : `pwd` " #back quote를 사용해 명령어 pwd 실행
res1=`ls -l $PWD|wc -l` #시스템변수 PWD를 인자로 주어 현재 작업 디렉토리의 파일 수
echo "the number of element : `expr $res1 - 1 `" # 종합행으로 인해 -1 한 결과
i=1 #디렉토리 갯수및 파일번호 계산하기위한 변수
n=`ls -F|grep /$|sort|wc -l` #디렉토리 전체 수 저장 변수
while [ "$i" -le "$n" ] #디렉토리 수만큼 반복
do 
 	filename=`ls -F|grep /$| tr -d /|sort|sed -n "${i}p"` #디렉토리 이름 저장 변수
	echo "![$i] $filename" #이름 출력
 	echo "!-----------------------Information----------------------"
	echo -e "!\e[34mfile type : `stat -c %F $filename`\e[m" #파일 타입 및 색 변경
	echo "!file size : `stat -c %s $filename`" #크기 출력
	echo "!last time : `stat -c %z $filename`" # 마지막 변경 시간 출력
	echo "!permission : `stat -c %a $filename`" # 허가권 출력
	echo "!absolute path : `pwd`/$filename" #절대경로 출력
	echo "!relative path : ./$filename" # 상대경로 출력
	echo "---------------------------------------------------------"
	
	subNum=`ls -F $filename|wc -l` #서브디렉토리안의 파일 수 저장변수
	#서브 디렉토리 정보 읽기
	if [ "$subNum" -ne "0" ] #서브디렉토리안의 파일수 0인지 검사
		then
		subi=1 #서브디렉토리 갯수및 파일번호 계산하기위한 변수
		subn=`ls -F $filename|grep /$|sort|wc -l` #디렉토리 전체 수 저장 변수
		while [ "$subi" -le "$subn" ] #디렉토리 수만큼 반복
			do 
 			subfilename=`ls -F $filename|grep /$| tr -d /|sort|sed -n "${subi}p"` #서브디렉토리명 저장
			echo "	![$subi] $filename/$subfilename"
 			echo "	-----------------------Information----------------------"
			echo -e "	!\e[34mfile type : `stat -c %F $filename/$subfilename`\e[m"
			echo "	!file size : `stat -c %s $filename/$subfilename`"
			echo "	!last time : `stat -c %z $filename/$subfilename`"
			echo "	!permission : `stat -c %a $filename/$subfilename`"
			echo "	!absolute path : `pwd`/$filename/$subfilename"
			echo "	!relative path : ./$filename/$subfilename"
			echo "	---------------------------------------------------------"
			subi=`expr $subi + 1 ` #다음 디렉토리 및 파일 번호 증가
			done #서브디렉토리 반복 끝
		subj=1 # 일반 파일 수를 세기위한 변수
		subn2=`ls -F $filename|grep -v /$|grep -v @$|grep -v =$|grep -v \|$|sort|wc -l` #일반 파일 전체 수 저장
		while [ "$subj" -le "$subn2" ] #일반 파일 수만큼 반복
			do
			subfilename2=`ls -F $filename|grep -v /$|grep -v @$|grep -v =$|grep -v \|$|sort|tr -d \*|sed -n "${subj}p"` #일반 파일 이름 저장
			echo "	![$subi] $filename/$subfilename2"
 			echo "	!-----------------------Information----------------------"
			echo "	!file type : `stat -c %F $filename/$subfilename2`"
			echo "	!file size : `stat -c %s $filename/$subfilename2`"
			echo "	!last time : `stat -c %z $filename/$subfilename2`"
			echo "	!permission : `stat -c %a $filename/$subfilename2`"
			echo "	!absolute path : `pwd`/$filename/$subfilename2"
			echo "	!relative path : ./$filename/$subfilename2"
			echo "	---------------------------------------------------------"
			subi=`expr $subi + 1 ` # 파일 번호 +1
			subj=`expr $subj + 1 ` # 다음 일반 파일
			done #일반 파일 반복 끝
		subk=1 # 특수 파일 수를 세기위한 변수
		subn3=`ls -F $filename|grep [@=\|]$|sort|wc -l` #특수 파일 전체 수 저장
		while [ "$subk" -le "$subn3" ] #특 파일 수만큼 반복
			do
			subfilename3=`ls -F $filename|grep [@=\|]$|sort|tr -d @|tr -d =|tr -d \||sed -n "${subk}p"` #특수파일명 저장
			echo "	![$subi] /$filename/$subfilename3"
 			echo "	!-----------------------Information----------------------"
			echo -e "	!\e[32mfile type : `stat -c %F $filename/$subfilename3`\e[m"
			echo "	!file size : `stat -c %s $filename/$subfilename3`"
			echo "	!last time : `stat -c %z $filename/$subfilename3`"
			echo "	!permission : `stat -c %a $filename/$subfilename3`"
			echo "	!absolute path : `pwd`/$filename/$subfilename3"
			echo "	!relative path : ./$filename/$subfilename3"
			echo "	---------------------------------------------------------"
			subi=`expr $subi + 1 ` #파일 번호 증가
			subk=`expr $subk + 1 ` #다음 특수 파일 
			done #특수 파일 반복 끝
	fi #서브디렉토리 if
	i=`expr $i + 1 ` #다음 디렉토리 및 파일 번호 +1
done
j=1 #일반 파일 수를 세기위한 변수
n2=`ls -F|grep -v /$|grep -v @$|grep -v =$|grep -v \|$|sort|wc -l` # 전체 일반 파일수 저장 
while [ "$j" -le "$n2" ] #일반 파일 수만큼 반복 
do
	filename2=`ls -F|grep -v /$|grep -v @$|grep -v =$|grep -v \|$|sort|tr -d \*|sed -n "${j}p"` #일반 파일명 저장 
	echo "![$i] $filename2"
 	echo "!-----------------------Information----------------------"
	echo "!file type : `stat -c %F $filename2`"
	echo "!file size : `stat -c %s $filename2`"
	echo "!last time : `stat -c %z $filename2`"
	echo "!permission : `stat -c %a $filename2`"
	echo "!absolute path : `pwd`/$filename2"
	echo "!relative path : ./$filename2"
	echo "---------------------------------------------------------"
	i=`expr $i + 1 ` # 파일 번호 증가 
	j=`expr $j + 1 ` # 다음 일반 파일 
done #일반 파일 반복 
k=1 #특수 파일 수를 세기위한 변수
n3=`ls -F|grep [@=\|]$|sort|wc -l` # 전체 특수 파일수 저장 
while [ "$k" -le "$n3" ] #특수 파일 수만큼 반복
do
	filename3=`ls -F|grep [@=\|]$|sort|tr -d @|tr -d =|tr -d \||sed -n "${k}p"` #특수 파일명 저장 
	echo "![$i] $filename3"
 	echo "!-----------------------Information----------------------"
	echo -e "!\e[32mfile type : `stat -c %F $filename3`\e[m"
	echo "!file size : `stat -c %s $filename3`"
	echo "!last time : `stat -c %z $filename3`"
	echo "!permission : `stat -c %a $filename3`"
	echo "!absolute path : `pwd`/$filename3"
	echo "!relative path : ./$filename3"
	echo "---------------------------------------------------------"
	i=`expr $i + 1 ` # 파일 번호 증가 
	k=`expr $k + 1 ` # 다음 특수 파일 
done #특수 파일 반복
