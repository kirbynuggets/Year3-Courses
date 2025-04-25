%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex();
void yyerror(const char *s);
%}

%union {
    double num;
}

%token <num> NUM
%token REGULAR SIMPLE COMPOUND LPAREN RPAREN COMMA
%type <num> E

%%
S: E { printf("%.10f\n", $1); }
  ;

E: /* epsilon */ { $$ = 0; }
  | REGULAR LPAREN E COMMA E RPAREN { 
        $$ = $3 + ($3 * 2.01)/100 * $5; 
    }
  | SIMPLE LPAREN E COMMA E RPAREN { 
        $$ = $3 + ($3 * 5.5 * $5)/100; 
    }
  | COMPOUND LPAREN E COMMA E RPAREN { 
        $$ = $3 * (pow((1 + 5.7/$5), $5)); 
    }
  | NUM { $$ = $1; }
  ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}