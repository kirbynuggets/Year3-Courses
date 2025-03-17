%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function declarations */
int yylex();
void yyerror(const char *s);
void record_token(char *token_name, char *lexeme);
void print_stack();
void push(int symbol, int value);
void pop();
int stack_top_symbol();
int stack_top_value();

/* Define max stack size */
#define STACK_SIZE 100

/* Parser state stack */
struct stack_item {
    int symbol;  /* Terminal or non-terminal symbol */
    int value;   /* Value for expression evaluation */
    char *name;  /* Symbol name for debugging */
} stack[STACK_SIZE];

int stack_top = -1; /* Stack pointer */
int step_count = 0; /* For tracking parsing steps */

/* For pretty-printing the parse */
char *symbol_names[] = {
    "NUMBER", "PLUS", "MINUS", "TIMES", "DIVIDE", 
    "LPAREN", "RPAREN", "EOL", "E", "T", "F"
};

/* Symbol IDs for non-terminals (must be higher than token values) */
#define NT_E 100
#define NT_T 101
#define NT_F 102
%}

%union {
    int num;
}

%token <num> NUMBER
%token PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN
%token EOL

%type <num> E T F

%start input

%%

input: /* empty */
     | input line
     ;

line: EOL             { printf("Empty line\n"); }
    | E EOL           { 
                        printf("\nFinal Result: %d\n", $1);
                        printf("Expression is VALID\n\n"); 
                      }
    ;

E: T                  { $$ = $1; }
 | E PLUS T           { $$ = $1 + $3; }
 | E MINUS T          { $$ = $1 - $3; }
 ;

T: F                  { $$ = $1; }
 | T TIMES F          { $$ = $1 * $3; }
 | T DIVIDE F         { 
                        if ($3 == 0) {
                            yyerror("Division by zero");
                            $$ = 0;
                        } else {
                            $$ = $1 / $3;
                        }
                      }
 ;

F: NUMBER             { $$ = $1; }
 | LPAREN E RPAREN    { $$ = $2; }
 ;

%%

/* Stack manipulation functions */
void push(int symbol, int value) {
    if (stack_top >= STACK_SIZE - 1) {
        fprintf(stderr, "Stack overflow\n");
        exit(1);
    }
    stack_top++;
    stack[stack_top].symbol = symbol;
    stack[stack_top].value = value;
    
    /* Set name for debugging */
    if (symbol >= 100) { /* Non-terminals start at 100 */
        stack[stack_top].name = strdup(symbol_names[symbol - 92]); /* Adjust index */
    } else {
        stack[stack_top].name = strdup(symbol_names[symbol - 1]); /* Adjust for token IDs */
    }
}

void pop() {
    if (stack_top < 0) {
        fprintf(stderr, "Stack underflow\n");
        exit(1);
    }
    free(stack[stack_top].name);
    stack_top--;
}

int stack_top_symbol() {
    if (stack_top < 0) return -1;
    return stack[stack_top].symbol;
}

int stack_top_value() {
    if (stack_top < 0) return -1;
    return stack[stack_top].value;
}

void print_stack() {
    printf("Stack: ");
    for (int i = 0; i <= stack_top; i++) {
        printf("%s ", stack[i].name);
    }
    printf("\n");
}

/* Record token for debug output */
void record_token(char *token_name, char *lexeme) {
    step_count++;
    printf("\nStep %d: Shift %s (\"%s\")\n", step_count, token_name, lexeme);
    
    /* Simulate LALR parser actions */
    if (strcmp(token_name, "NUMBER") == 0) {
        int value = atoi(lexeme);
        push(NUMBER, value);
        print_stack();
        
        /* Reduce F -> NUMBER */
        step_count++;
        printf("\nStep %d: Reduce F -> NUMBER\n", step_count);
        int val = stack_top_value();
        pop(); /* Pop NUMBER */
        push(NT_F, val); /* Push F */
        print_stack();
        
        /* Check if we can reduce to T -> F */
        step_count++;
        printf("\nStep %d: Reduce T -> F\n", step_count);
        val = stack_top_value();
        pop(); /* Pop F */
        push(NT_T, val); /* Push T */
        print_stack();
        
        /* Check if we can reduce to E -> T */
        step_count++;
        printf("\nStep %d: Reduce E -> T\n", step_count);
        val = stack_top_value();
        pop(); /* Pop T */
        push(NT_E, val); /* Push E */
        print_stack();
    }
    else if (strcmp(token_name, "PLUS") == 0) {
        push(PLUS, 0);
        print_stack();
    }
    else if (strcmp(token_name, "MINUS") == 0) {
        push(MINUS, 0);
        print_stack();
    }
    else if (strcmp(token_name, "TIMES") == 0) {
        push(TIMES, 0);
        print_stack();
    }
    else if (strcmp(token_name, "DIVIDE") == 0) {
        push(DIVIDE, 0);
        print_stack();
    }
    else if (strcmp(token_name, "LPAREN") == 0) {
        push(LPAREN, 0);
        print_stack();
    }
    else if (strcmp(token_name, "RPAREN") == 0) {
        push(RPAREN, 0);
        print_stack();
        
        /* Reduce F -> (E) */
        if (stack_top >= 2 && 
            stack[stack_top].symbol == RPAREN &&
            stack[stack_top-1].symbol == NT_E &&
            stack[stack_top-2].symbol == LPAREN) {
            
            step_count++;
            printf("\nStep %d: Reduce F -> (E)\n", step_count);
            
            int val = stack[stack_top-1].value;
            pop(); /* Pop ) */
            pop(); /* Pop E */
            pop(); /* Pop ( */
            push(NT_F, val);
            print_stack();
            
            /* Check if we can reduce to T -> F */
            step_count++;
            printf("\nStep %d: Reduce T -> F\n", step_count);
            val = stack_top_value();
            pop(); /* Pop F */
            push(NT_T, val);
            print_stack();
            
            /* Check if we can reduce to E -> T */
            step_count++;
            printf("\nStep %d: Reduce E -> T\n", step_count);
            val = stack_top_value();
            pop(); /* Pop T */
            push(NT_E, val);
            print_stack();
        }
    }
    else if (strcmp(token_name, "EOL") == 0) {
        /* No need to push EOL, just process reductions */
        process_reductions();
    }
}

/* Process pending reductions */
void process_reductions() {
    /* Process binary operators from highest to lowest precedence */
    
    /* First handle * and / operations */
    for (int i = 1; i < stack_top; i += 2) {
        if ((stack[i].symbol == TIMES || stack[i].symbol == DIVIDE) &&
            stack[i-1].symbol == NT_T && stack[i+1].symbol == NT_F) {
            
            step_count++;
            printf("\nStep %d: Reduce T -> T %s F\n", step_count, 
                  (stack[i].symbol == TIMES) ? "*" : "/");
            
            int left = stack[i-1].value;
            int right = stack[i+1].value;
            int result;
            
            if (stack[i].symbol == TIMES) {
                result = left * right;
            } else { /* DIVIDE */
                if (right == 0) {
                    yyerror("Division by zero");
                    result = 0;
                } else {
                    result = left / right;
                }
            }
            
            /* Replace T op F with T */
            pop(); /* Pop F */
            pop(); /* Pop op */
            pop(); /* Pop T */
            push(NT_T, result);
            print_stack();
            
            /* Start over since stack changed */
            i = -1;
        }
    }
    
    /* Then handle + and - operations */
    for (int i = 1; i < stack_top; i += 2) {
        if ((stack[i].symbol == PLUS || stack[i].symbol == MINUS) &&
            stack[i-1].symbol == NT_E && stack[i+1].symbol == NT_T) {
            
            step_count++;
            printf("\nStep %d: Reduce E -> E %s T\n", step_count, 
                  (stack[i].symbol == PLUS) ? "+" : "-");
            
            int left = stack[i-1].value;
            int right = stack[i+1].value;
            int result;
            
            if (stack[i].symbol == PLUS) {
                result = left + right;
            } else { /* MINUS */
                result = left - right;
            }
            
            /* Replace E op T with E */
            pop(); /* Pop T */
            pop(); /* Pop op */
            pop(); /* Pop E */
            push(NT_E, result);
            print_stack();
            
            /* Start over since stack changed */
            i = -1;
        }
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    printf("Expression is INVALID\n");
}

int main(void) {
    printf("LALR(1) Parser for arithmetic expressions\n");
    printf("Enter expressions (e.g., 2+3*4) followed by Enter:\n");
    
    /* Initialize stack with $ (bottom marker) */
    push(0, 0); /* 0 is just a placeholder for $ */
    stack[0].name = strdup("$");
    
    yyparse();
    return 0;
}