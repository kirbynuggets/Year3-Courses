%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int binaryToDecimal(char *binary);
double binaryFractionToDecimal(char *binary);

%}

%union {
    char *str;
}

%token <str> BINARY_INT BINARY_FLOAT
%token EOL

%%
input:
    binary EOL {
        printf("Conversion successful!\n");
    }
    |
    error EOL {
        yyerror("Invalid binary number!");
    }
    ;

binary:
    BINARY_INT {
        printf("SDT: Converting binary integer %s to decimal.\n", $1);
        int result = binaryToDecimal($1);
        printf("Result: %d (decimal)\n", result);
        free($1);  // Free the allocated memory
    }
    |
    BINARY_FLOAT {
        printf("SDT: Converting binary floating-point %s to decimal.\n", $1);
        
        char *dot = strchr($1, '.');
        *dot = '\0'; // Split integer and fractional parts
        
        int intPart = binaryToDecimal($1);
        double fracPart = binaryFractionToDecimal(dot + 1);
        
        double result = intPart + fracPart;
        printf("Result: %.6f (decimal)\n", result);
        free($1);  // Free the allocated memory
    }
    ;

%%

int binaryToDecimal(char *binary) {
    int decimal = 0, len = strlen(binary);
    for (int i = 0; i < len; i++) {
        if (binary[i] == '1') {
            decimal += pow(2, len - 1 - i);
        }
    }
    return decimal;
}

double binaryFractionToDecimal(char *binary) {
    double decimal = 0.0;
    int len = strlen(binary);
    for (int i = 0; i < len; i++) {
        if (binary[i] == '1') {
            decimal += pow(2, -(i + 1));
        }
    }
    return decimal;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Binary to Decimal Converter\n");
    printf("Enter a binary number (e.g., 101 or 101.11): ");
    yyparse();
    return 0;
}