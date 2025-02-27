%{
    /* Definition section */
    #include <stdio.h>
    #include <stdlib.h>

    int yylex();
    int yyerror(char* s);
%}

%token NUMBER ID

// Setting the precedence and associativity of operators
%left '+' '-'
%left '*' '/'

/* Rule Section */
%%
E : T {
        printf("Result = %d\n", $1);
        return 0;
    }
    ;

T : T '+' T { $$ = $1 + $3; }
  | T '-' T { $$ = $1 - $3; }
  | T '*' T { $$ = $1 * $3; }
  | T '/' T { $$ = $1 / $3; }
  | '-' NUMBER { $$ = -$2; }
  | '-' ID { $$ = -$2; }
  | '(' T ')' { $$ = $2; }
  | NUMBER { $$ = $1; }
  | ID { $$ = $1; }
  ;

%%

int main() {
    printf("Enter the expression\n");
    yyparse();
    return 0;
}

/* For printing error messages */
int yyerror(char* s) {
    printf("\nExpression is invalid: %s\n", s);
    return 1;
}