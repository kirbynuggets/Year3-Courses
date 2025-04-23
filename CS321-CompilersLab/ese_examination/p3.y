%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
void yyerror(const char *s);
int valid_sql = 1;
%}

%union {
    double numval;
    char *strval;
}

%token SELECT FROM WHERE AND OR
%token GEQ LEQ GT LT EQ
%token PLUS MINUS MULT DIV
%token LPAREN RPAREN
%token QUOTE COMMENT SEMICOLON
%token <strval> ID
%token <numval> NUMBER

%type <numval> expr term factor

%%
sql_statement : SELECT column_list FROM table_list where_clause
              ;

column_list : '*'
           | ID
           | ID ',' column_list
           ;

table_list : ID
          | ID ',' table_list
          ;

where_clause : /* empty */
             | WHERE condition
             ;

condition : expr_condition
          | expr_condition AND condition
          | expr_condition OR condition
          ;

expr_condition : ID comparison arithmetic_expr
               ;

comparison : EQ
           | GT
           | LT
           | GEQ
           | LEQ
           ;

arithmetic_expr : QUOTE expr QUOTE
                ;

expr : expr PLUS term
     | expr MINUS term
     | term
     ;

term : term MULT factor
     | term DIV factor
     | factor
     ;

factor : LPAREN expr RPAREN
       | ID
       | NUMBER
       ;

%%

void yyerror(const char *s) {
    valid_sql = 0;
}

int main() {
    printf("Enter SQL statement: ");
    yyparse();
    
    if (valid_sql)
        printf("SQL select statement consist by correct arithmetic expression.\n");
    else
        printf("SQL select statement is incorrect or consists by incorrect arithmetic expression.\n");
    
    return 0;
}