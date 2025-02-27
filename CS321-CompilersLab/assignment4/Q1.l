%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int valid = 1, top = -1;
char a[100];
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

"("|"{"|"[" { push(yytext[0]); } // Push opening brackets onto the stack
")" { if (top == -1 || pop() != '(') { valid = 0; } } // Check for matching ')'
"}" { if (top == -1 || pop() != '{') { valid = 0; } } // Check for matching '}'
"]" { if (top == -1 || pop() != '[') { valid = 0; } } // Check for matching ']'
"-" {
    if (expect_operand) {
        // Handle negative numbers
        BEGIN(NEGATIVE);
    } else {
        // Handle subtraction operator
        expect_operand = 1; 
    }
}
<NEGATIVE>[0-9]+ {
    // Handle negative numbers
    expect_operand = 0; 
    BEGIN(INITIAL);
}
"+"|"-"|"*"|"/" {
    // Handle operators
    expect_operand = 1; 
}
[0-9]+ {
    // Handle positive integers
    expect_operand = 0;
}
[a-zA-Z][a-zA-Z0-9_]* {
    // Handle variables (if needed)
    expect_operand = 0;
}
[ \t\n] ; // Ignore whitespace
. {
    // Handle invalid characters
    valid = 0;
}
%%

int main() {
    printf("Enter the arithmetic expression (Enter ctrl + D to execute): ");
    yylex();

    if (valid == 1 && top == -1) {
        printf("Valid expression\n");
    } else {
        printf("Invalid expression\n");
    }
    return 0;
}

int yywrap() {
    return 1;
}