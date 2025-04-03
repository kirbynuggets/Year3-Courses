%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
%}

%%
[ \t\n]         ; // Ignore whitespace
"int"           { return INT; }
"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }
"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }
"<"             { return LT; }
">"             { return GT; }
"%"             { return MOD; }  
[a-zA-Z][a-zA-Z0-9]* { 
    yylval.str = strdup(yytext); 
    return ID; 
}
[0-9]+          { 
    yylval.num = atoi(yytext); 
    return NUM; 
}
[-+*/=();{}]    { return yytext[0]; }
.               { printf("Invalid character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}