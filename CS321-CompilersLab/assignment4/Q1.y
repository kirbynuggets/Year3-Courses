%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(char* s);
float final_result;

float divide(float a, float b) {
    if (b == 0.0) {
        yyerror("Error in expression: Division by zero");
        exit(1);
    }
    return a / b;
}
%}

%union {
    float fval;
}

%token <fval> NUMBER
%type <fval> expression term factor

%left '+' '-'
%left '*' '/'

%%

expression: term { $$ = $1; final_result = $$; }
          | expression '+' term { $$ = $1 + $3; final_result = $$; }
          | expression '-' term { $$ = $1 - $3; final_result = $$; }
          ;

term: factor { $$ = $1; }
    | term '*' factor { $$ = $1 * $3; }
    | term '/' factor { $$ = divide($1, $3); }
    ;

factor: NUMBER { $$ = $1; }
      | '(' expression ')' { $$ = $2; }
      | '{' expression '}' { $$ = $2; }
      | '[' expression ']' { $$ = $2; }
      ;

%%

int main() {
    printf("Enter the arithmetic expression (Ctrl+D for result):");
    int parse_result = yyparse();
    if (parse_result == 0) {
        printf("Final Result: %f\n", final_result);
    }
    return parse_result;
}

int yyerror(char* s) {
    if (strcmp(s, "syntax error") == 0) {
        printf("Invalid expression\n");
    } else {
        printf("%s\n", s);
    }
    exit(1);
    return 1;
}