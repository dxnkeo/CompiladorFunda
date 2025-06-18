%define parse.trace

%{
#include <iostream>
#include <string>
#include <map>
#include <memory>
#include "ast.hpp"

int yylex();
void yyerror(const char* s) {
    std::cerr << "Error FLAITEEE: " << s << std::endl;
}

std::map<std::string, int> variables;
std::map<std::string, std::string> string_vars;

std::map<std::string, bool> symbol_types;  // true = string, false = int


std::unique_ptr<ASTNode> root;
%}

%code requires {
  #include "ast.hpp"
}


%union {
    int ival;
    float fval;
    char* sval;
    ASTNode* node;
    StatementListNode* stmt_list;
    ExpressionNode* expr;
}

%token <ival> NUM_LITERAL
%token <sval> ID STRING_LITERAL


%token NUMETA SUELTA_LA_VOZ LA_URA EN_VOLA AL_TOKE ASSIGN SEMICOLON LPAREN RPAREN LBRACE RBRACE EQ PLUS MINUS MULT DIV // ERROR
%token NEQ LEQ GEQ LT GT
%token SAPEATE
%token PALABRITA


%type <node> statement
%type <stmt_list> statement_list
%type <expr> expression

%start program

%%

program:
    statement_list {
        root.reset($1);
        
    }
;

statement_list:
    statement_list statement {
        $1->add($2);
        $$ = $1;
    }
  | statement {
        $$ = new StatementListNode();
        $$->add($1);
    }
;

statement:
    NUMETA ID SEMICOLON {
    symbol_types[$2] = false;  // int
    $$ = new DeclarationNode($2);
    }

  | ID ASSIGN expression SEMICOLON {
        $$ = new AssignmentNode($1, $3);
    }

  | LA_URA LPAREN expression RPAREN LBRACE statement_list RBRACE EN_VOLA LBRACE statement_list RBRACE {
        $$ = new IfElseNode($3, $6, $10);
    }
  | AL_TOKE LPAREN expression RPAREN LBRACE statement_list RBRACE {
        $$ = new WhileNode($3, $6);
    }
    
  | SAPEATE LPAREN ID RPAREN SEMICOLON {
        $$ = new InputNode($3);
    }

  | PALABRITA ID SEMICOLON {
    symbol_types[$2] = true;  // string
    $$ = new DeclareStringNode($2);
    }

    
  | SUELTA_LA_VOZ LPAREN expression RPAREN SEMICOLON {
    $$ = new PrintNode($3);
    }


    // asignar string literal a variable
  | ID ASSIGN STRING_LITERAL SEMICOLON {
    $$ = new AssignStringNode($1, $3); // también lo implementas
    }

;

expression:
    expression PLUS expression { $$ = new BinaryOpNode("+", $1, $3); }
  | expression MINUS expression { $$ = new BinaryOpNode("-", $1, $3); }
  | expression MULT expression { $$ = new BinaryOpNode("*", $1, $3); }
  | expression DIV expression { $$ = new BinaryOpNode("/", $1, $3); }
  | expression EQ expression { $$ = new BinaryOpNode("==", $1, $3); }
  | NUM_LITERAL { $$ = new NumberNode($1); }
  | ID {
    if (symbol_types.count($1) && symbol_types[$1]) {
        $$ = new VariableNode($1, true);  // string
    } else {
        $$ = new VariableNode($1, false); // int
        }
    }


  | STRING_LITERAL {
        $$ = new StringNode($1);  // string literal directo
    }

  | expression NEQ expression { $$ = new BinaryOpNode("!=", $1, $3); }
  | expression LT expression  { $$ = new BinaryOpNode("<", $1, $3); }
  | expression LEQ expression { $$ = new BinaryOpNode("<=", $1, $3); }
  | expression GT expression  { $$ = new BinaryOpNode(">", $1, $3); }
  | expression GEQ expression { $$ = new BinaryOpNode(">=", $1, $3); }

;

%%