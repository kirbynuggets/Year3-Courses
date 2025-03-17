%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "struct.h"
int yylex();
int yyerror(char *s);
symbtbl *ptr;
%}
%union
{
    int numerorighe;
    char* Mystr;
}
%token <numerorighe> NL
%token <Mystr> IDENTIFIER CONST
%token <Mystr> LT GT EQ ASTERISK
%token SELECT FROM WHERE AND OR
%type <Mystr> identifiers cond compare op conn
%%
lines: line
    | lines line
    | lines error
    ;
line: select identifiers FROM identifiers WHERE cond NL {
    ptr = putsymb($2, $4, $7);
};
identifiers: ASTERISK {$$ = strdup("ALL");}
    | IDENTIFIER {$$ = $1;}
    | IDENTIFIER ',' identifiers {
        $$ = malloc(sizeof(char) * (strlen($1) + strlen($3) + 2));
        strcpy($$, $1);
        strcat($$, " ");
        strcat($$, $3);
    }
    ;
select: SELECT;
cond: IDENTIFIER op compare {
        $$ = malloc(sizeof(char) * (strlen($1) + strlen($2) + strlen($3) + 3));
        strcpy($$, $1);
        strcat($$, " ");
        strcat($$, $2);
        strcat($$, " ");
        strcat($$, $3);
    }
    | IDENTIFIER op compare conn cond {
        $$ = malloc(sizeof(char) * (strlen($1) + strlen($2) + strlen($3) + strlen($4) + strlen($5) + 5));
        strcpy($$, $1);
        strcat($$, " ");
        strcat($$, $2);
        strcat($$, " ");
        strcat($$, $3);
        strcat($$, " ");
        strcat($$, $4);
        strcat($$, " ");
        strcat($$, $5);
    }
    ;
compare: IDENTIFIER {$$ = $1;}
    | CONST {$$ = $1;}
    ;
op: LT {$$ = strdup("<");}
    | EQ {$$ = strdup("=");}
    | GT {$$ = strdup(">");}
    ;
conn: AND {$$ = strdup("AND");}
    | OR {$$ = strdup("OR");}
    ;
%%
int yyerror(char *s) {
    printf("  --ERROR--  %s\n\n", s);
    return 0;
}
int main() {
    FILE* del;
    char filename[] = "results.txt";
    del = fopen(filename, "a");
    fclose(del);
    remove(filename);
    yyparse();
    return 0;
}