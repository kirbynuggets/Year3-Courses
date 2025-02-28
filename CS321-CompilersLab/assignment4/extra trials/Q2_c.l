%{
#include "y.tab.h"
#include <stdlib.h>
extern int yylval;
extern void yyerror(char* s);
%}

%%

"a"         { return 'a'; }
"b"         { return 'b'; }
[ \t\n]     ; // Ignore whitespace
"$"         { return '$'; } // End of input marker
.           { yyerror("Invalid character"); }

%%

int yywrap() {
    return 1;
}