@echo off
echo Limpiando archivos previos...
del parser.cpp parser.hpp lexer.cpp compilador.exe >nul 2>&1

echo Compilando parser y lexer...
bison -d -o parser.cpp parser.y
flex -o lexer.cpp lexer.l

echo Compilando el compilador...
g++ -o compilador parser.cpp lexer.cpp ast.cpp main.cpp
echo Compilación completada.
