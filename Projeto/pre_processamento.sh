#!/bin/bash 
#
# =======================================================
#  Script para gerar dados no formato utilizado pelo
#  classificador ID3. Esse codigo sera convertido
#  em haskell visto que processa mais de 33M linhas 
# =======================================================


OUTPUT_PATH="./"

> ${OUTPUT_PATH}/final_nomsisdn.csv
while read line
do
	DAY=$(echo $line | cut -d '_' -f2)
	CAMP_NAME=$(echo $line | sed -r 's/^[^_]*_[^_]*_(.*)_#.*$/\1/')
	VAR="$CAMP_NAME;$DAY"
	awk -v var=$VAR -F ',' '{print var","$6","$7}' $line  | sed 's/,99,/,0,/' | sed 's/,2,/,0,/' | sed 's/,3,/,0,/' | awk -F ',' '{ t[$1]+=1;d[$1]+=$2;a[$1]+=$3} END { for (i in t) print i","t[i]","d[i]","a[i] }' | awk -F ',' '{printf ("%s,%1d,%d\n",$1,($3+0.00001)/($2+0.00001)*100, ($4+0.00001)/($3+0.00001)*100)}' | awk -F ',' '{if ($3 < 2) accept = "baixo"; else if ( $3 >= 2 && $3 <= 3) accept = "normal"; else if ($3 > 3) accept = "alto"; if ($2 < 50) delivery = "baixo"; else if ($2 >= 50 && $2 <= 70) delivery = "normal"; else if ( $2 > 70) delivery = "alto" ; print $1","delivery","accept; }' | sed -r 's/(baixo,baixo)/\1,PESSIMO/' | sed -r 's/(baixo,normal)/\1,RUIM/' | sed -r 's/(baixo,alto)/\1,BOM/' | sed -r 's/(normal,baixo)/\1,RUIM/' | sed -r 's/(normal,normal)/\1,BOM/' | sed -r 's/(normal,alto)/\1,BOM/' | sed -r 's/(alto,baixo)/\1,PESSIMO/' | sed -r 's/(alto,normal)/\1,BOM/' | sed -r 's/(alto,alto)/\1,EXCELENTE/'  > ${OUTPUT_PATH}/${DAY}_${CAMP_NAME}_nomsisdn.csv

	cat ${OUTPUT_PATH}/${DAY}_${CAMP_NAME}_nomsisdn.csv | sed 's/;/,/g' >> ${OUTPUT_PATH}/final_nomsisdn.csv

done < lista

