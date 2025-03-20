%{
#include <string.h>
#include "y.tab.h"
%}

%%
[01]+\.[01]+      { yylval.str = strdup(yytext); return BINARY_FLOAT; }
[01]+             { yylval.str = strdup(yytext); return BINARY_INT; }
\n                { return EOL; }
.                 { return yytext[0]; }
%%

int yywrap() {
    return 1;
}