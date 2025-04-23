%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token A B C D

%%
S : A_STAR X D_STAR
  ;

A_STAR : /* empty */
       | A_STAR A
       ;

D_STAR : /* empty */
       | D D_STAR
       ;

X : /* empty */
  | B X C
  ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter a string over {a,b,c,d}: ");
    if (yyparse() == 0)
        printf("String is in the language L = {a^m b^n c^n d^m | n, m >= 0}\n");
    else
        printf("String is not in the language\n");
    return 0;
}