/*Write a LEX program to identify the articles present in an English sentence that will be 
entered from the keyboard.*/

%{
#include <stdio.h>
int i = 0;              // Counter for articles
%}

%%

a|A|an|An|AN|the|The|THE   {printf("Article found: %s\n", yytext); i++;} /* Match articles and increment counter */

.|\n|[a-zA-Z]+|[0-9]+|[\t]+      ; /* Ignore all other characters */

%%

int main() {
    printf("Enter a sentence in English:\n");
    yylex();                        // Start lexical analysis
    printf("\nTotal number of articles found: %d\n", i);
    return 0;
}

int yywrap() {
    return 1;
}
