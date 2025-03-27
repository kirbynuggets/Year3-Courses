%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char *s);

char generated_query[1000];
%}

%union {
    int num;
    char* str;
}

%token PLEASE GIVE SHOW ME ALL INFORMATION OF THE STUDENTS
%token NAME ROLL CPI WHO HAVING UPDATE TO IS MORE LESS THAN
%token <num> NUMBER
%token <str> COMPARATOR

%type <str> query

%%

input: 
    query { 
        printf("Generated SQL Query: %s\n", $1); 
        strcpy(generated_query, $1);
    }
;

query: 
    PLEASE GIVE ME ALL INFORMATION OF THE STUDENTS {
        $$ = strdup("SELECT * FROM Student;");
    }
    | PLEASE GIVE ME THE NAME OF THE STUDENTS {
        $$ = strdup("SELECT name FROM Student;");
    }
    | PLEASE GIVE ME THE ROLL OF THE STUDENTS {
        $$ = strdup("SELECT roll FROM Student;");
    }
    | PLEASE SHOW NAME ROLL OF THE STUDENTS {
        $$ = strdup("SELECT name, roll FROM Student;");
    }
    | PLEASE GIVE ME NAME ROLL OF THE STUDENTS WHO HAVING CPI COMPARATOR NUMBER {
        char query[200];
        snprintf(query, sizeof(query), 
            "SELECT name, roll FROM Student WHERE cpi %s %d;", 
            $9, $10);
        $$ = strdup(query);
    }
    | PLEASE UPDATE THE CPI OF THE STUDENTS HAVING ROLL IS NUMBER TO NUMBER {
        char query[200];
        snprintf(query, sizeof(query), 
            "UPDATE Student SET cpi = %d WHERE roll = %d;", 
            $11, $8);
        $$ = strdup(query);
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    char input[1000];

    printf("Natural Language to SQL Query Converter\n");
    printf("Enter your query (or 'quit' to exit):\n");

    while (1) {
        printf("> ");
        if (fgets(input, sizeof(input), stdin) == NULL) break;
        
        // Remove newline
        input[strcspn(input, "\n")] = 0;
        
        // Check for quit
        if (strcmp(input, "quit") == 0) break;

        
        yyin = fmemopen(input, strlen(input), "r");
        
        // Parse the query
        if (yyparse() == 0) {
            printf("Query successfully parsed.\n");
        } else {
            printf("Query parsing failed.\n");
        }

        fclose(yyin);
    }

    return 0;
}