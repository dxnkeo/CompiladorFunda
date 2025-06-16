#include <iostream>
#include <memory>
#include "ast.hpp"

// Declaración externa del parser
extern int yyparse();
extern std::unique_ptr<ASTNode> root; // <-- asegúrate de que esté declarado como en parser.y

// extern int yydebug;  // ACTIVA LAS TRAZAS DE BISON

int main() {
    std::cout << "Compilador flaite activo\n" << std::endl;
   // yydebug = 1;  // Esta línea activa el modo verbose

    if (yyparse() == 0) {  // 0 significa que el parsing fue exitoso
        if (root) {
            root->evaluate(); // Ejecuta el árbol
        } else {
            std::cerr << "[ERROR] El AST está vacío.\n";
        }
    } else {
        std::cerr << "[ERROR] Falló el análisis sintáctico.\n";
    }

    return 0;
}
