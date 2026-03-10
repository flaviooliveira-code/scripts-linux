#!/usr/bin/env bash
# Atualizado para 2026-03

set -euo pipefail

mkdir -p txt
for file in *.pdf; do
  [[ -e "$file" ]] || continue
  pdftotext "$file" "txt/$file.txt"
done

cd txt
mkdir -p filtrado
for file in *.txt; do
  [[ -e "$file" ]] || continue
  cut -d: -f1,2,3 "$file" \
    | egrep -i "Nome:|Endereço:|CEP:|Cidade:|E-mail:|Telefone:" \
    > "filtrado/$file.txt"
done

cd filtrado
mkdir -p filtrado2
for file in *.txt; do
  [[ -e "$file" ]] || continue
  cut -d: -f1,2,3 "$file" | tr '\n' ' ' > "filtrado2/$file.txt"
done

cd filtrado2
sed -n p ./*.txt > dados.csv

echo "Finalizado!!!"
