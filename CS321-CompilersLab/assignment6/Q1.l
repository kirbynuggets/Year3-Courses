%{
#include <stdio.h>
#include <string.h>
#include "struct.h"
#include "y.tab.h"

extern YYSTYPE yylval;
int line_num = 1;
%}

%%
[ \t]+                      { /* ignore whitespace */ }
[0-9]+                      { yylval.Mystr = strdup(yytext); return CONST; }
[0-9]+\.[0-9]+              { yylval.Mystr = strdup(yytext); return CONST; }
\"[^\"]*\"                  { yylval.Mystr = strdup(yytext); return CONST; }
\'[^\']*\'                  { yylval.Mystr = strdup(yytext); return CONST; }
SELECT|select               { return SELECT; }
FROM|from                   { return FROM; }
WHERE|where                 { return WHERE; }
AND|and                     { return AND; }
OR|or                       { return OR; }
"<"                         { return LT; }
">"                         { return GT; }
"="                         { return EQ; }
"*"                         { return ASTERISK; }
","                         { return ','; }
[a-zA-Z][a-zA-Z0-9_]*       { yylval.Mystr = strdup(yytext); return IDENTIFIER; }
\n                          { yylval.numerorighe = line_num++; return NL; }
;                           { /* ignore semicolons */ }
.                           { /* ignore other characters */ }
%%

int yywrap() {
    return 1;
}