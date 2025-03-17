typedef struct symbtbl {
    char* columns;
    char* tables;
    int linenum;
    struct symbtbl* next;
} symbtbl;

symbtbl* putsymb(char* cols, char* tables, int linenum);