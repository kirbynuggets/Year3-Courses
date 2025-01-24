%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure to store HTML tag and its count
typedef struct {
    char* tag_name;
    int count;
} TagCount;

// Array to store tag counts (you can dynamically resize this if needed)
#define MAX_TAGS 100
TagCount tag_counts[MAX_TAGS];
int num_tags = 0;

// Function to find or add a tag and increment its count
void add_tag(const char* tag_name);

// Function to print the tag counts
void print_tag_counts();
%}

%option noyywrap

%%

"<"[a-zA-Z][a-zA-Z0-9]* { 
    // Extract tag name (excluding '<')
    char* tag_name = strdup(yytext + 1); 
    add_tag(tag_name);
    free(tag_name);
}

"<"\/[a-zA-Z][a-zA-Z0-9]*">" {
    // Extract tag name (excluding '</')
     char* tag_name = strdup(yytext + 2);
     // Remove the trailing '>'
     tag_name[strlen(tag_name) - 1] = '\0';
    add_tag(tag_name);
    free(tag_name);
}

[^<]+    { /* Ignore content outside of tags */ }

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <html_file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return EXIT_FAILURE;
    }

    yylex();

    fclose(yyin);

    print_tag_counts();

    return 0;
}

// Function to find or add a tag and increment its count
void add_tag(const char* tag_name) {
    // Search for existing tag
    for (int i = 0; i < num_tags; i++) {
        if (strcmp(tag_counts[i].tag_name, tag_name) == 0) {
            tag_counts[i].count++;
            return;
        }
    }

    // Add new tag if not found
    if (num_tags < MAX_TAGS) {
        tag_counts[num_tags].tag_name = strdup(tag_name);
        tag_counts[num_tags].count = 1;
        num_tags++;
    } else {
        fprintf(stderr, "Error: Maximum number of tags exceeded.\n");
        exit(EXIT_FAILURE);
    }
}

// Function to print the tag counts
void print_tag_counts() {
    printf("HTML Tag Occurrence Counts:\n");
    for (int i = 0; i < num_tags; i++) {
        printf("%s: %d\n", tag_counts[i].tag_name, tag_counts[i].count);
        free(tag_counts[i].tag_name); // Free the dynamically allocated tag names
    }
}