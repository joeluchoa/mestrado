#!/bin/bash

origem=source/*.dot
destino=img/
extensao=pdf
#extensao pode ser pdf, png, ...

for file in $origem ;
do
	nome=$(echo $file | cut -f2 -d'/') #remove '/' do nome do arquivo
	nome=$(echo ${nome%.*t}) #remove extensao '.dot'
	dot $file -T$extensao -o$destino$nome.$extensao #gera o arquivo com extensao desejada
done
