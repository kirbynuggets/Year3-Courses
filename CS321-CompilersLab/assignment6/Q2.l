%{
#include <string.h>
#include <ctype.h>
#include "y.tab.h"
%}

%%
"the"|"a"|"an"         { return ARTICLE; }
"boy"|"girl"|"man"|"woman"|"dog"|"cat"|"bird" { yylval.str = strdup(yytext); return COMMON_NOUN; }
[Ii]                   { yylval.str = strdup("I"); return PRONOUN; }
"he"|"she"|"you"|"we"|"they"|"it" { yylval.str = strdup(yytext); return PRONOUN; }
"runs"|"jumps"|"eats"|"flies"|"walks"|"reads" { yylval.str = strdup(yytext); return VERB; }
"run"|"jump"|"eat"|"fly"|"walk"|"read" { yylval.str = strdup(yytext); return VERB; }
"big"|"small"|"happy"|"sad"|"tall"|"short"|"clever" { yylval.str = strdup(yytext); return ADJECTIVE; }
"is"        { yylval.str = strdup(yytext); return IS; }
"am"        { yylval.str = strdup(yytext); return AM; }
"are"       { yylval.str = strdup(yytext); return ARE; }
"was"       { yylval.str = strdup(yytext); return WAS; }
"were"      { yylval.str = strdup(yytext); return WERE; }  
"."         { return PERIOD; }
[ \t\n]+    ;  /* Ignore whitespace and newlines */
.           { printf("Invalid token: %s\n", yytext); return 0; }
%%

int yywrap(){ 
    return 1; 
}