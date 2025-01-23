%{
#include <stdio.h>
%}

%%

"\/\*[^*]*\*+([^/*][^*]*\*+)*\/" {}     // Match and remove multi-line comments (/* ... */)


"\/\/.*" {}     // Match and remove single-line comments (//...)


.|\n { 
    fputc(yytext[0], yyout);        // Copy everything else to the output file
}

%%

int main() {
    yyin = fopen("Q1input.java", "r");  // Open the input Java file
    yyout = fopen("Q1output.java", "w"); // Output file without comments

    if (yyin == NULL || yyout == NULL) {
        printf("Error opening files!\n");
        return 1;
    }

    yylex();  // Start lexical analysis

    fclose(yyin);
    fclose(yyout);

    return 0;
}

int yywrap() {
    return 1;
}