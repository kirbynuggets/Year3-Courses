%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int flag = 0;

void yyerror(const char *msg);
int yyparse(void);


struct node {
    struct node* child1;
    struct node* child2;
    char op;             
    const char *c_label;
};

void printAbstractTree(struct node *root, int indent) {
    int i;
    for (i = 0; i < indent; i++)
        printf("  ");
    if (root == NULL) {
        printf("NULL\n");
        return;
    }
    printf("Node: %c\n", root->op);
    if (root->child1 || root->child2) {
        for (i = 0; i < indent; i++)
            printf("  ");
        printf("Left:\n");
        printAbstractTree(root->child1, indent + 1);
        for (i = 0; i < indent; i++)
            printf("  ");
        printf("Right:\n");
        printAbstractTree(root->child2, indent + 1);
    }
}


void printConcreteTree(struct node *root, int indent) {
    int i;
    for (i = 0; i < indent; i++)
        printf("  ");
    if (root == NULL) {
        printf("NULL\n");
        return;
    }
    printf("Production: %s\n", root->c_label);
    if (root->child1 || root->child2) {
        for (i = 0; i < indent; i++)
            printf("  ");
        printf("Left:\n");
        printConcreteTree(root->child1, indent + 1);
        for (i = 0; i < indent; i++)
            printf("  ");
        printf("Right:\n");
        printConcreteTree(root->child2, indent + 1);
    }
}



%}

%union {
    struct node* tree;
}

%token id
%type <tree> input expr term factor

%left '+'
%left '*'

%%
input: expr { 
           if (!flag) {
               printf("Valid\n");
               printf("\n--- Abstract Tree ---\n");
               printAbstractTree($1, 0);
               printf("\n--- Concrete Tree ---\n");
               printConcreteTree($1, 0);
           }
           return 0;
       }
    ;


expr: expr '+' term {
           $$ = malloc(sizeof(struct node));
           if (!$$) { yyerror("Memory allocation error"); exit(1); }
           $$->op = '+'; 
           $$->child1 = $1;
           $$->child2 = $3;
           $$->c_label = "E -> E + T";
           printf("Reduced Using Rule: E -> E + T\n");
       }
    | term {
           $$ = malloc(sizeof(struct node));
           if (!$$) { yyerror("Memory allocation error"); exit(1); }
           $$->op = $1->op; 
           $$->child1 = $1;
           $$->child2 = NULL;
           $$->c_label = "E -> T";
           printf("Reduced Using Rule: E -> T\n");
       }
    ;

term: term '*' factor {
           $$ = malloc(sizeof(struct node));
           if (!$$) { yyerror("Memory allocation error"); exit(1); }
           $$->op = '*';
           $$->child1 = $1;
           $$->child2 = $3;
           $$->c_label = "T -> T * F";
           printf("Reduced Using Rule: T -> T * F\n");
       }
    | factor {
           $$ = malloc(sizeof(struct node));
           if (!$$) { yyerror("Memory allocation error"); exit(1); }
           $$->op = $1->op;
           $$->child1 = $1;
           $$->child2 = NULL;
           $$->c_label = "T -> F";
           printf("Reduced Using Rule: T -> F\n");
       }
    ;

factor: id {
           $$ = malloc(sizeof(struct node));
           if (!$$) { yyerror("Memory allocation error"); exit(1); }
           $$->child1 = NULL;
           $$->child2 = NULL;
           $$->op = 'i';
           $$->c_label = "F -> id";
           printf("Reduced Using Rule: F -> id\n");
       }
    ;
%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    flag = 1;
}

int main() {
    printf("Enter an arithmetic expression: ");
    yyparse();
    if (flag) {
        printf("Invalid\n");
    }
    return 0;
}