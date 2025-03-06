%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(char* s);
%}

%%

// Grammar rules
expression: 
          | expression '(' expression ')'
          | expression '{' expression '}'
          | expression '[' expression ']'
          ;

%%

int main() {
    printf("Enter an expression with parentheses (Ctrl+D for result)");
    int parse_result = yyparse();
    if (parse_result == 0) {
        printf("Valid expression\n");
    } else {
        printf("Invalid expression\n");
    }
    return 0;
}

int yyerror(char* s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1; // Continue parsing after an error
}