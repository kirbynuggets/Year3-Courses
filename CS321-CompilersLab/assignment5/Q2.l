%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%

[0-9]+    { printf("Shift: NUMBER %s\n", yytext); yylval.val = atoi(yytext); return NUMBER; }  
"+"       { printf("Shift: PLUS\n"); return PLUS; }
"-"       { printf("Shift: MINUS\n"); return MINUS; }
"*"       { printf("Shift: MULTIPLY\n"); return MULTIPLY; }
"/"       { printf("Shift: DIVIDE\n"); return DIVIDE; }
"("       { printf("Shift: LPAREN\n"); return LPAREN; }
")"       { printf("Shift: RPAREN\n"); return RPAREN; }
"id"      { printf("Shift: ID\n"); return ID; }
[ \t]+    ;  
\n        { return END; }
.         { printf("Invalid character: %s\n", yytext); exit(1); }

%%

int yywrap() {
    return 1;
}