%{
#include <stdio.h>
#include "Question3_2201033.tab.h"
#include <string.h>
%}

%%
[0-9]+          { yylval.num = atof(yytext); return NUM; }
[0-9]+\.[0-9]+  { yylval.num = atof(yytext); return NUM; }
"regular"       { return REGULAR; }
"simple"        { return SIMPLE; }
"compound"      { return COMPOUND; }
"("             { return LPAREN; }
")"             { return RPAREN; }
","             { return COMMA; }
[ \t\n]         { /* skip whitespace */ }
.               { /* ignore any other characters */ }
%%

int yywrap() {
    return 1;
}
