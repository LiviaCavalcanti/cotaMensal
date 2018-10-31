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
		nome_arquivo=$1

		##TODO: Criar script para registrar no log impressão

	else
		echo "passo o nome do arquivo e um parametro"
		nome_arquivo=$1
		parametro=$2
	fi
fi

echo "nome do arquivo: $nome_arquivo"
echo "parametro passado: $parametro"
###################################################################################################






############################tasks###############################################

#TODO: CHECAR SE O USUARIO EXITE NA LISTA DE USUARIOS.

#TODO: CHECAR SE O USUARIO POSSUI AINDA POSSUI LIMITE PARA USAR.

#TODO: RETORNAR RELATORIO PARA O USUARIO QUANDO O PARAMETRO -f FOR PASSADO

#TODO: CHECAR SE OS ARQUIVOS AUXILIARES EXISTEM

#TODO: CRIAR CRONTAB PARA INICIAR OS USUARIOS COM UMA CONTA QUE ASSUME O VALOR MAX(0, CONSUMO - COTA)