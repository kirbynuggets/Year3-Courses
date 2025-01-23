%{
#include <stdio.h>

FILE *docFile;  // File to store documentation comments
%}

%%

\/\*\*([^*]|\*+[^\/])*\*+\/  { 
    fprintf(docFile, "==== Documentation Comment Start ====\n%s\n==== Documentation Comment End ====\n\n", yytext);
}   // Match documentation comments (/** ... */ and store them)

\/\*(.|\n)*?\*\/  ;  // Remove multi-line comments (/* ... */)

\/\/.*  ;  // Remove single-line comments (// ...)

. { 
    fputc(yytext[0], yyout);  // Copy everything else to the output file
}

\n { 
    fputc('\n', yyout);  // Ensure new lines are handled properly
}

%%

int main() {
    yyin = fopen("Q2input.java", "r");  // Open input Java file
    yyout = fopen("Q2output.java", "w"); // Output file without comments
    docFile = fopen("Q2comments.txt", "w"); // Documentation comments output file

    if (yyin == NULL || yyout == NULL || docFile == NULL) {
        printf("Error opening files!\n");
        return 1;
    }

    yylex();  // Start lexical analysis

    fclose(yyin);
    fclose(yyout);
    fclose(docFile);

    printf("Processing complete. Check Q2output.java for code without comments.\n");
    printf("Check Q2comments.txt for extracted documentation comments.\n");

    return 0;
}

int yywrap() {
    return 1;
}
