%{
#include <stdio.h>
#include <string.h>

int ddl_count = 0;
int dml_count = 0;
%}

%option case-insensitive

/* Keywords for DDL and DML */
DDL_KEYWORDS   CREATE|ALTER|DROP|TRUNCATE|RENAME
DML_KEYWORDS   SELECT|INSERT|UPDATE|DELETE

/* Regular expression for identifier */
IDENTIFIER   [a-zA-Z_][a-zA-Z0-9_]*

%%
[\t\n ]+         /* Skip whitespace */

"create"|"alter"|"drop"|"truncate"|"rename" {
    ddl_count++;
    printf("%s is a DDL keyword\n", yytext); //Optional, remove this print statement
}

"select"|"insert"|"update"|"delete" {
    dml_count++;
    printf("%s is a DML keyword\n", yytext); //Optional, remove this print statement
}

{IDENTIFIER} { /* Ignore other identifiers */}

.               /* Ignore other characters */

%%

int main(int argc, char *argv[]) {
    FILE *fp;
    char file[256];

    if (argc > 1) {
        // Filename provided as command-line argument
        strncpy(file, argv[1], sizeof(file) - 1);
        file[sizeof(file) - 1] = '\0'; // Ensure null termination
    } else {
        // Prompt the user for the filename
        printf("Enter the filename: ");
        if (fgets(file, sizeof(file), stdin) == NULL) {
            perror("Error reading filename");
            return 1;
        }
        size_t len = strlen(file);
        if (len > 0 && file[len - 1] == '\n') {
            file[len - 1] = '\0';
        }
    }

    fp = fopen(file, "r");
    if (fp == NULL) {
        perror("Error opening file");
        return 1;
    }

    yyin = fp;
    yylex();

    printf("\nNumber of DDL queries: %d\n", ddl_count);
    printf("Number of DML queries: %d\n", dml_count);

    fclose(fp);
    return 0;
}