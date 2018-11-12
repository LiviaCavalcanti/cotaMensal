#!/bin/bash
##Script criado para criar/iniciar arquivos de configuração/logs/relatorios 

mkdir -p registros
cd registros
echo "" >> log.txt
echo "" >> registrosConsumo.txt
cd ..
./createFileUses.sh


#cron
echo "0 0 1 * * root ./migraConsumos.sh " >> cron.txt
crontab cron.txt
