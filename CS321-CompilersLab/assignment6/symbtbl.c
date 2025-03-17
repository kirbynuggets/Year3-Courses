#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "struct.h"

symbtbl* putsymb(char* cols, char* tables, int linenum) {
    symbtbl* node = malloc(sizeof(symbtbl));
    node->columns = strdup(cols);
    node->tables = strdup(tables);
    node->linenum = linenum;
    node->next = NULL;
    
    printf("Valid SQL query at line %d\n", linenum);
    printf("Columns: %s\n", cols);
    printf("Tables: %s\n\n", tables);
    
    return node;
}