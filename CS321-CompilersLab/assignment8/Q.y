%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
void yy_scan_string(const char *str);
%}

%union {
    char *str;
    float num;
}

%token KINDLY FETCH DISPLAY EVERY DETAILS FOR STUDENTS LIST WITH VALUE HIGHER THAN LOWER SAME AS MODIFY CHANGE TO CALLED ROLL CPI NAMES ROLLS CPIS AND
%token <num> NUMBERVAL

%type <str> attr_list attr condition comp select_stmt update_stmt

%%

start: select_stmt { 
            printf("SQL query: %s\n", $1); 
        }
     | update_stmt { 
            printf("SQL query: %s\n", $1); 
        }
     ;

select_stmt: KINDLY FETCH attr_list FOR STUDENTS
           { char *tmp = malloc(100); 
             sprintf(tmp, "select %s from Student", $3); 
             $$ = tmp; }
           | KINDLY DISPLAY EVERY DETAILS FOR STUDENTS
           { char *tmp = malloc(100); 
             sprintf(tmp, "select * from Student"); 
             $$ = tmp; }
           | LIST attr_list FOR STUDENTS
           { char *tmp = malloc(100); 
             sprintf(tmp, "select %s from Student", $2); 
             $$ = tmp; }
           | LIST attr_list FOR STUDENTS WITH condition
           { char *tmp = malloc(100); 
             sprintf(tmp, "select %s from Student where %s", $2, $6); 
             $$ = tmp; }
           ;

update_stmt: MODIFY CPI FOR STUDENTS CALLED NUMBERVAL TO NUMBERVAL
           { char *tmp = malloc(100); 
             sprintf(tmp, "update Student set cpi=%f where roll=%f", $8, $6); 
             $$ = tmp; }
           | CHANGE CPI TO NUMBERVAL FOR STUDENTS WITH ROLL NUMBERVAL
           { char *tmp = malloc(100); 
             sprintf(tmp, "update Student set cpi=%f where roll=%f", $4, $9); 
             $$ = tmp; }
           ;

attr_list: attr { $$ = $1; }
         | attr_list AND attr 
         { char *tmp = malloc(100); 
           sprintf(tmp, "%s, %s", $1, $3); 
           $$ = tmp; }
         ;

attr: NAMES { $$ = "name"; }
    | ROLLS { $$ = "roll"; }
    | CPIS { $$ = "cpi"; }
    ;

condition: CPI VALUE comp NUMBERVAL
         { char *tmp = malloc(100); 
           sprintf(tmp, "cpi %s %f", $3, $4); 
           $$ = tmp; }
         ;

comp: HIGHER THAN { $$ = ">"; }
    | LOWER THAN { $$ = "<"; }
    | SAME AS { $$ = "="; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    char query[256];  
    printf("Enter your query: ");
    if (fgets(query, sizeof(query), stdin) == NULL) {
        perror("Error reading query");
        return 1;
    }
    
    printf("User query: %s", query);

    
    yy_scan_string(query);  
    int result = yyparse();
    return result;
}