/*Extend Program 1 to identify the verbs as well.*/

%{
#include <stdio.h>
%}

%%

a|A|an|An|AN|the|The|THE   {printf("Article found: %s\n", yytext);} /* Match articles */
is|am|are|were|was|be|being|been|do|does|did|should|can|could|has|have|had|ought to|go  {printf("Verb found: %s\n", yytext);} /* Match verbs*/
.|\n|[a-zA-Z]+|[0-9]+|[\t]+      ; /* Ignore all other characters */

%%

int main() {
    printf("Enter a sentence in English:\n");
    yylex();                        // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;
}
