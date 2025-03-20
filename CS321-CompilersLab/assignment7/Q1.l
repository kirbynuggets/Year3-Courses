%{
#include "y.tab.h"
#include <stdio.h>
extern YYSTYPE yylval;
%}

%%

"id" return id;

[ \t]   ;
\n      return 0;
.       return yytext[0];
%%

int yywrap() { return 1; }