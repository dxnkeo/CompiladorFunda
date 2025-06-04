@echo off
bison -d parser.y
flex lexer.l
g++ -o compilador parser.tab.c lex.yy.c main.cpp

