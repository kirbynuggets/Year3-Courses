%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%

[a-z]+          { printf("Token : STRING; Lexeme : %s\n", yytext); }
"Reverse"       { printf("Token : REVERSE; Lexeme : %s\n", yytext); }
"#"             { printf("Token and Lexeme : #\n"); }
"("             { printf("Token and Lexeme : (\n"); }
")"             { printf("Token and Lexeme : )\n"); }
[ \t]+          { /* Ignore whitespace */ }
"\n"            { printf("Token and Lexeme : <newline>\n"); }
.               { fprintf(stderr, "Error: Unrecognized character: %s\n", yytext); exit(1); } // Error handling

%%

int main() {
    yylex();
    return 0;
}