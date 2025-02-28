%{
#include "y.tab.h" // Including the Yacc-generated header file
#include <stdlib.h>
extern int yyerror(char* s); 
%}

%%

[a-zA-Z]+ { yylval.fval = 0; /* Placeholder value */ return NUMBER; } // Treating as vars for now, though they are a part of algebraic expressions; value = 0
[0-9]+(\.[0-9]+)?  { yylval.fval = atof(yytext); return NUMBER; } // Match floating-point numbers
[ \t\n]            ; // Ignore whitespace
"+"|"-"|"*"|"/"    { return yytext[0]; } // Handle operators
"("|")"|"{"|"}"|"["|"]" { return yytext[0]; } // Handle brackets
.                  { yyerror("Invalid character"); } // Handle invalid characters

%%

int yywrap() {
    return 1;
}