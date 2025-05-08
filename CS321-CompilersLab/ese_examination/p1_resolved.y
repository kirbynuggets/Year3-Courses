%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token IF ELSE LBRACE RBRACE SEMICOLON ID
%nonassoc IFX
%nonassoc ELSE

%%
program : stmt_list
        ;

stmt_list : stmt
          | stmt_list stmt
          ;

stmt : IF '(' ID ')' stmt %prec IFX        /* if statement without else */
     | IF '(' ID ')' stmt ELSE stmt        /* if statement with else */
     | LBRACE stmt_list RBRACE             /* block statement */
     | ID SEMICOLON                        /* simple statement */
     ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Grammar with resolved shift/reduce conflict\n");
    yyparse();
    return 0;
}