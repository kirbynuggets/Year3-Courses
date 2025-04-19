%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int temp_count = 0;
int label_count = 0;

void yyerror(char *s);
int yylex();

char* new_temp() {
    char* temp = (char*)malloc(10);
    sprintf(temp, "t%d", temp_count++);
    return temp;
}

char* new_label() {
    char* label = (char*)malloc(10);
    sprintf(label, "L%d", label_count++);
    return label;
}

void emit(char* op, char* arg1, char* arg2, char* result) {
    printf("%s = %s %s %s\n", result, arg1, op, arg2);
}

void emit_assign(char* src, char* dst) {
    printf("%s = %s\n", dst, src);
}

void emit_label(char* label) {
    printf("%s:\n", label);
}

void emit_jump(char* label) {
    printf("goto %s\n", label);
}

void emit_if(char* cond, char* label) {
    printf("if %s goto %s\n", cond, label);
}

void emit_ifnot(char* cond, char* label) {
    printf("ifFalse %s goto %s\n", cond, label);
}
%}

%union {
    char* str;
    int num;
}

%token INT IF ELSE WHILE EQ NE LE GE LT GT
%token <str> ID
%token <num> NUM

%type <str> expr term factor stmt stmt_list condition decl

%left '+' '-'
%left '*' '/' MOD  
%token MOD  

%%

program: stmt_list
    ;

stmt_list: stmt
    | stmt_list stmt
    ;

stmt: decl                        { $$ = $1; }
    | ID '=' expr ';'            { emit_assign($3, $1); free($1); free($3); $$ = NULL; }
    | IF '(' condition ')' stmt  { 
        char* else_label = new_label();
        char* end_label = new_label();
        
        // Skip if condition is false
        emit_ifnot($3, else_label);
        
        // "then" part was here
        
        emit_jump(end_label);
        emit_label(else_label);
        // "else" part would be here if we had an else clause
        emit_label(end_label);
        
        free($3);
        free(else_label);
        free(end_label);
        $$ = NULL;
    }
    | WHILE '(' condition ')' stmt { 
        char* start_label = new_label();
        char* end_label = new_label();
        
        // Start of loop
        emit_label(start_label);
        
        // If condition is false, exit loop
        emit_ifnot($3, end_label);
        
        // Loop body is handled by the nested stmt rule
        
        // Go back to check condition
        emit_jump(start_label);
        
        // End of loop
        emit_label(end_label);
        
        free($3);
        free(start_label);
        free(end_label);
        $$ = NULL;
    }
    | '{' stmt_list '}'          { $$ = NULL; }
    ;

decl: INT ID ';'                 { emit_assign("0", $2); $$ = $2; }
    | INT ID '=' expr ';'       { emit_assign($4, $2); $$ = $2; free($4); }
    ;

condition: expr EQ expr          { $$ = new_temp(); emit("==", $1, $3, $$); free($1); free($3); }
    | expr NE expr              { $$ = new_temp(); emit("!=", $1, $3, $$); free($1); free($3); }
    | expr LE expr              { $$ = new_temp(); emit("<=", $1, $3, $$); free($1); free($3); }
    | expr GE expr              { $$ = new_temp(); emit(">=", $1, $3, $$); free($1); free($3); }
    | expr LT expr              { $$ = new_temp(); emit("<", $1, $3, $$); free($1); free($3); }
    | expr GT expr              { $$ = new_temp(); emit(">", $1, $3, $$); free($1); free($3); }
    ;

expr: expr '+' term              { $$ = new_temp(); emit("+", $1, $3, $$); free($1); free($3); }
    | expr '-' term             { $$ = new_temp(); emit("-", $1, $3, $$); free($1); free($3); }
    | term                      { $$ = $1; }
    ;

term: term '*' factor           { $$ = new_temp(); emit("*", $1, $3, $$); free($1); free($3); }
    | term '/' factor          { $$ = new_temp(); emit("/", $1, $3, $$); free($1); free($3); }
    | term MOD factor          { $$ = new_temp(); emit("%", $1, $3, $$); free($1); free($3); }
    | factor                   { $$ = $1; }
    ;

factor: ID                      { $$ = $1; }
    | NUM                      { $$ = (char*)malloc(20); sprintf($$, "%d", $1); }
    | '(' expr ')'             { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}