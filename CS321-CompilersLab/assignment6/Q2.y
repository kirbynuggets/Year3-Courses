
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h> 

void yyerror(const char *s);
int yylex();
void check_verb_agreement(char *subject, char *verb);
void check_main_verb_agreement(char *subject, char *verb);
int is_third_person_singular(char *subject);
void free_string(char *str);
extern FILE *yyin;
%}

%union {
    char *str;
}

%token <str> PRONOUN COMMON_NOUN ARTICLE ADJECTIVE VERB PERIOD
%token <str> IS ARE WAS WERE AM
%type <str> noun_phrase helping_verb

%%

sentences:
    sentence
    | sentences sentence
    ;

sentence:
    simple_sentence PERIOD { printf("Valid Sentence.\n"); }
    ;

simple_sentence:
    noun_phrase VERB { 
        check_main_verb_agreement($1, $2); 
        free_string($1);
        free_string($2);
    }
    | noun_phrase helping_verb adjective_phrase { 
        check_verb_agreement($1, $2); 
        free_string($1);
        free_string($2);
    }
    ;

noun_phrase:
    ARTICLE COMMON_NOUN { $$ = $2; } 
    | ARTICLE ADJECTIVE COMMON_NOUN { $$ = $3; }
    | PRONOUN { $$ = $1; }
    ;

helping_verb:
    IS { $$ = $1; }
    | ARE { $$ = $1; }
    | WAS { $$ = $1; }
    | WERE { $$ = $1; }
    | AM { $$ = $1; }
    ;

adjective_phrase:
    ADJECTIVE { free_string($1); }
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

void free_string(char *str) {
    if (str) free(str);
}

int is_third_person_singular(char *subject) {
    // Check against third person singular pronouns
    const char *third_person_pronouns[] = {"he", "she", "it"};
    for (int i = 0; i < sizeof(third_person_pronouns)/sizeof(char *); i++) {
        if (strcasecmp(subject, third_person_pronouns[i]) == 0) {
            return 1;
        }
    }

    // Check against common singular nouns
    const char *singular_nouns[] = {"boy", "girl", "man", "woman", "dog", "cat", "bird"};
    for (int i = 0; i < sizeof(singular_nouns)/sizeof(char *); i++) {
        if (strcasecmp(subject, singular_nouns[i]) == 0) {
            return 1;
        }
    }

    return 0;
}

void check_main_verb_agreement(char *subject, char *verb) {
    // For third person singular subjects with present tense verbs
    if (is_third_person_singular(subject)) {
        // Check if verb ends with 's' (simplified check)
        int len = strlen(verb);
        if (len > 0 && verb[len-1] != 's') {
            printf("Error: Subject '%s' requires a third-person-singular verb form (ending with 's').\n", subject);
            exit(1);
        }
    } else {
        // For non-third person subjects, verb should NOT end with 's'
        int len = strlen(verb);
        if (len > 0 && verb[len-1] == 's') {
            printf("Error: Subject '%s' requires a non-third-person verb form (without ending 's').\n", subject);
            exit(1);
        }
    }
}

void check_verb_agreement(char *subject, char *verb) {
    // Convert subject to lowercase for consistent comparison
    char *subject_lower = strdup(subject);
    for (int i = 0; subject_lower[i]; i++) {
        subject_lower[i] = tolower(subject_lower[i]);
    }

    if (strcmp(verb, "is") == 0) {
        if (strcmp(subject_lower, "i") == 0 || 
            strcmp(subject_lower, "they") == 0 || 
            strcmp(subject_lower, "we") == 0 || 
            strcmp(subject_lower, "you") == 0) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Use 'are' instead of 'is' with 'I', 'they', 'we', or 'you'."); 
            exit(1);
        }
        if (strcmp(subject_lower, "he") != 0 && 
            strcmp(subject_lower, "she") != 0 && 
            strcmp(subject_lower, "it") != 0 && 
            !is_third_person_singular(subject)) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Use 'is' only with third person singular subjects.");
            exit(1);
        }
    } else if (strcmp(verb, "are") == 0) {
        if (strcmp(subject_lower, "he") == 0 || 
            strcmp(subject_lower, "she") == 0 || 
            strcmp(subject_lower, "it") == 0 || 
            is_third_person_singular(subject)) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Use 'is' instead of 'are' with third person singular subjects."); 
            exit(1);
        }
    } else if (strcmp(verb, "was") == 0) {
        if (strcmp(subject_lower, "they") == 0 || 
            strcmp(subject_lower, "we") == 0 || 
            strcmp(subject_lower, "you") == 0) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Use 'were' instead of 'was' with 'they', 'we', or 'you'."); 
            exit(1);
        }
        if (strcmp(subject_lower, "i") != 0 && 
            strcmp(subject_lower, "he") != 0 && 
            strcmp(subject_lower, "she") != 0 && 
            strcmp(subject_lower, "it") != 0 && 
            !is_third_person_singular(subject)) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Use 'was' only with first person singular and third person singular subjects.");
            exit(1);
        }
    } else if (strcmp(verb, "were") == 0) {
        if (strcmp(subject_lower, "i") == 0 || 
            strcmp(subject_lower, "he") == 0 || 
            strcmp(subject_lower, "she") == 0 || 
            strcmp(subject_lower, "it") == 0 || 
            is_third_person_singular(subject)) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Use 'was' instead of 'were' with first person singular and third person singular subjects."); 
            exit(1);
        }
    } else if (strcmp(verb, "am") == 0) {
        if (strcmp(subject_lower, "i") != 0) {
            free(subject_lower);
            yyerror("Incorrect verb agreement! Only 'I am' is correct."); 
            exit(1);
        }
    }
    
    free(subject_lower);
}

int main(int argc, char *argv[]) {
    printf("Enter a sentence (end with a period):\n");
    
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    
    yyparse();
    return 0;
}