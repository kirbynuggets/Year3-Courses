%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
"if"        { return IF; }
"else"      { return ELSE; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return SEMICOLON; }
[a-zA-Z]+   { return ID; }
[ \t\n]     { /* ignore whitespace */ }
.           { /* ignore unknown characters */ }
%%

int yywrap() {
    return 1;
}