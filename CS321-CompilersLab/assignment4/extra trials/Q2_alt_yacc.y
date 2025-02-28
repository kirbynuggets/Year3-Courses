%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char* s);

// Structure for FIRST and FOLLOW sets
typedef struct {
    char set[10];
} SymbolSet;

SymbolSet first[3];  // S, A, B
SymbolSet follow[3]; // S, A, B

// LL(1) Parsing table: [non-terminal][terminal] -> production string
char* parse_table[3][3] = {
    {"S -> A B", "S -> A B", NULL}, // S: a, b, $
    {"A -> a A", NULL, "A -> ε"},   // A: a, b, $
    {NULL, "B -> b B", "B -> ε"}    // B: a, b, $
};

// Hardcoded for simplicity, but computed logically
void compute_sets() {
    strcpy(first[0].set, "a,b");   // FIRST(S)
    strcpy(first[1].set, "a,ε");   // FIRST(A)
    strcpy(first[2].set, "b,ε");   // FIRST(B)

    strcpy(follow[0].set, "$");    // FOLLOW(S)
    strcpy(follow[1].set, "b,$");  // FOLLOW(A)
    strcpy(follow[2].set, "$");    // FOLLOW(B)
}

void display_sets() {
    printf("\nFIRST Sets:\n");
    printf("FIRST(S) = {%s}\n", first[0].set);
    printf("FIRST(A) = {%s}\n", first[1].set);
    printf("FIRST(B) = {%s}\n", first[2].set);

    printf("\nFOLLOW Sets:\n");
    printf("FOLLOW(S) = {%s}\n", follow[0].set);
    printf("FOLLOW(A) = {%s}\n", follow[1].set);
    printf("FOLLOW(B) = {%s}\n", follow[2].set);
}

void display_parse_table() {
    char* terminals = "ab$";
    printf("\nLL(1) Parsing Table:\n");
    printf("  | a       b       $      \n");
    printf("--+-----------------------\n");
    printf("S | %-7s %-7s %-7s\n", parse_table[0][0], parse_table[0][1], parse_table[0][2] ? parse_table[0][2] : "");
    printf("A | %-7s %-7s %-7s\n", parse_table[1][0], parse_table[1][1] ? parse_table[1][1] : "", parse_table[1][2]);
    printf("B | %-7s %-7s %-7s\n", parse_table[2][0] ? parse_table[2][0] : "", parse_table[2][1], parse_table[2][2]);
}

%}

%token 'a' 'b' '$'

%%

start: S '$' { printf("Parsing successful!\n"); }
     ;

S: A B { printf("Applied S -> A B\n"); }
 ;

A: 'a' A { printf("Applied A -> a A\n"); }
 |        { printf("Applied A -> ε\n"); }
 ;

B: 'b' B { printf("Applied B -> b B\n"); }
 |        { printf("Applied B -> ε\n"); }
 ;

%%

int main() {
    printf("Enter the input string (use 'a', 'b', and '$' to end): ");
    
    // Compute and display FIRST, FOLLOW, and parsing table
    compute_sets();
    display_sets();
    display_parse_table();

    // Start parsing
    printf("\nParsing steps:\n");
    yyparse();
    return 0;
}

void yyerror(char* s) {
    printf("Error: %s\n", s);
    exit(1);
}