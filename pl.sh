#!/bin/bash

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
		echo "só passou o nome do arquivo"
		NOME_ARQUIVO=$1

		# registra no log impressão
		USUARIO_ATUAL="$USER"
		#TODO: CHECAR SE O USUARIO EXISTE NA LISTA DE USUARIOS.
		TAMANHO_ARQUIVO="$(wc -c "$NOME_ARQUIVO" | awk '{print $1}')"
		#TODO: CHECAR SE O USUARIO POSSUI AINDA POSSUI LIMITE PARA USAR.
		DATA="$(date +"%d %m %Y  %H:%M:%S")"
		echo "$USUARIO_ATUAL $NOME_ARQUIVO $TAMANHO_ARQUIVO $DATA" >> registros/log.txt
	else
		echo "passo o nome do arquivo e um parametro"
		NOME_ARQUIVO=$1
		PARAMETRO=$2
	fi
fi

echo "nome do arquivo: $NOME_ARQUIVO"
echo "parametro passado: $PARAMETRO"
###################################################################################################






############################tasks###############################################



#TODO: RETORNAR RELATORIO PARA O USUARIO QUANDO O PARAMETRO -f FOR PASSADO

#TODO: CHECAR SE OS ARQUIVOS AUXILIARES EXISTEM

#TODO: CRIAR CRONTAB PARA INICIAR OS USUARIOS COM UMA CONTA QUE ASSUME O VALOR MAX(0, CONSUMO - COTA)