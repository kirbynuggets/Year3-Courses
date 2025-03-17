%{
#include "y.tab.h"
#include <stdlib.h>
extern int yylval;
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUM; }
"id"        { return ID; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIVIDE; }
"("         { return LPAREN; }
")"         { return RPAREN; }
[ \t\n]     ; // Ignore whitespace
.           { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}