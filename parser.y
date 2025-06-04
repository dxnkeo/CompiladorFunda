%{
#include <iostream>
#include <string>
#include <map>
#include <cstdlib>
using namespace std;

int yylex();
void yyerror(const char* s);

// Mapa para almacenar variables
map<string, int> variables;
%}

%union {
    int ival;
    float fval;
    char* sval;
}

%token <ival> NUM_LITERAL
%token <fval> DECIMAL_LITERAL
%token <sval> STRING_LITERAL ID

// Palabras clave
%token NUMETA DECIMA PALABRITA
%token LA_URA EN_VOLA AL_TOKE
%token SAPEATE SUELTA_LA_VOZ

// Operadores
%token EQ NEQ LEQ GEQ LT GT
%token PLUS MINUS MULT DIV
%token ASSIGN
%token SEMICOLON LBRACE RBRACE LPAREN RPAREN
%token ERROR

%type <ival> expression
%type <ival> statement
%type <ival> statement_list

%start program

%%

program:
    statement_list
;

statement_list:
    statement_list statement
  | statement
;

statement:
    NUMETA ID SEMICOLON
        { variables[$2] = 0; }

  | ID ASSIGN expression SEMICOLON
        { variables[$1] = $3; }

  | SUELTA_LA_VOZ LPAREN expression RPAREN SEMICOLON
        { cout << $3 << endl; }

  | SAPEATE LPAREN ID RPAREN SEMICOLON
        {
            cout << "Ingresa valor para " << $3 << ": ";
            cin >> variables[$3];
        }

  // IF sin else
  | LA_URA LPAREN expression RPAREN LBRACE statement_list RBRACE
        {
            if ($3) {
                // ejecutar bloque if
            }
        }

  // IF con else
  | LA_URA LPAREN expression RPAREN LBRACE statement_list RBRACE EN_VOLA LBRACE statement_list RBRACE
        {
            if ($3) {
                // solo bloque if
            } else {
                // solo bloque else
            }
        }

  // WHILE loop
  | AL_TOKE LPAREN expression RPAREN LBRACE statement_list RBRACE
        {
            while ($3) {
                // bucle ejecuta instrucciones internas
            }
        }
;

expression:
    expression PLUS expression        { $$ = $1 + $3; }
  | expression MINUS expression       { $$ = $1 - $3; }
  | expression MULT expression        { $$ = $1 * $3; }
  | expression DIV expression         { $$ = $1 / $3; }
  | expression EQ expression          { $$ = $1 == $3; }
  | expression NEQ expression         { $$ = $1 != $3; }
  | expression LT expression          { $$ = $1 < $3; }
  | expression LEQ expression         { $$ = $1 <= $3; }
  | expression GT expression          { $$ = $1 > $3; }
  | expression GEQ expression         { $$ = $1 >= $3; }
  | NUM_LITERAL                       { $$ = $1; }
  | ID                                { $$ = variables[$1]; }
;

%%

void yyerror(const char *s) {
    cerr << "Error flaite: " << s << endl;
}