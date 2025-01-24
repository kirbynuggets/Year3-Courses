/*Write a LEX Program to count the number of characters, words, spaces, end of lines in a
given input file.*/

%{
#include <stdio.h>
int lines = 0, words = 0, small_letters = 0, capital_letters = 0, digits = 0, special_chars = 0, spaces = 0;
int in_word = 0;  // Flag to track if inside a word
%}

%%

\n              { lines++; in_word = 0; }              /* Increment lines and reset word flag */
[ \t]+          { spaces++; in_word = 0; }             /* Increment spaces and reset word flag */
[A-Z]           { capital_letters++; if (!in_word) { words++; in_word = 1; } } /* Capital letters and word tracking */
[a-z]           { small_letters++; if (!in_word) { words++; in_word = 1; } } /* Small letters and word tracking */
[0-9]           { digits++; if (!in_word) { words++; in_word = 1; } } /* Digits and word tracking */
[^ \t\nA-Za-z0-9] { special_chars++; in_word = 0; }    /* Special characters reset word flag */

%%

int main(void) {
    FILE *file = fopen("Q4.txt", "r");
    if (!file) {
        printf("Error: Unable to open the file Q4.txt\n");
        return 1;
    }

    yyin = file;  // Set the input file for LEX
    yylex();      // Start lexical analysis

    // Calculate the total characters
    int total_chars = small_letters + capital_letters + digits + special_chars + spaces;

    // Print results
    printf("This file contains:\n");
    printf("\t%d lines\n", lines + 1);  // +1 for the last line
    printf("\t%d words\n", words);
    printf("\t%d small letters\n", small_letters);
    printf("\t%d capital letters\n", capital_letters);
    printf("\t%d digits\n", digits);
    printf("\t%d special characters\n", special_chars);
    printf("\t%d spaces\n", spaces);
    printf("\tIn total %d characters.\n", total_chars);

    fclose(file);  // Close the file
    return 0;
}

int yywrap() {
    return 1;
}