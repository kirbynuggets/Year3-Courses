%{
#include <stdio.h>
#include <string.h>

int identifier_count = 0;
char identifiers[100][50]; // Array to store identifiers, avoid duplicates
int identifier_index = 0;

int isKeyword(char *str); // Forward declaration
int alreadyCounted(char *str);
void printIdentifiers(); // Function to print the found identifiers.
%}

DIGIT   [0-9]
LETTER  [a-zA-Z]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*

%%

"/*"(.|\n)*"*/"   { /* Ignore multi-line comments */ }
"//".*              { /* Ignore single-line comments */ }
"#".*               { /* Ignore preprocessor directives */ }

"printf"              {
                          if (!alreadyCounted(yytext)) {
                            strcpy(identifiers[identifier_index++], yytext);
                            identifier_count++;
                          }
                        }

\"[^\"]*\"          { /* Ignore strings within double quotes */ }
\'[^\']*\'          { /* Ignore characters within single quotes */ }

{IDENTIFIER}        {
                        if (!isKeyword(yytext) && !alreadyCounted(yytext)) {
                          strcpy(identifiers[identifier_index++], yytext);
                          identifier_count++;
                        }
                      }

{DIGIT}{LETTER}({LETTER}|{DIGIT})* { /* Ignore invalid identifiers starting with a digit */
                                      printf("Lexical error: Invalid identifier '%s' (starts with a digit)\n", yytext);
                                    }

[ \t\n\r]+           { /* Ignore whitespace */ }
.                    { /* Ignore other characters */ }

%%

int isKeyword(char *str) {
    // Added keywords here.
    char *keywords[] = {
        "int", "float", "char", "double", "void", "if", "else", "while",
        "for", "return", "struct", "union", "enum", "typedef", "static",
        "const", "volatile", "extern", "auto", "register", "goto", "switch",
        "case", "break", "default", "sizeof", "long", "short", "unsigned",
        "signed", "bool", "true", "false", "printf", NULL  //Add printf so that first occurence counts as identifier, but not rest
    };

    for (int i = 0; keywords[i] != NULL; i++) {
        if (strcmp(str, keywords[i]) == 0) {
            return 1; // It's a keyword
        }
    }
    return 0; // Not a keyword
}

int alreadyCounted(char *str) {
  for (int i = 0; i < identifier_index; i++) {
    if (strcmp(str, identifiers[i]) == 0) {
      return 1; // Already counted
    }
  }
  return 0; // Not counted yet
}

void printIdentifiers() {
    printf("Identifiers found:\n");
    for (int i = 0; i < identifier_index; i++) {
        printf("%s\n", identifiers[i]);
    }
}


int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            return 1;
        }
        yyin = file;
    } else {
        printf("Please provide an input file as a command line argument.\n");
        return 1;
    }

    yylex();

    printf("Number of identifiers: %d\n", identifier_count);
    printIdentifiers(); // Call the function to print the identifiers.
    fclose(yyin);
    return 0;
}