
%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int noprt = 0, nopnd = 0, valid = 1, top = -1, l = 0, j = 0;
char opnd[10][10], oprt[10][10], a[100];
int expect_operand = 1; 

void push(char c) {
    a[++top] = c;
}

char pop() {
    return a[top--];
}
%}

%x NEGATIVE

%%
"(" { push('('); }
"{" { push('{'); }
"[" { push('['); }
")" { if (top == -1 || pop() != '(') { valid = 0; return 0; } }
"}" { if (top == -1 || pop() != '{') { valid = 0; return 0; } }
"]" { if (top == -1 || pop() != '[') { valid = 0; return 0; } }
"-" {
    if (expect_operand) {
        
        BEGIN(NEGATIVE);
    } else {
        
        noprt++;
        strcpy(oprt[l], yytext);
        l++;
        expect_operand = 1; 
    }
}
<NEGATIVE>[0-9]+ {
   
    nopnd++;
    sprintf(opnd[j], "-%s", yytext);
    j++;
    expect_operand = 0; 
    BEGIN(INITIAL);
}
"+"|"-"|"*"|"/" {
    noprt++;
    strcpy(oprt[l], yytext);
    l++;
    expect_operand = 1; 
}
[0-9]+|[a-zA-Z][a-zA-Z0-9_]* {
    nopnd++;
    strcpy(opnd[j], yytext);
    j++;
    expect_operand = 0;
}
[ \t\n] ;
%%

int main()
{
    int k;
    printf("Enter the arithmetic expression (Enter ctrl + D to execute): ");
    yylex();

    if (valid == 1 && top == -1 && (nopnd - noprt) == 1)
    {
        printf("\nValid expression\n");

        printf("The operators are\n");
        for (k = 0; k < l; k++)
            printf("%s \n", oprt[k]);

        printf("The operands are\n");
        for (k = 0; k < j; k++)
            printf("%s \n", opnd[k]);
    }
    else
        printf("The expression is invalid\n");
    return 0;
}

int yywrap()
{
    return 1;
}
