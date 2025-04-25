%{
#include <stdio.h>
#include "Question1_2201033.tab.h"
%}

%%
"if"        { return IF; }
"else"      { return ELSE; }
"then"      { return THEN; }
[a-zA-Z]+   { return ID; }
[ \t\n]     { /* ignore whitespace */ }
.           { return yytext[0]; }
%%

int yywrap() {
    return 1;
}