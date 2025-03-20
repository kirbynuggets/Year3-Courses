%{
#include "y.tab.h"  
%}

%%

"a"     { return 'a'; }
"b"     { return 'b'; }
"$"     { return '$'; }
[ \t\n] ; 
.       { printf("Invalid character '%s'\n", yytext); exit(1); }

%%

int yywrap() {
    return 1;
}