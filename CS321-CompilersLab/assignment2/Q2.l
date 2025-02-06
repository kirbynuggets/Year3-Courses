%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *yyin, *yyout, *yydoc; 

void format_and_write_doc(const char* doc_comment);
%}

%option noyywrap

%%

"/**"([^*]|\*+[^*/])*\*+\/ { 
    
    char* doc_comment = strdup(yytext); 
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

    yylex(); 

    fclose(yyin);
    fclose(yyout);
    fclose(yydoc);
    return 0;
}


void format_and_write_doc(const char* doc_comment) {
    char* formatted_comment = (char*)malloc(strlen(doc_comment) + 1);
    if (formatted_comment == NULL) {
        perror("Memory allocation error");
        exit(EXIT_FAILURE);
    }
    
    char* p = formatted_comment;

    
    const char* start = doc_comment + 3;
    const char* end = strstr(doc_comment, "*/");

    if (end == NULL) {
        end = doc_comment + strlen(doc_comment);
    }
    
    
    while (start < end) {
        
        while (*start == ' ' || *start == '\t' || *start == '*') {
            start++;
        }

        
        const char* eol = strchr(start, '\n');
        if (eol == NULL) {
            eol = end;
        }

       
        while (start < eol) {
            *p++ = *start++;
        }

        
        if (start < end) {
            *p++ = '\n';
        }

        start = eol + 1; 
    }
    *p = '\0';

    
    fprintf(yydoc, "%s\n\n", formatted_comment);

    free(formatted_comment);
}