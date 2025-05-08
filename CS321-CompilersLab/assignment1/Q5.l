/*Write a LEX program to verify whether a date (format: dd/mm/YYYY) is valid or not.
Input: 12/10/2023 12/22/2021 Output. Valid Invalid.*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function to check if a year is a leap year
int is_leap_year(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

// Function to validate a date
int validate_date(int day, int month, int year) {
    if (year < 1000 || year > 9999)
        return 0;
    if (month < 1 || month > 12)
        return 0;

    int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (is_leap_year(year))
        days_in_month[1] = 29; // February has 29 days in a leap year

    return day >= 1 && day <= days_in_month[month - 1];
}
%}

%%

([0-9]{2})\/([0-9]{2})\/([0-9]{4}) {
    int day, month, year;
    sscanf(yytext, "%d/%d/%d", &day, &month, &year);
    if (validate_date(day, month, year))
        printf("Valid: %s\n", yytext);
    else
        printf("Invalid: %s\n", yytext);
}

.|\n ; // Ignore other characters

%%

int main() {
    printf("Enter dates in the format dd/mm/YYYY (end input with Ctrl+D):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
