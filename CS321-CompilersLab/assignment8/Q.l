%{
#include <stdio.h>
#include <string.h>
#include "nlp.tab.h"

extern void yyerror(const char *s);
%}

%option noyywrap
%option case-insensitive

%%
"please"           { return PLEASE; }
"give"             { return GIVE; }
"show"             { return SHOW; }
"me"               { return ME; }
"all"              { return ALL; }
"information"      { return INFORMATION; }
"of"               { return OF; }
"the"              { return THE; }
"students"         { return STUDENTS; }
"name"             { return NAME; }
"roll"             { return ROLL; }
"cpi"              { return CPI; }
"who"              { return WHO; }
"having"           { return HAVING; }
"update"           { return UPDATE; }
"to"               { return TO; }
"is"               { return IS; }
"more"             { return MORE; }
"less"             { return LESS; }
"than"             { return THAN; }
"="                { yylval.str = strdup(yytext); return COMPARATOR; }
">"                { yylval.str = strdup(yytext); return COMPARATOR; }
"<"                { yylval.str = strdup(yytext); return COMPARATOR; }
[0-9]+             { yylval.num = atoi(yytext); return NUMBER; }
[ \t\n]            ; /* Ignore whitespace */
.                  { yyerror("Unexpected character"); }
%%