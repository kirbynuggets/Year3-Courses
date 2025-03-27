%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%%

[Pp][Ll][Ee][Aa][Ss][Ee]    { return REQUEST; }
[Gg][Ii][Vv][Ee]            { return GIVE; }
[Ss][Hh][Oo][Ww]            { return SHOW; }
[Uu][Pp][Dd][Aa][Tt][Ee]     { return UPDATE; }
[Mm][Ee]                    { return ME; }
[Tt][Hh][Ee]                { return THE; }
[Aa][Ll][Ll]                { return ALL; }
[Ii][Nn][Ff][Oo][Rr][Mm][Aa][Tt][Ii][Oo][Nn] { return INFORMATION; }
[Rr][Oo][Ll][Nn][Uu][Mm][Bb][Ee][Rr][Ss] { return ROLLNUMBERS; }
[Rr][Oo][Ll][Nn][Uu][Mm][Bb][Ee][Rr] { return ROLLNUMBER; }
[Nn][Aa][Mm][Ee]            { return NAME; }
[Cc][Pp][Ii]                { return CPI; }
[Ss][Tt][Uu][Dd][Ee][Nn][Tt][Ss] { return STUDENTS; }
[Ss][Tt][Uu][Dd][Ee][Nn][Tt] { return STUDENT; }
[Ww][Hh][Oo][Ss][Ee]        { return WHOSE; }
[Hh][Aa][Vv][Ii][Nn][Gg]    { return HAVING; }
[Ww][Ii][Tt][Hh]            { return WITH; }
[Ii][Ss]                    { return IS; }
[Aa][Rr][Ee]                { return ARE; }
[Mm][Oo][Rr][Ee][Tt][Hh][Aa][Nn] { return MORETHAN; }
[Ll][Ee][Ss][Ss][Tt][Hh][Aa][Nn] { return LESSTHAN; }
[Ee][Qq][Uu][Aa][Ll][Tt][Oo] { return EQUALTO; }
[Nn][Oo]                    { return NO; }
[Aa][Nn][Dd]                { return AND; }
[Oo][Ff]                    { return OF; }
[0-9]+                      { yylval.num = atoi(yytext); return NUMBER; }
[.,]                        ;
[\n]                        { return 0; }
[ \t]                       ;
.                           { printf("Unknown token: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}