#!/bin/bash

#TODO: CHECAR SE OS ARQUIVOS AUXILIARES EXISTEM /////////// tu não já fez?
isInit=$(ls registros 2> /dev/null | wc -l)

if [ $isInit -ne 2 ]
then
	./createDependencies.sh
fi


############################### Recebe nome do arquivo e/ou parametros ###########################
if [ $# -eq 0 ] 
then
	echo "ZERO PARAMETROS"
else
	##TODO: Criar script para verificar se o usuario pode imprimir
	if [ $# -eq 1 ]
	then 
		if [ "$1" = "-f" ]
		then
			cat registros/log.txt
		else
			echo "só passou o nome do arquivo"
			NOME_ARQUIVO=$1
			##TODO: mudar arvore de busca de arquivo
			if [ `find . -name "$NOME_ARQUIVO" | wc -l` -gt 0 ]
			then
				# registra no log impressão
				USUARIO_ATUAL="$USER"
				#TODO: CHECAR SE O USUARIO EXISTE NA LISTA DE USUARIOS.
				TAMANHO_ARQUIVO="$(wc -c "$NOME_ARQUIVO" | awk '{print $1}')"
				#TODO: CHECAR SE O USUARIO POSSUI AINDA POSSUI LIMITE PARA USAR.
				DATA="$(date +"%d %m %Y  %H:%M:%S")"
				echo "$USUARIO_ATUAL $NOME_ARQUIVO $TAMANHO_ARQUIVO $DATA" >> registros/log.txt
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