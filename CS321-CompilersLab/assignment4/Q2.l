%{
#include <stdio.h>
#include "y.tab.h"
#include <string.h>

/* For tracking tokens in debug output */
extern void record_token(char *token_name, char *lexeme);
%}

%%
[0-9]+      { 
              yylval.num = atoi(yytext); 
              record_token("NUMBER", yytext);
              return NUMBER; 
            }
"+"         { record_token("PLUS", yytext); return PLUS; }
"-"         { record_token("MINUS", yytext); return MINUS; }
"*"         { record_token("TIMES", yytext); return TIMES; }
"/"         { record_token("DIVIDE", yytext); return DIVIDE; }
"("         { record_token("LPAREN", yytext); return LPAREN; }
")"         { record_token("RPAREN", yytext); return RPAREN; }
[ \t]       ; /* Skip whitespace */
\n          { record_token("EOL", "\\n"); return EOL; }
.           { printf("Lexical error: Unknown character %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}