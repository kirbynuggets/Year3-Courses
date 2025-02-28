%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char* s);

// Define non-terminals and terminals
#define NON_TERMINALS 3
#define TERMINALS 3
char non_terminals[NON_TERMINALS] = {'S', 'A', 'B'};
char terminals[TERMINALS] = {'a', 'b', '$'};

// Structure for sets
typedef struct {
    char set[10];
    int size;
} SymbolSet;

SymbolSet first[NON_TERMINALS];
SymbolSet follow[NON_TERMINALS];

// LL(1) Parsing table: [non-terminal][terminal] -> production index
int parse_table[NON_TERMINALS][TERMINALS];

// Production structure
typedef struct {
    char lhs;       // Left-hand side (non-terminal)
    char rhs[10];   // Right-hand side (string)
} Production;

Production productions[] = {
    {'S', "AB"},     // 0: S -> A B
    {'A', "aA"},     // 1: A -> a A
    {'A', ""},       // 2: A -> ε
    {'B', "bB"},     // 3: B -> b B
    {'B', ""}        // 4: B -> ε
};
int num_productions = 5;

// Helper functions
int contains(char* set, char c) {
    return strchr(set, c) != NULL;
}

void add_to_set(SymbolSet* set, char c) {
    if (!contains(set->set, c) && c != '\0') {
        set->set[set->size++] = c;
        set->set[set->size] = '\0';
    }
}

int index_of_non_terminal(char nt) {
    for (int i = 0; i < NON_TERMINALS; i++) {
        if (non_terminals[i] == nt) return i;
    }
    return -1;
}

int index_of_terminal(char t) {
    for (int i = 0; i < TERMINALS; i++) {
        if (terminals[i] == t) return i;
    }
    return -1;
}

// Compute FIRST sets
void compute_first() {
    int changed;
    do {
        changed = 0;
        for (int i = 0; i < num_productions; i++) {
            int nt_idx = index_of_non_terminal(productions[i].lhs);
            char* rhs = productions[i].rhs;

            if (rhs[0] == '\0') { // ε production
                if (!contains(first[nt_idx].set, 'ε')) {
                    add_to_set(&first[nt_idx], 'ε');
                    changed = 1;
                }
            } else if (strchr("ab", rhs[0])) { // Terminal
                if (!contains(first[nt_idx].set, rhs[0])) {
                    add_to_set(&first[nt_idx], rhs[0]);
                    changed = 1;
                }
            } else { // Non-terminal
                int rhs_idx = index_of_non_terminal(rhs[0]);
                for (int j = 0; j < first[rhs_idx].size; j++) {
                    if (first[rhs_idx].set[j] != 'ε' && !contains(first[nt_idx].set, first[rhs_idx].set[j])) {
                        add_to_set(&first[nt_idx], first[rhs_idx].set[j]);
                        changed = 1;
                    }
                }
                if (contains(first[rhs_idx].set, 'ε') && strlen(rhs) > 1) {
                    int next_idx = index_of_non_terminal(rhs[1]);
                    for (int j = 0; j < first[next_idx].size; j++) {
                        if (!contains(first[nt_idx].set, first[next_idx].set[j])) {
                            add_to_set(&first[nt_idx], first[next_idx].set[j]);
                            changed = 1;
                        }
                    }
                }
            }
        }
    } while (changed);
}

// Compute FOLLOW sets
void compute_follow() {
    add_to_set(&follow[0], '$'); // FOLLOW(S) starts with $
    int changed;
    do {
        changed = 0;
        for (int i = 0; i < num_productions; i++) {
            char nt = productions[i].lhs;
            char* rhs = productions[i].rhs;
            int nt_idx = index_of_non_terminal(nt);

            for (int j = 0; rhs[j]; j++) {
                if (strchr("SAB", rhs[j])) {
                    int curr_idx = index_of_non_terminal(rhs[j]);
                    if (rhs[j+1] == '\0') { // Last symbol
                        for (int k = 0; k < follow[nt_idx].size; k++) {
                            if (!contains(follow[curr_idx].set, follow[nt_idx].set[k])) {
                                add_to_set(&follow[curr_idx], follow[nt_idx].set[k]);
                                changed = 1;
                            }
                        }
                    } else if (strchr("ab", rhs[j+1])) { // Followed by terminal
                        if (!contains(follow[curr_idx].set, rhs[j+1])) {
                            add_to_set(&follow[curr_idx], rhs[j+1]);
                            changed = 1;
                        }
                    } else { // Followed by non-terminal
                        int next_idx = index_of_non_terminal(rhs[j+1]);
                        for (int k = 0; k < first[next_idx].size; k++) {
                            if (first[next_idx].set[k] != 'ε' && !contains(follow[curr_idx].set, first[next_idx].set[k])) {
                                add_to_set(&follow[curr_idx], first[next_idx].set[k]);
                                changed = 1;
                            }
                        }
                        if (contains(first[next_idx].set, 'ε')) {
                            for (int k = 0; k < follow[nt_idx].size; k++) {
                                if (!contains(follow[curr_idx].set, follow[nt_idx].set[k])) {
                                    add_to_set(&follow[curr_idx], follow[nt_idx].set[k]);
                                    changed = 1;
                                }
                            }
                        }
                    }
                }
            }
        }
    } while (changed);
}

// Build LL(1) parsing table
void build_parse_table() {
    memset(parse_table, -1, sizeof(parse_table)); // Initialize to -1 (no production)
    for (int i = 0; i < num_productions; i++) {
        int nt_idx = index_of_non_terminal(productions[i].lhs);
        char* rhs = productions[i].rhs;

        if (rhs[0] == '\0') { // ε production
            for (int j = 0; j < follow[nt_idx].size; j++) {
                int t_idx = index_of_terminal(follow[nt_idx].set[j]);
                if (t_idx != -1) parse_table[nt_idx][t_idx] = i;
            }
        } else if (strchr("ab", rhs[0])) { // Starts with terminal
            int t_idx = index_of_terminal(rhs[0]);
            parse_table[nt_idx][t_idx] = i;
        } else { // Starts with non-terminal
            int rhs_idx = index_of_non_terminal(rhs[0]);
            for (int j = 0; j < first[rhs_idx].size; j++) {
                if (first[rhs_idx].set[j] != 'ε') {
                    int t_idx = index_of_terminal(first[rhs_idx].set[j]);
                    parse_table[nt_idx][t_idx] = i;
                }
            }
        }
    }
}

// Display functions
void display_sets() {
    printf("\nFIRST Sets:\n");
    for (int i = 0; i < NON_TERMINALS; i++) {
        printf("FIRST(%c) = {%s}\n", non_terminals[i], first[i].set);
    }
    printf("\nFOLLOW Sets:\n");
    for (int i = 0; i < NON_TERMINALS; i++) {
        printf("FOLLOW(%c) = {%s}\n", non_terminals[i], follow[i].set);
    }
}

void display_parse_table() {
    printf("\nLL(1) Parsing Table:\n");
    printf("  | ");
    for (int j = 0; j < TERMINALS; j++) printf("%c  ", terminals[j]);
    printf("\n--+");
    for (int j = 0; j < TERMINALS; j++) printf("---");
    printf("\n");
    for (int i = 0; i < NON_TERMINALS; i++) {
        printf("%c | ", non_terminals[i]);
        for (int j = 0; j < TERMINALS; j++) {
            if (parse_table[i][j] == -1) printf("   ");
            else printf("%d  ", parse_table[i][j]);
        }
        printf("\n");
    }
}

%}

%token 'a' 'b' '$'

%%

start: S '$' { printf("Parsing successful!\n"); return 0; }
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
    
    // Initialize sets
    for (int i = 0; i < NON_TERMINALS; i++) {
        first[i].size = 0;
        first[i].set[0] = '\0';
        follow[i].size = 0;
        follow[i].set[0] = '\0';
    }

    // Compute FIRST, FOLLOW, and parsing table
    compute_first();
    compute_follow();
    build_parse_table();

    // Display results
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