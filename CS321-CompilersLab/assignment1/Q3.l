/*Write a LEX program to identify and display only the small letters in an English sentence 
entered from the keyboard.*/

%{
#include <stdio.h>
%}

%%
[a-z]+   {printf("%s ", yytext);} /* Match all small letters */
.|\n|[A-Z][a-z]+|[0-9]+|[\t]+      ; /* Ignore all other characters */
%%

int main() {
    printf("Enter a sentence in English:\n");
    yylex();                        // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;
}