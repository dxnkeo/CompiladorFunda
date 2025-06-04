#include <iostream>
extern int yyparse();

int main() {
    std::cout << "Compilador flaite activo \n";
    yyparse();
    return 0;
}
