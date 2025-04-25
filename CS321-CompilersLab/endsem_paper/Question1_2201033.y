%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token IF ELSE THEN ID

%%

program:
    statement   { printf("Valid statement parsed successfully!\n"); }
    ;

statement:
    IF expression THEN statement                    
    | IF expression THEN statement ELSE statement   
    | expression                                   
    ;

expression:
    ID                                             
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Parsing with shift/reduce conflicts...\n");
    printf("Enter a statement (e.g., 'if id then if id then id else id'):\n");
    yyparse();
    return 0;
}