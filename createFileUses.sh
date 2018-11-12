#!/bin/bash
##Script criado para adicionar os usuarios que podem imprimir


users=`ls /home`
echo "" > registros/users.txt
echo "$users" | awk '{print $1}' >> registros/users.txt

