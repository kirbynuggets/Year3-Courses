%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 100
#define TERMINALS 3
#define NON_TERMINALS 3

char stack[MAX];
int top = -1;
char input[MAX];
int input_pos = 0;
int current_token;


int first[NON_TERMINALS][4] = {
    {1, 1, 0, 0},  // FIRST(S) = {a, b}
    {1, 0, 0, 1},  // FIRST(A) = {a, ε}
    {0, 1, 0, 0}   // FIRST(B) = {b}
};
int follow[NON_TERMINALS][3] = {
    {0, 0, 1},     // FOLLOW(S) = {$}
    {0, 1, 0},     // FOLLOW(A) = {b}
    {0, 0, 1}      // FOLLOW(B) = {$}
};
int parsing_table[NON_TERMINALS][TERMINALS];  

void push(char c);
char pop();
void displayStack();
void displayInput();
void error();
void parse();
void constructParsingTable();
void displayFirstFollow();
void displayParsingTable();
int getTableIndex(char row, char col);
void advance();
int yylex();
void yyerror(char *s);

%}

%token 'a' 'b' '$'

%%

start:
    ;

%%

void push(char c) {
    if (top < MAX - 1) {
        stack[++top] = c;
    }
}

char pop() {
    if (top >= 0) {
        return stack[top--];
    }
    return '\0';
}

void displayStack() {
    for (int i = 0; i <= top; i++) {
        printf("%c", stack[i]);
    }
}

void displayInput() {
    printf("%s", &input[input_pos]);
}

void constructParsingTable() {
    memset(parsing_table, -1, sizeof(parsing_table));
   
    if (first[0][0]) parsing_table[0][0] = 0;  
    if (first[0][1]) parsing_table[0][1] = 0;  
   
    
    if (first[1][0]) parsing_table[1][0] = 1;  
   
    
    if (first[1][3]) {  
        if (follow[1][0]) parsing_table[1][0] = 2;  
        if (follow[1][1]) parsing_table[1][1] = 2;  
        if (follow[1][2]) parsing_table[1][2] = 2;  
    }
   
    
    if (first[2][1]) parsing_table[2][1] = 3;  
}

void displayFirstFollow() {
    printf("FIRST Sets:\n");
    printf("FIRST(S) = {");
    if (first[0][0]) printf("a, ");
    if (first[0][1]) printf("b, ");
    if (first[0][3]) printf("ε, ");
    printf("\b\b}\n");
   
    printf("FIRST(A) = {");
    if (first[1][0]) printf("a, ");
    if (first[1][1]) printf("b, ");
    if (first[1][3]) printf("ε, ");
    printf("\b\b}\n");
   
    printf("FIRST(B) = {");
    if (first[2][0]) printf("a, ");
    if (first[2][1]) printf("b, ");
    if (first[2][3]) printf("ε, ");
    printf("\b\b}\n");
   
    printf("\nFOLLOW Sets:\n");
    printf("FOLLOW(S) = {");
    if (follow[0][0]) printf("a, ");
    if (follow[0][1]) printf("b, ");
    if (follow[0][2]) printf("$, ");
    printf("\b\b}\n");
   
    printf("FOLLOW(A) = {");
    if (follow[1][0]) printf("a, ");
    if (follow[1][1]) printf("b, ");
    if (follow[1][2]) printf("$, ");
    printf("\b\b}\n");
   
    printf("FOLLOW(B) = {");
    if (follow[2][0]) printf("a, ");
    if (follow[2][1]) printf("b, ");
    if (follow[2][2]) printf("$, ");
    printf("\b\b}\n");
}

void displayParsingTable() {
    printf("\nLL(1) Parsing Table:\n");
    printf("\t|a\t|b\t|$\n");
    printf("--------------------------------\n");
    printf("S\t|%s\t|%s\t|%s\n",
           parsing_table[0][0] == 0 ? "S→AB" : "-",
           parsing_table[0][1] == 0 ? "S→AB" : "-",
           parsing_table[0][2] == 0 ? "S→AB" : "-");
    printf("A\t|%s\t|%s\t|%s\n",
           parsing_table[1][0] == 1 ? "A→aA" : "-",
           parsing_table[1][1] == 2 ? "A→ε" : "-",
           parsing_table[1][2] == 2 ? "A→ε" : "-");
    printf("B\t|%s\t|%s\t|%s\n",
           parsing_table[2][0] == 3 ? "B→b" : "-",
           parsing_table[2][1] == 3 ? "B→b" : "-",
           parsing_table[2][2] == 3 ? "B→b" : "-");
}

int getTableIndex(char row, char col) {
    int row_idx, col_idx;
    switch(row) {
        case 'S': row_idx = 0; break;
        case 'A': row_idx = 1; break;
        case 'B': row_idx = 2; break;
        default: return -1;
    }
    switch(col) {
        case 'a': col_idx = 0; break;
        case 'b': col_idx = 1; break;
        case '$': col_idx = 2; break;
        default: return -1;
    }
    return parsing_table[row_idx][col_idx];
}

void advance() {
    current_token = yylex();
    if (current_token != 0) {
        input[input_pos++] = current_token;
    }
}

void parse() {
    push('$');
    push('S');
    
    printf("\nParsing Process:\n");
    printf("Stack\t\t\t\tAction\n");
    printf("--------------------------------------------\n");
   
    current_token = yylex();
    input[input_pos++] = current_token;
   
    while (top >= 0) {
        displayStack();
        printf("\t\t");
        displayInput();
        printf("\t\t");
       
        char X = stack[top];
        char a = input[input_pos-1];
       
        if (X == a && X == '$') {
            printf("Accept\n");
            printf("\nInput string is valid!\n");
            return;
        }
        else if (X == a) {
            printf("Match %c\n", X);
            pop();
            advance();
        }
        else if (X == 'S' || X == 'A' || X == 'B') {
            int production = getTableIndex(X, a);
            switch(production) {
                case 0:  // S → AB
                    printf("S → AB\n");
                    pop();
                    push('B');
                    push('A');
                    break;
                case 1:  // A → aA
                    printf("A → aA\n");
                    pop();
                    push('A');
                    push('a');
                    break;
                case 2:  // A → ε
                    printf("A → ε\n");
                    pop();
                    break;
                case 3:  // B → b
                    printf("B → b\n");
                    pop();
                    push('b');
                    break;
                case -1:
                    error();
                    return;
            }
        }
        else {
            error();
            return;
        }
    }
}

void error() {
    printf("Error\n");
    printf("\nInput string is invalid!\n");
}

int main() {
    displayFirstFollow();
    constructParsingTable();
    displayParsingTable();
   
    printf("\nEnter the input string (end with $): ");
    parse();
   
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}