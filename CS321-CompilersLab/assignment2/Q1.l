%{
#include <stdio.h>
#include <stdlib.h>

FILE *yyin, *yyout; // Declare yyin and yyout
%}

%option noyywrap

%%

\/\/.*          { /* Ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+\/ { /* Ignore multi-line comments */ }
.|\n              { ECHO; }     // Match and write non-comment lines to output
%%

int main() {
    yyin = fopen("Q1input.java", "r");
    if (!yyin) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    yyout = fopen("Q1output.java", "w");
    if (!yyout) {
        perror("Error opening output file");
        fclose(yyin);
        return EXIT_FAILURE;
    }

    yylex(); // Process the input file

    fclose(yyin);
    fclose(yyout);
    return 0;
}