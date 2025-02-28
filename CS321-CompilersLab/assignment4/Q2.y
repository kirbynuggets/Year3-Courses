%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char* s);

// Non-terminals and terminals
char non_terminals[] = {'S', 'A', 'B'};
char terminals[] = {'a', 'b', '$'};
#define NT_COUNT 3
#define T_COUNT 3

// Productions
typedef struct {
    char lhs;
    char rhs[10];
} Production;

Production productions[] = {
    {'S', "AB"},  // 0
    {'A', "aA"},  // 1
    {'A', ""},    // 2 (ε)
    {'B', "bB"},  // 3
    {'B', ""}     // 4 (ε)
};
int prod_count = 5;

// FIRST and FOLLOW sets
typedef struct {
    char set[10];
    int size;
} SymbolSet;

SymbolSet first[NT_COUNT];
SymbolSet follow[NT_COUNT];

// Parsing table [non-terminal][terminal]
char* parse_table[NT_COUNT][T_COUNT];

// Stack for LL(1) parsing
char stack[100];
int top = -1;

// Input buffer
char input[100];
int input_pos = 0;

// Helper functions
void push(char c) {
    stack[++top] = c;
}

char pop() {
    return stack[top--];
}

int is_non_terminal(char c) {
    return (c == 'S' || c == 'A' || c == 'B');
}

int nt_index(char c) {
    for (int i = 0; i < NT_COUNT; i++) {
        if (non_terminals[i] == c) return i;
    }
    return -1;
}

int t_index(char c) {
    for (int i = 0; i < T_COUNT; i++) {
        if (terminals[i] == c) return i;
    }
    return -1;
}

void add_to_set(SymbolSet* set, char c) {
    if (strchr(set->set, c) == NULL && c != '\0') {
        set->set[set->size++] = c;
        set->set[set->size] = '\0';
    }
}

// Computing FIRST sets
void compute_first() {
    int changed;
    do {
        changed = 0;
        for (int i = 0; i < prod_count; i++) {
            int nt_idx = nt_index(productions[i].lhs);
            char* rhs = productions[i].rhs;

            if (rhs[0] == '\0') { // ε production
                if (!strchr(first[nt_idx].set, 'e')) {
                    add_to_set(&first[nt_idx], 'e');
                    changed = 1;
                }
            } else if (strchr("ab", rhs[0])) { // Terminal
                if (!strchr(first[nt_idx].set, rhs[0])) {
                    add_to_set(&first[nt_idx], rhs[0]);
                    changed = 1;
                }
            } else { // Non-terminal
                int rhs_idx = nt_index(rhs[0]);
                for (int j = 0; j < first[rhs_idx].size; j++) {
                    if (first[rhs_idx].set[j] != 'e' && !strchr(first[nt_idx].set, first[rhs_idx].set[j])) {
                        add_to_set(&first[nt_idx], first[rhs_idx].set[j]);
                        changed = 1;
                    }
                }
                // Only add ε to S if both A and B can derive ε (not applicable here)
                if (strchr(first[rhs_idx].set, 'e') && strlen(rhs) > 1) {
                    int next_idx = nt_index(rhs[1]);
                    for (int j = 0; j < first[next_idx].size; j++) {
                        if (first[next_idx].set[j] != 'e' && !strchr(first[nt_idx].set, first[next_idx].set[j])) {
                            add_to_set(&first[nt_idx], first[next_idx].set[j]);
                            changed = 1;
                        }
                    }
                }
            }
        }
    } while (changed);
}

// Computing FOLLOW sets
void compute_follow() {
    add_to_set(&follow[0], '$'); // $ for S
    int changed;
    do {
        changed = 0;
        for (int i = 0; i < prod_count; i++) {
            char nt = productions[i].lhs;
            char* rhs = productions[i].rhs;
            int nt_idx = nt_index(nt);

            for (int j = 0; rhs[j]; j++) {
                if (is_non_terminal(rhs[j])) {
                    int curr_idx = nt_index(rhs[j]);
                    if (rhs[j+1] == '\0') {
                        for (int k = 0; k < follow[nt_idx].size; k++) {
                            if (!strchr(follow[curr_idx].set, follow[nt_idx].set[k])) {
                                add_to_set(&follow[curr_idx], follow[nt_idx].set[k]);
                                changed = 1;
                            }
                        }
                    } else if (strchr("ab", rhs[j+1])) {
                        if (!strchr(follow[curr_idx].set, rhs[j+1])) {
                            add_to_set(&follow[curr_idx], rhs[j+1]);
                            changed = 1;
                        }
                    } else {
                        int next_idx = nt_index(rhs[j+1]);
                        for (int k = 0; k < first[next_idx].size; k++) {
                            if (first[next_idx].set[k] != 'e' && !strchr(follow[curr_idx].set, first[next_idx].set[k])) {
                                add_to_set(&follow[curr_idx], first[next_idx].set[k]);
                                changed = 1;
                            }
                        }
                        if (strchr(first[next_idx].set, 'e')) {
                            for (int k = 0; k < follow[nt_idx].size; k++) {
                                if (!strchr(follow[curr_idx].set, follow[nt_idx].set[k])) {
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

// Building LL(1) parsing table
void build_parse_table() {
    for (int i = 0; i < NT_COUNT; i++) {
        for (int j = 0; j < T_COUNT; j++) {
            parse_table[i][j] = NULL; // Initializing to NULL
        }
    }
    for (int i = 0; i < prod_count; i++) {
        int nt_idx = nt_index(productions[i].lhs);
        char* rhs = productions[i].rhs;
        char prod_str[10];
        sprintf(prod_str, "%c -> %s", productions[i].lhs, rhs[0] ? rhs : "ε");

        if (rhs[0] == '\0') { // ε production
            for (int j = 0; j < follow[nt_idx].size; j++) {
                int t_idx = t_index(follow[nt_idx].set[j]);
                if (t_idx != -1) parse_table[nt_idx][t_idx] = strdup(prod_str);
            }
        } else if (strchr("ab", rhs[0])) { // Terminal
            int t_idx = t_index(rhs[0]);
            if (t_idx != -1) parse_table[nt_idx][t_idx] = strdup(prod_str);
        } else { // Non-terminal
            int rhs_idx = nt_index(rhs[0]);
            for (int j = 0; j < first[rhs_idx].size; j++) {
                if (first[rhs_idx].set[j] != 'e') {
                    int t_idx = t_index(first[rhs_idx].set[j]);
                    if (t_idx != -1) parse_table[nt_idx][t_idx] = strdup(prod_str);
                }
            }
        }
    }
}

// Displaying sets and table
void display_sets() {
    printf("\nFIRST Sets:\n");
    for (int i = 0; i < NT_COUNT; i++) {
        printf("FIRST(%c) = {", non_terminals[i]);
        for (int j = 0; j < first[i].size; j++) {
            if (first[i].set[j] == 'e') {
                printf("ε");
            } else {
                printf("%c", first[i].set[j]);
            }
            if (j < first[i].size - 1) printf(",");
        }
        printf("}\n");
    }
    printf("\nFOLLOW Sets:\n");
    for (int i = 0; i < NT_COUNT; i++) {
        printf("FOLLOW(%c) = {", non_terminals[i]);
        for (int j = 0; j < follow[i].size; j++) {
            printf("%c", follow[i].set[j]);
            if (j < follow[i].size - 1) printf(",");
        }
        printf("}\n");
    }
}

void display_parse_table() {
    printf("\nLL(1) Parsing Table:\n");
    printf("  | a       b       $\n");
    printf("--+-----------------\n");
    for (int i = 0; i < NT_COUNT; i++) {
        printf("%c | ", non_terminals[i]);
        for (int j = 0; j < T_COUNT; j++) {
            if (parse_table[i][j] == NULL) printf("        ");
            else printf("%-7s ", parse_table[i][j]);
        }
        printf("\n");
    }
}

// LL(1) Parsing function
void ll1_parse(char* input_str) {
    printf("\nParsing steps:\n");
    strcpy(input, input_str);
    input_pos = 0;
    top = -1;
    push('$');
    push('S');

    while (top >= 0) {
        char current = stack[top];
        char lookahead = input[input_pos];

        if (current == '$' && lookahead == '$') {
            printf("Parsing successful!\n");
            break;
        }

        if (strchr("ab$", current) && current == lookahead) { // Terminal match
            pop();
            input_pos++;
        } else if (is_non_terminal(current)) {
            int nt_idx = nt_index(current);
            int t_idx = t_index(lookahead);
            char* prod = parse_table[nt_idx][t_idx];

            if (prod == NULL) {
                yyerror("No valid production found");
                return;
            }

            printf("Applied %s\n", prod);
            pop();
            char* rhs = strchr(prod, '>') + 2; // Skip "X -> "
            if (rhs[0] != '\0' && strcmp(rhs, "ε") != 0) { // Non-ε production
                for (int i = strlen(rhs) - 1; i >= 0; i--) {
                    push(rhs[i]);
                }
            }
        } else {
            yyerror("Mismatch in parsing");
            return;
        }
    }
}

%}

%token 'a' 'b' '$'

%%

start: /* Empty rule, parsing handled manually */
     ;

%%

int main() {
    printf("Enter the input string (use 'a', 'b', and '$' to end): ");
    char input_str[100];
    fgets(input_str, 100, stdin);
    input_str[strcspn(input_str, "\n")] = '\0';

    // Initialize sets
    for (int i = 0; i < NT_COUNT; i++) {
        first[i].size = 0;
        first[i].set[0] = '\0';
        follow[i].size = 0;
        follow[i].set[0] = '\0';
    }

    compute_first();
    compute_follow();
    build_parse_table();

    display_sets();
    display_parse_table();

    ll1_parse(input_str);

    return 0;
}

void yyerror(char* s) {
    printf("Error: %s\n", s);
    exit(1);
}