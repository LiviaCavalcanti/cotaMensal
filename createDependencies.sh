#!/bin/bash
##Script criado para criar/iniciar arquivos de configuração/logs/relatorios 

mkdir -p registros
cd registros
echo "" >> log.txt
echo "" >> registrosConsumo.txt
cd ..
./createFileUses.sh


#cron
echo "00 12 30 * * root ./migraConsumos.sh " >> /var/spool/cron/contrabs/root;
