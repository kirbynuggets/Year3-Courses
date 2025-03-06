%{
#include "y.tab.h" // Including the Yacc-generated header file
#include <stdlib.h>
extern int yyerror(char* s); 
%}

%%

[ \t\n]            ; // Ignore whitespace
"("|")"|"{"|"}"|"["|"]" { return yytext[0]; } // Handle brackets
.                  { yyerror("Invalid character"); } // Handle invalid characters

%%

int yywrap() {
    return 1;
}