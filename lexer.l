%{
#include "parser.hpp"
#include <cstdlib>
#include <cstring>
#include <cstdio>
%}

%%

"numeta"            { return NUMETA; }
"tiene"             { return ASSIGN; }
"suelta_la_voz"     { return SUELTA_LA_VOZ; }
"la_ura"            { return LA_URA; }
"en_vola"           { return EN_VOLA; }
"al_toke"           { return AL_TOKE; }

"sapeate"           { return SAPEATE; }
"palabrita"         { return PALABRITA; }

"=="                { return EQ; }

"("                 { return LPAREN; }
")"                 { return RPAREN; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
";"                 { return SEMICOLON; }

"!="   { return NEQ; }
"<="   { return LEQ; }
">="   { return GEQ; }
"<"    { return LT; }
">"    { return GT; }

"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULT; }
"/"         { return DIV; }


\"[^\"]*\" {
    std::string raw(yytext);
    std::string stripped = raw.substr(1, raw.length() - 2);  // quita comillas
    yylval.sval = strdup(stripped.c_str());
    return STRING_LITERAL;
}

[0-9]+              { yylval.ival = atoi(yytext); return NUM_LITERAL; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.sval = strdup(yytext);
    return ID;
}

[ \t\r\n]+          ;
.                   { return ERROR; }

%%

int yywrap() {
    return 1;
}