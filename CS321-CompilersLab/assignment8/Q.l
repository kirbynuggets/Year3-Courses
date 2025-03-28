%{
#include "parser.tab.h"
#include <string.h>
%}

%%

[ \t\n]+                /* ignore whitespace */

[Kk][Ii][Nn][Dd][Ll][Yy] { return KINDLY; }
[Ff][Ee][Tt][Cc][Hh]    { return FETCH; }
[Dd][Ii][Ss][Pp][Ll][Aa][Yy] { return DISPLAY; }
[Ee][Vv][Ee][Rr][Yy]   { return EVERY; }
[Dd][Ee][Tt][Aa][Ii][Ll][Ss] { return DETAILS; }
[Ff][Oo][Rr]         { return FOR; }
[Ss][Tt][Uu][Dd][Ee][Nn][Tt][Ss] { return STUDENTS; }
[Ll][Ii][Ss][Tt]      { return LIST; }
[Ww][Ii][Tt][Hh]     { return WITH; }
[Vv][Aa][Ll][Uu][Ee]  { return VALUE; }
[Hh][Ii][Gg][Hh][Ee][Rr] { return HIGHER; }
[Tt][Hh][Aa][Nn]     { return THAN; }
[Ll][Oo][Ww][Ee][Rr]  { return LOWER; }
[Ss][Aa][Mm][Ee]      { return SAME; }
[Aa][Ss]             { return AS; }
[Mm][Oo][Dd][Ii][Ff][Yy] { return MODIFY; }
[Cc][Hh][Aa][Nn][Gg][Ee] { return CHANGE; }
[Tt][Oo]             { return TO; }
[Cc][Aa][Ll][Ll][Ee][Dd] { return CALLED; }
[Rr][Oo][Ll][Ll]       { return ROLL; }
[Rr][Oo][Ll][Ll][Ss]   { return ROLLS; }
[Cc][Pp][Ii]          { return CPI; }
[Cc][Pp][Ii][Ss]      { return CPIS; }
[Nn][Aa][Mm][Ee][Ss]  { return NAMES; }
[Aa][Nn][Dd]         { return AND; }

[0-9]+(\.[0-9]+)?      { yylval.num = atof(yytext); return NUMBERVAL; }

.                      { /* ignore other characters */ }

%%

int yywrap() {
    return 1;
}