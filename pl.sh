#!/bin/bash

cotaTotal='200'

#############################Funcoes3#############################################################

function checkUser {
users=`grep $USER registros/users.txt | wc -l`

if [ $users -eq 1 ] 
then
	echo "Usuario tem permissão"
else
	echo "Usuario nao pode imprimir nao tem permissão"
	exit 1
fi

}

function checkUserCota {
numeroLinhas=`cat registros/log.txt | grep $USER | wc -l`
cota=`cat registros/log.txt | grep $USER | awk '{sum+=$3} END {print sum}'`

if [ $numeroLinhas -eq 0 ] 
then
	echo "usuario ainda tem limite"
else 
	if [ $cota -lt $cotaTotal ] 
	then
		echo "Usuario ainda tem limite"
	else
		echo "Usuario nao possui mais limite"
		exit 1
	fi
fi

}


###################################################################################################



isInit=$(ls registros 2> /dev/null | wc -l)

if [ $isInit -ne 2 ]
then
	./createDependencies.sh
fi


############################### Recebe nome do arquivo e/ou parametros ###########################
LIMITE_PAGIMAS=30
if [ $# -eq 0 ] 
then
	echo "ZERO PARAMETROS"
else
	checkUser
	if [ $# -eq 1 ]
	then 
		if [ "$1" = "-f" ]
		then
			cat registros/log.txt
		else
			echo "só passou o nome do arquivo"
			NOME_ARQUIVO=$1
			##TODO: mudar arvore de busca de arquivo

			if [ `grep / <<< $NOME_ARQUIVO | wc -l` -gt 0 ]
			then 
				CAMINHO=$(dirname "${VAR}")
				ARQUIVO=$(basename "${VAR}")
				echo "maior que 1"
			else
				CAMINHO="./"
				ARQUIVO="$NOME_ARQUIVO"
				echo "menor"
			fi

			echo 
			# melhorar verificação
			if [ -f "$ARQUIVO" ]
			then
				# registra no log impressão
				USUARIO_ATUAL="$USER"
				if [ `wc -w registros/log.txt | awk '{ print $1 }'` -eq 0 ]
				then
					QNT_IMPRESSAO=0
				else	
					QNT_IMPRESSAO=$(grep "$USUARIO_ATUAL" registros/log.txt | awk '{sum+=$4} END { print sum }')
				fi

				echo "$QNT_IMPRESSAO"
				if [ $QNT_IMPRESSAO -gt 30 ]
				then
					echo "limite de paginas atingido"
				else
					TAMANHO_ARQUIVO=$(wc -c "$NOME_ARQUIVO" | awk '{print $1}')
					NUMERO_PAGINAS=$(expr $TAMANHO_ARQUIVO + 3600 - 1)
					NUMERO_PAGINAS=$(expr $NUMERO_PAGINAS / 3600)
					checkUserCota
					#TODO: CHECAR SE O USUARIO POSSUI AINDA POSSUI LIMITE PARA USAR.
					DATA=$(date +"%d/%m/%Y  %H:%M:%S")
					echo "$USUARIO_ATUAL $NOME_ARQUIVO $TAMANHO_ARQUIVO $NUMERO_PAGINAS $DATA" >> registros/log.txt
				fi
			else
				echo "arquivo inexistente"
			fi
		fi	
	else
		echo "Numero de parametros grande demais"
	fi
fi

echo "nome do arquivo: $NOME_ARQUIVO"
echo "parametro passado: $PARAMETRO"
###################################################################################################






############################tasks###############################################

#TODO: CRIAR CRONTAB PARA INICIAR OS USUARIOS COM UMA CONTA QUE ASSUME O VALOR MAX(0, CONSUMO - COTA)


########################################Funcoes###########################################################



