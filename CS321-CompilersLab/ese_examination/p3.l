%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%%
"SELECT"        { return SELECT; }
"FROM"          { return FROM; }
"WHERE"         { return WHERE; }
"AND"           { return AND; }
"OR"            { return OR; }
">="            { return GEQ; }
"<="            { return LEQ; }
">"             { return GT; }
"<"             { return LT; }
"="             { return EQ; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"'"             { return QUOTE; }
"--"            { return COMMENT; }
";"             { return SEMICOLON; }
[a-zA-Z][a-zA-Z0-9_]*  { yylval.strval = strdup(yytext); return ID; }
[0-9]+(\.[0-9]+)?      { yylval.numval = atof(yytext); return NUMBER; }
[ \t\n]                { /* ignore whitespace */ }
.                      { return yytext[0]; }
%%

int yywrap() {
    return 1;
}