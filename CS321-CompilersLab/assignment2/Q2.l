%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *yyin, *yyout, *yydoc; // Declare yyin, yyout, and yydoc

void format_and_write_doc(const char* doc_comment);
%}

%option noyywrap

%%

"/**"([^*]|\*+[^*/])*\*+\/ { 
    // Extract and format documentation comment
    char* doc_comment = strdup(yytext); // Create a copy to modify
    format_and_write_doc(doc_comment);
    free(doc_comment); 
}
\/\/.*          { /* Ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+\/ { /* Ignore multi-line comments */ }


%%

int main() {
    yyin = fopen("Q2input.java", "r");
    if (!yyin) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    yyout = fopen("Q2output.java", "w");
    if (!yyout) {
        perror("Error opening output file");
        fclose(yyin);
        return EXIT_FAILURE;
    }

    yydoc = fopen("Q2comments.txt", "w");
    if (!yydoc) {
        perror("Error opening documentation file");
        fclose(yyin);
        fclose(yyout);
        return EXIT_FAILURE;
    }

    yylex(); // Process the input file

    fclose(yyin);
    fclose(yyout);
    fclose(yydoc);
    return 0;
}

// Function to format and write documentation comments
void format_and_write_doc(const char* doc_comment) {
    char* formatted_comment = (char*)malloc(strlen(doc_comment) + 1);
    if (formatted_comment == NULL) {
        perror("Memory allocation error");
        exit(EXIT_FAILURE);
    }
    
    char* p = formatted_comment;

    // Remove "/**" and "*/"
    const char* start = doc_comment + 3;
    const char* end = strstr(doc_comment, "*/");

    if (end == NULL) {
        end = doc_comment + strlen(doc_comment);
    }
    
    // Copy and format lines
    while (start < end) {
        // Trim leading spaces and asterisks
        while (*start == ' ' || *start == '\t' || *start == '*') {
            start++;
        }

        // Find end of line
        const char* eol = strchr(start, '\n');
        if (eol == NULL) {
            eol = end;
        }

        // Copy line
        while (start < eol) {
            *p++ = *start++;
        }

        // Add newline if not at end
        if (start < end) {
            *p++ = '\n';
        }

        start = eol + 1; // Move to next line
    }
    *p = '\0';

    // Write formatted comment to documentation file
    fprintf(yydoc, "%s\n\n", formatted_comment);

    free(formatted_comment);
}