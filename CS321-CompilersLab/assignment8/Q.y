%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();

/* Global variables for SQL generation */
char *fields[10];
int field_count = 0;
char *table = NULL;
char *condition_field = NULL;
char *condition_op = NULL;
int condition_value = 0;
char *update_field = NULL;
int update_value = 0;
int is_update = 0;
%}

%union {
    int num;
    char *str;
}

%token REQUEST GIVE SHOW UPDATE ME THE ALL INFORMATION 
%token ROLLNUMBERS ROLLNUMBER NAME CPI STUDENTS STUDENT
%token WHOSE HAVING WITH IS ARE MORETHAN LESSTHAN EQUALTO NO AND OF
%token <num> NUMBER
%type <str> field op comparison query_spec condition
%type <num> value

%%

start: request query_type query_spec condition { 
        if (is_update) {
            printf("update Student set %s=%d where %s %s %d;\n", 
                   update_field, update_value, 
                   condition_field, condition_op, condition_value);
        } else {
            printf("select ");
            if (field_count == 0 || strcmp(fields[0], "all the information") == 0) {
                printf("*");
            } else {
                for (int i = 0; i < field_count; i++) {
                    if (strcmp(fields[i], "roll numbers") == 0) {
                        printf("roll");
                    } else if (strcmp(fields[i], "roll number") == 0) {
                        printf("roll");
                    } else {
                        printf("%s", fields[i]);
                    }
                    if (i < field_count - 1) printf(", ");
                }
            }
            printf(" from Student");
            if (condition_field != NULL) {
                printf(" where %s %s %d", condition_field, condition_op, condition_value);
            }
            printf(";\n");
        }
    }
    ;

request: REQUEST { }
    ;

query_type: action
    | ME item_list { }
    | THE field OF target { }
    ;

action: GIVE { }
    | SHOW { }
    | UPDATE { is_update = 1; }
    ;

item_list: ALL THE INFORMATION { 
        fields[0] = "all the information"; 
        field_count = 1; 
    }
    | field_list { }
    ;

field_list: field { 
        fields[field_count++] = $1; 
    }
    | field AND field_list { 
        fields[field_count++] = $1; 
    }
    ;

field: ROLLNUMBERS { $$ = "roll numbers"; }
    | ROLLNUMBER { $$ = "roll number"; }
    | NAME { $$ = "name"; }
    | CPI { $$ = "cpi"; }
    | INFORMATION { $$ = "information"; }
    ;

target: THE STUDENTS { table = "Student"; }
    | THE STUDENT { table = "Student"; }
    ;

query_spec: WHOSE field comparison value { 
        condition_field = $2; 
        condition_op = $3; 
        condition_value = $4; 
    }
    | /* empty */ { $$ = NULL; }
    ;

condition: HAVING field NO value { 
        condition_field = $2; 
        condition_op = "="; 
        condition_value = $4; 
    }
    | WITH field comparison value { 
        condition_field = $2; 
        condition_op = $3; 
        condition_value = $4; 
    }
    | /* empty */ { $$ = NULL; }
    ;

comparison: IS op { $$ = $2; }
    | ARE op { $$ = $2; }
    ;

op: MORETHAN { $$ = ">"; }
    | LESSTHAN { $$ = "<"; }
    | EQUALTO { $$ = "="; }
    ;

value: NUMBER { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter your English query (end with a newline):\n");
    yyparse();
    return 0;
}