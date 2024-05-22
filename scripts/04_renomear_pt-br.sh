#!/bin/bash

for arquivo in *; do
    mv "$arquivo" "$(echo "$arquivo" | sed 's/\.\([^.]*\)$/\[PT-BR\].\1/')"
done

