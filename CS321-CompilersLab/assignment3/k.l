%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int count = 0;
    int idc = 0;
    int max = 1000;
    char *identifiers[max];

    void add(char *c) {
        for (int i = 0; i < idc; i++) {
            if (strcmp(identifiers[i], c) == 0) {
                return; 
            }
        }

        if (idc < max) {
            identifiers[idc++] = strdup(c);
        } else {
            printf("Warning: Identifier limit reached!\n");
        }
    }
%}

identifier      [a-zA-Z_][a-zA-Z0-9_]*
preprocessor    "#"[^(\n)]*
single  "//".*
multi   "/"([^]|\+[^/])\+"/"
space           [\t\n\r ]+
others          .
keyword  "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"
function "printf"|"scanf"|"gets"|"puts"|"fopen"|"fclose"|"fscanf"|"fprintf"|"malloc"|"free"|"exit"|"atoi"|"atof"|"abs"|"ceil"|"floor"|"sqrt"|"pow"|"cos"|"sin"|"tan"|"log"|"exp"

%%

{keyword}   ;
{function}       ; 
{preprocessor}   ; 
{single} ;
{multi}  ;  
{space}          ;  
{others}         ; 
{identifier}     {add(yytext); count++;}

%%

int main() {
    extern FILE *yyin;
    yyin = fopen("input.txt", "r");

    yylex();

    for (int i = 0; i < idc; i++) {
        printf("Identifier found: %s\n", identifiers[i]);
    }
    printf("No. of unique identifiers: %d\n", idc);

    return 0;
}

int yywrap() {
    return 1;
}