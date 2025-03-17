%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void yyerror(char* s);
int yylex();

// Structure to store shift-reduce actions
typedef struct {
    char action[20];  // "shift" or "reduce"
    char symbol[20];  // Symbol involved
    char stack[100];  // Stack contents after action
    char input[100];  // Remaining input
    int value;        // Value after reduction (if applicable)
} ParsingStep;

ParsingStep steps[100];  // Array to store parsing steps
int step_count = 0;      // Counter for steps

// Structure for symbol table to store id values
typedef struct {
    char id[10];
    int value;
} IdEntry;

IdEntry id_table[100];
int id_count = 0;

// Function to get value of an ID
int get_id_value(char* id_name) {
    for (int i = 0; i < id_count; i++) {
        if (strcmp(id_table[i].id, id_name) == 0) {
            return id_table[i].value;
        }
    }
    printf("ID '%s' not found\n", id_name);
    return 0;
}

// Function to add ID to the table
void add_id(char* id_name, int value) {
    strcpy(id_table[id_count].id, id_name);
    id_table[id_count].value = value;
    id_count++;
}

// Variables for tracking parsing state
char stack[100];
int stack_top = -1;
int current_value = 0;

// Stack operations
void push(char c) {
    stack[++stack_top] = c;
}

char pop() {
    if (stack_top >= 0)
        return stack[stack_top--];
    return '\0';
}

// Functions to record parsing steps
void record_shift(char symbol, char* remaining_input) {
    strcpy(steps[step_count].action, "shift");
    sprintf(steps[step_count].symbol, "%c", symbol);
    memcpy(steps[step_count].stack, stack, stack_top + 1);
    steps[step_count].stack[stack_top + 1] = '\0';
    strcpy(steps[step_count].input, remaining_input);
    steps[step_count].value = current_value;
    step_count++;
}

void record_reduce(char* production, int result_value, char* remaining_input) {
    strcpy(steps[step_count].action, "reduce");
    strcpy(steps[step_count].symbol, production);
    memcpy(steps[step_count].stack, stack, stack_top + 1);
    steps[step_count].stack[stack_top + 1] = '\0';
    strcpy(steps[step_count].input, remaining_input);
    steps[step_count].value = result_value;
    step_count++;
    current_value = result_value;
}

// Function to display all parsing steps
void display_steps() {
    printf("\n%-10s %-15s %-20s %-20s %s\n", "Step", "Action", "Symbol", "Stack", "Input");
    printf("------------------------------------------------------------------------------------\n");
    for (int i = 0; i < step_count; i++) {
        printf("%-10d %-15s %-20s %-20s ", i+1, steps[i].action, steps[i].symbol, steps[i].stack);
        printf("%s", steps[i].input);
        if (strcmp(steps[i].action, "reduce") == 0) {
            printf(" (value: %d)", steps[i].value);
        }
        printf("\n");
    }
}

// Function to collect ID values from user
void collect_id_values(char* input) {
    // Reset ID table
    id_count = 0;
    
    // Tokenize the input to find all IDs
    char* token;
    char input_copy[100];
    strcpy(input_copy, input);
    
    token = strtok(input_copy, " ");
    while (token != NULL) {
        if (strcmp(token, "id") == 0) {
            char id_name[10];
            sprintf(id_name, "id%d", id_count + 1);
            printf("Enter value for %s: ", id_name);
            int value;
            scanf("%d", &value);
            add_id(id_name, value);
        }
        token = strtok(NULL, " ");
    }
}

// Function to check if input is valid
int is_valid_input(char* input) {
    // Simple validation logic
    char* token;
    char input_copy[100];
    strcpy(input_copy, input);
    
    token = strtok(input_copy, " ");
    int expecting_operand = 1; // Start by expecting an operand
    
    while (token != NULL) {
        if (expecting_operand) {
            if (strcmp(token, "id") == 0 || isdigit(token[0])) {
                expecting_operand = 0; // Next token should be an operator
            } else if (strcmp(token, "(") == 0) {
                // Opening parenthesis is okay when expecting operand
            } else {
                return 0; // Invalid: expected operand but got something else
            }
        } else {
            if (strcmp(token, "+") == 0 || strcmp(token, "-") == 0 || 
                strcmp(token, "*") == 0 || strcmp(token, "/") == 0) {
                expecting_operand = 1; // Next token should be an operand
            } else if (strcmp(token, ")") == 0) {
                // Closing parenthesis is okay when expecting operator
            } else {
                return 0; // Invalid: expected operator but got something else
            }
        }
        token = strtok(NULL, " ");
    }
    
    return !expecting_operand; // Valid if we're not expecting an operand at the end
}

%}

%token ID NUM PLUS MINUS TIMES DIVIDE LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%left UMINUS

%%

start: expr { printf("\nFinal Result: %d\n", $1); }
     ;

expr: expr PLUS expr   { $$ = $1 + $3; printf("Reduce: expr + expr -> expr (%d)\n", $$); }
    | expr MINUS expr  { $$ = $1 - $3; printf("Reduce: expr - expr -> expr (%d)\n", $$); }
    | expr TIMES expr  { $$ = $1 * $3; printf("Reduce: expr * expr -> expr (%d)\n", $$); }
    | expr DIVIDE expr { $$ = $1 / $3; printf("Reduce: expr / expr -> expr (%d)\n", $$); }
    | MINUS expr %prec UMINUS { $$ = -$2; printf("Reduce: -expr -> expr (%d)\n", $$); }
    | LPAREN expr RPAREN { $$ = $2; printf("Reduce: (expr) -> expr (%d)\n", $$); }
    | NUM             { $$ = $1; printf("Shift: NUM -> expr (%d)\n", $$); }
    | ID              { 
                        char id_name[10];
                        sprintf(id_name, "id%d", id_count > 0 ? id_table[id_count-1].value : 1);
                        $$ = get_id_value(id_name); 
                        printf("Shift: ID -> expr (%d)\n", $$); 
                      }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    char input[100];
    printf("Enter an expression (use 'id' for identifiers, e.g., 'id + id * id'): ");
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = '\0';  // Remove trailing newline
    
    // Check if input is valid
    if (!is_valid_input(input)) {
        printf("Invalid input expression!\n");
        return 1;
    }
    
    // Collect values for IDs
    collect_id_values(input);
    
    // Initialize parser
    stack_top = -1;
    step_count = 0;
    
    // Parse the expression using yacc
    printf("\nParsing steps:\n");
    
    // Start parsing
    if (yyparse() == 0) {
        printf("\nParsing completed successfully!\n");
        display_steps();
    } else {
        printf("\nParsing failed!\n");
    }
    
    return 0;
}