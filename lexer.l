%{
#include "parser.hpp"
#include <cstdlib>
#include <cstring>
using namespace std;
%}

%%

"numeta"            { return NUMETA; }
"decima"            { return DECIMA; }
"palabrita"         { return PALABRITA; }

"la_ura"            { return LA_URA; }
"en_vola"           { return EN_VOLA; }
"al_toke"           { return AL_TOKE; }

"sapeate"           { return SAPEATE; }
"suelta_la_voz"     { return SUELTA_LA_VOZ; }

"tiene"             { return ASSIGN; }
"iwal_que"          { return EQ; }
"ni_cerca"          { return NEQ; }

"<="                { return LEQ; }
">="                { return GEQ; }
"<"                 { return LT; }
">"                 { return GT; }

"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MULT; }
"/"                 { return DIV; }

";"                 { return SEMICOLON; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }

[0-9]+\.[0-9]+       { yylval.fval = atof(yytext); return DECIMAL_LITERAL; }
[0-9]+               { yylval.ival = atoi(yytext); return NUM_LITERAL; }
\"[^\"]*\"           { yylval.sval = strdup(yytext + 1); yytext[yyleng - 1] = 0; return STRING_LITERAL; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.sval = strdup(yytext);
    return ID;
}

[ \t\r\n]+           ;

.                    { printf("Caracter desconocido: %s\n", yytext); return ERROR; }

%%

int yywrap() {
    return 1;
}