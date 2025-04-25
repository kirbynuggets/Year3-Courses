%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token A B NEWLINE

%%
input:
    | input line
    ;

line:
    string NEWLINE { 
        printf("String accepted: L = {a^n b^m | n is not equal to m}\n"); 
    }
    ;

string:
    as bs { 
        if ($1 == $2) {
            yyerror("String not accepted: n = m");
            YYERROR;
        }
    }
    ;

as:
    /* empty */ { $$ = 0; }
    | as A      { $$ = $1 + 1; }
    ;

bs:
    /* empty */ { $$ = 0; }
    | bs B      { $$ = $1 + 1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}

