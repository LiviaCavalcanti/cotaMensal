#!/bin/bash
##Script criado para migrar o consumo exedentes para os proximos meses

#############################FUNCOES############################################
# cat registros/log.txt | awk '{sum+=$3} END {print sum}' 
# function analisaCotaExedente {
# users=`grep $USER registros/users.txt | wc -l`

# if [ $users -eq 1 ] 
# then
# 	echo "Usuario tem permissão"
# else
# 	echo "Usuario nao pode imprimir nao tem permissão"
# 	exit 1
# fi

# }



################################################################################
mesAtual=`date +%m`
mesAnterior=`expr $mesAtual - 1`
anoAtual=`date +%y`
nomeArquivo=`echo 'logs-'$mesAnterior-$anoAtual'.txt'`
cp registros/log.txt registros/$nomeArquivo
echo "" > registros/logtemp.txt

cota=200
quantidadeUsuario=`cat registros/users.txt | grep -v '^$' | wc -l`
for ((a=2; a <= quantidadeUsuario+1 ; a++))
do
	usuarioAtual=`cat registros/users.txt |head -n $a | tail -n -1`
	echo $usuarioAtual

	numeroLinhas=`cat registros/log.txt | grep $usuarioAtual | wc -l`


	if [ $numeroLinhas -eq 0 ] 
	then
		echo ""
	else 
		
		cotaUsuarioAtual=`cat registros/log.txt | grep -v '^$' | grep $usuarioAtual | awk '{sum+=$3} END {print sum}'`
		echo $cotaUsuarioAtual

		exedente=`expr $cotaUsuarioAtual - $cota`
		echo $exedente

		if [ $exedente -lt 0 ] 
		then
			echo $usuarioAtual" nao tem exedente"
		else
			DATA=$(date +"%d/%m/%Y  %H:%M:%S")
			echo "$usuarioAtual exedente.txt $exedente 0 $DATA" >> registros/logtemp.txt
		fi

		
	fi
done


rm -fr registros/log.txt

mv registros/logtemp.txt registros/log.txt


