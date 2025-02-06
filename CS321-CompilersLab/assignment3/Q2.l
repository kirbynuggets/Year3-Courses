%{
#include <stdio.h>
#include <string.h>  // For strlen
int count = 0;
%}

op [+-*/]
letter [a-zA-Z]
digit [0-9]
id {letter}+({letter}|{digit})*
notid {digit}+{letter}+

%%
[\t\n]+           /* Skip whitespace */

("int")|("float")|("char")|("case")|("default")|("if")|("for")|("printf")|("scanf") {
    printf("%s is a keyword\n", yytext);
}

{id}             {
    printf("%s is an identifier\n", yytext);
    count++;
}

{notid}          {
    printf("%s is not an identifier\n", yytext);
}

{digit}+         { /* Matches a number so that notid doesn't match it*/ }
%%

int main() {
    FILE *fp;
    char file[256]; // Increased buffer size and safer input

    printf("\nEnter the filename: ");
    // Use fgets to prevent buffer overflow
    if (fgets(file, sizeof(file), stdin) == NULL) {
        perror("Error reading filename");
        return 1;
    }

    // Remove trailing newline character (if present)
    size_t len = strlen(file);
    if (len > 0 && file[len - 1] == '\n') {
        file[len - 1] = '\0';
    }

    fp = fopen(file, "r");
    if (fp == NULL) {
        perror("Error opening file");
        return 1;
    }

    yyin = fp;
    yylex();

    printf("Total identifiers are: %d\n", count);

    fclose(fp); // Close the file
    return 0;
}