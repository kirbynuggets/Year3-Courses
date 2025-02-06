%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure for a simple parse tree node
typedef struct TreeNode {
    char *tokenType;   // "IDENTIFIER", "OPERATOR", "INTEGER", etc.
    char *value;      // The actual identifier, operator, or integer value
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode *root = NULL;  // Root of the parse tree (rudimentary)
TreeNode *currentNode = NULL;  // Keep track of where to add nodes

// Function to create a new parse tree node
TreeNode *createNode(char *tokenType, char *value) {
    TreeNode *newNode = (TreeNode *)malloc(sizeof(TreeNode));
    if (newNode == NULL) {
        perror("Memory allocation error");
        exit(1);
    }
    newNode->tokenType = strdup(tokenType); // Duplicate the string for safety
    newNode->value = strdup(value);       // Duplicate the string for safety
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

// Function to add a node to the parse tree (very simplified)
void addNode(TreeNode *newNode) {
    if (root == NULL) {
        root = newNode;
        currentNode = root;
    } else {
        // Very simplistic addition: always adds to the right
        // A real parser would need much more complex logic
        if (currentNode->left == NULL) {
            currentNode->left = newNode;
        } else if (currentNode->right == NULL) {
            currentNode->right = newNode;
        } else {
            // If left and right are full, create a new root.
            TreeNode *newRoot = createNode("OPERATOR", "+"); //Dummy operator
            newRoot->left = root;
            newRoot->right = newNode;
            root = newRoot;
            currentNode = newRoot;
        }
    }
}

// Function to print the parse tree (very simple)
void printTree(TreeNode *node, int indent) {
    if (node != NULL) {
        printTree(node->right, indent + 4);
        for (int i = 0; i < indent; i++) {
            printf(" ");
        }
        printf("%s: %s\n", node->tokenType, node->value);
        printTree(node->left, indent + 4);
    }
}

// Function to free the parse tree
void freeTree(TreeNode *node) {
    if (node != NULL) {
        freeTree(node->left);
        freeTree(node->right);
        free(node->tokenType);
        free(node->value);
        free(node);
    }
}

%}

DIGIT [0-9]
LETTER [a-zA-Z]
IDENTIFIER {LETTER}({LETTER}|{DIGIT}|_)*
OPERATOR "+"|"-"|"*"|"/"
OPEN_PAREN "("|"{"|"["
CLOSE_PAREN ")"|"}"|"]"
%%

{OPEN_PAREN}     {
    printf("OPEN_PAREN: %s\n", yytext);
    TreeNode *node = createNode("OPEN_PAREN", yytext);
    addNode(node);
}
{CLOSE_PAREN}    {
    printf("CLOSE_PAREN: %s\n", yytext);
    TreeNode *node = createNode("CLOSE_PAREN", yytext);
    addNode(node);
}
{OPERATOR}       {
    printf("OPERATOR: %s\n", yytext);
    TreeNode *node = createNode("OPERATOR", yytext);
    addNode(node);
}
{IDENTIFIER}     {
    printf("IDENTIFIER: %s\n", yytext);
    TreeNode *node = createNode("IDENTIFIER", yytext);
    addNode(node);
}
{DIGIT}+         {
    printf("INTEGER: %s\n", yytext);
    TreeNode *node = createNode("INTEGER", yytext);
    addNode(node);
}
[ \t\n]+         { /* Skip whitespace */ }
.                { printf("ILLEGAL CHARACTER: %s\n", yytext); } /* Error handling*/

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter the arithmetic expression: ");
    yylex();

    printf("\nParse Tree:\n");
    printTree(root, 0);
    freeTree(root);

    return 0;
}