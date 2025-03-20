%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
int yyparse();
%}


%union {
    int val;
}

%token <val> NUMBER
%token PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN END
%token ID

%type <val> expr term factor
%type <val> grammar_expr grammar_term grammar_factor

%%

input:
    expr END { printf("Valid and result: %d\n", $1); }
    | grammar_expr END { printf("Valid grammar expression.\n"); }
    ;

expr: term               { $$ = $1; }
    | expr PLUS term     { printf("Reduce: %d + %d = %d\n", $1, $3, $1 + $3); $$ = $1 + $3; }
    | expr MINUS term    { printf("Reduce: %d - %d = %d\n", $1, $3, $1 - $3); $$ = $1 - $3; }
    ;

term: factor             
    | term MULTIPLY factor { printf("Reduce: %d * %d = %d\n", $1, $3, $1 * $3); $$ = $1 * $3; }
    | term DIVIDE factor 
        {
            if ($3 == 0) {
                printf("Error: Division by zero\n");
                exit(1);
            }
            printf("Reduce: %d / %d = %d\n", $1, $3, $1 / $3);
            $$ = $1 / $3;
        }
    ;

factor: NUMBER       { $$ = $1; }
      | MINUS factor { printf("Reduce: Unary -%d\n", $2); $$ = -$2; }
      | LPAREN expr RPAREN { $$ = $2; }
      ;

/* Handling Grammar Expression */
grammar_expr:
    grammar_term 
    | grammar_expr PLUS grammar_term { printf("Reduce: ID + ID\n"); }
    | grammar_expr MINUS grammar_term { printf("Reduce: ID - ID\n"); }
    ;

grammar_term:
    grammar_factor
    | grammar_term MULTIPLY grammar_factor { printf("Reduce: ID * ID\n"); }
    | grammar_term DIVIDE grammar_factor { printf("Reduce: ID / ID\n"); }
    ;

grammar_factor:
    ID { printf("Reduce: ID\n"); }
    | LPAREN grammar_expr RPAREN { printf("Reduce: ( ID )\n"); }
    ;

%%


int main() {
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
} 