%{
#define YYDEBUG 0

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *outfile;

int yyerror(char *s);
int yylex(void);
extern int yylineno;
extern char *yytext;

#include "block.h"

int var_index = 0;
int label_index = 0;

char* new_variable()
{
    char *v = (char*)malloc(20 * sizeof(char));
    sprintf(v, "v%d", var_index++);
    return v;
}

char* new_label()
{
    char *label = (char*)malloc(20 * sizeof(char));
    sprintf(label, "_L%d", label_index++);
    return label;
}

Block* newline()
{
    Block* block = createBlock();
    appendCode(block->code, "\n");
    return block;
}

Block* colon()
{
    Block* block = createBlock();
    appendCode(block->code, " :");
    return block;
}

// Function to concatenate strings and create a new one
char* str_concat(int count, ...) {
    va_list args;
    int total_length = 1; // Start with 1 for the null terminator
    
    // First pass: calculate total length
    va_start(args, count);
    for (int i = 0; i < count; i++) {
        char* str = va_arg(args, char*);
        if (str) total_length += strlen(str);
    }
    va_end(args);
    
    // Allocate memory for the result
    char* result = (char*)malloc(total_length);
    result[0] = '\0'; // Initialize to empty string
    
    // Second pass: concatenate strings
    va_start(args, count);
    for (int i = 0; i < count; i++) {
        char* str = va_arg(args, char*);
        if (str) strcat(result, str);
    }
    va_end(args);
    
    return result;
}
%}


%token AND ASSIGN COLON COMMA DEF DIV DOT ELSE END EQ EXITLOOP FLOAT FLOAT_CONST FORMAT 
%token GE GLOBAL GT ID IF INT INT_CONST LEFT_PAREN LEFT_SQ_BKT LE LT MINUS MOD MULT NE NOT NUL OR PLUS 
%token PRINT PRODUCT READ RIGHT_PAREN RIGHT_SQ_BKT SEMICOLON SKIP STRING WHILE

// Left Associativity
%left PLUS MINUS 
%left MULT DIV MOD
%left DOT
%left AND OR

// Right Associativity
%right NOT

%start code

%union{
    Block* block;
    char* code_str;
}

%type <block> prog stmtListO stmtList epsilon stmt
%type <block> assignmentStmt readStmt printStmt whileStmt ifStmt exitLoop skip
%type <block> exp id indxListO indxList dotId elsePart bExp
%type <code_str> relOP

%%
code                :   prog                                    {
                                                                    fprintf(outfile, "---------------\n"); 
                                                                    printBlock($1); 
                                                                    fprintf(outfile, "---------------\n"); 
                                                                }
prog                :   GLOBAL declList stmtListO END           {
                                                                    $$ = $3;
                                                                }
declList            :   decl declList
                    |   epsilon
decl                :   DEF typeList END
typeList            :   typeList SEMICOLON varList COLON type
                    |   varList COLON type
                    |   typeDef
varList             :   var COMMA varList
                    |   var
var                 :   ID sizeListO
sizeListO           :   sizeList
                    |   epsilon
sizeList            :   sizeList LEFT_SQ_BKT INT_CONST RIGHT_SQ_BKT
                    |   LEFT_SQ_BKT INT_CONST RIGHT_SQ_BKT
type                :   INT
                    |   FLOAT
                    |   STRING
                    |   NUL
                    |   typeDef
                    |   ID
typeDef             :   ID ASSIGN PRODUCT typeList END
stmtListO           :   stmtList
                    |   epsilon
stmtList            :   stmtList SEMICOLON stmt                 {
                                                                    Block *b = createBlock();
                                                                    b->nextBlock = createBlock();
                                                                    $$ = b;

                                                                    if($1->nextBlock==NULL)
                                                                    {
                                                                        $1->nextBlock = createBlock();
                                                                    }
                                                                    appendCode($1->nextBlock->code, new_label());
                                                                    $3->nextBlock = b->nextBlock;

                                                                    concatBlock(b, $1);

                                                                    Block *_1_next = createBlock();
                                                                    _1_next->labelBlock = &($1->nextBlock);

                                                                    concatBlock(b, _1_next);
                                                                    concatBlock(b, colon());
                                                                    concatBlock(b, newline());
                                                                    concatBlock(b, $3);
                                                                }
                    |   stmt                                    {
                                                                    if($1->nextBlock == NULL)
                                                                    {   
                                                                        $1->nextBlock = createBlock();
                                                                    }
                                                                    appendCode($1->nextBlock->code, new_label());

                                                                    Block *b = createBlock();
                                                                    concatBlock(b, $1);

                                                                    Block *_1_next = createBlock();
                                                                    _1_next->labelBlock = &($1->nextBlock);
                                                                    concatBlock(b, _1_next);
                                                                    concatBlock(b, colon());
                                                                    concatBlock(b, newline());

                                                                    $$ = b;
                                                                }
stmt                :   assignmentStmt
                    |   readStmt
                    |   printStmt
                    |   ifStmt
                    |   whileStmt
                    |   exitLoop                        { $$ = createBlock(); }
                    |   skip                           { $$ = createBlock(); }
assignmentStmt      :   dotId ASSIGN exp            {
                                                        char *c = str_concat(3, $1->var, " = ", $3->var);
                                                        Block *b = createBlock();
                                                        appendCode(b->code, c);
                                                        free(c);

                                                        concatBlock(b, newline());
                                                        concatBlock($3, b);
                                                        $$ = $3;
                                                    }           
dotId               :   id                          
                    |   id DOT dotId                {
                                                        char *c = str_concat(3, $1->var, ".", $3->var);
                                                        Block *b = createBlock();
                                                        appendCode(b->code, c);
                                                        
                                                        free($1->var);
                                                        $1->var = strdup(c);
                                                        free(c);
                                                        
                                                        $$ = $1;
                                                    }   
readStmt            :   READ FORMAT exp             {
                                                        char *c = str_concat(5, $<code_str>1, " ", $<code_str>2, " ", $3->var);
                                                        Block *b = createBlock();
                                                        appendCode(b->code, c);
                                                        free(c);

                                                        $$ = b;
                                                    }
printStmt           :   PRINT STRING                {
                                                        char *c = str_concat(3, $<code_str>1, " ", $<code_str>2);
                                                        Block *b = createBlock();
                                                        appendCode(b->code, c);
                                                        free(c);

                                                        $$ = b;
                                                    }
                    |   PRINT FORMAT exp            {
                                                        char *c = str_concat(5, $<code_str>1, " ", $<code_str>2, " ", $3->var);
                                                        Block *b = createBlock();
                                                        appendCode(b->code, c);
                                                        free(c);

                                                        $$ = b;
                                                    }
ifStmt              :   IF bExp COLON stmtList elsePart END     {
                                                                    appendCode($2->trueBlock->code, new_label());

                                                                    Block *b = createBlock();
                                                                    b->nextBlock = createBlock();
                                                                    $$ = b;

                                                                    if($5==NULL)
                                                                    {
                                                                        $2->falseBlock = b->nextBlock;

                                                                        $4->nextBlock = b->nextBlock;

                                                                        concatBlock(b, $2);

                                                                        Block* _2_true = createBlock();
                                                                        _2_true->labelBlock = &($2->trueBlock);

                                                                        concatBlock(b, _2_true);
                                                                        concatBlock(b, colon());
                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock(b, $4);
                                                                    }
                                                                    else
                                                                    {
                                                                        // Handle else part
                                                                        $5->nextBlock = b->nextBlock;
                                                                        appendCode($2->falseBlock->code, new_label());
                                                                        $2->falseBlock = $5->nextBlock;
                                                                        $4->nextBlock = b->nextBlock;

                                                                        concatBlock(b, $2);

                                                                        Block* _2_true = createBlock();
                                                                        _2_true->labelBlock = &($2->trueBlock);

                                                                        concatBlock(b, _2_true);
                                                                        concatBlock(b, colon());
                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock(b, $4);

                                                                        Block* goto_block = createBlock();
                                                                        appendCode(goto_block->code, "goto ");

                                                                        Block* _next_block = createBlock();
                                                                        _next_block->labelBlock = &(b->nextBlock);
                                                                        
                                                                        concatBlock(goto_block, _next_block);
                                                                        concatBlock(b, goto_block);
                                                                        concatBlock(b, newline());

                                                                        Block* _5_next = createBlock();
                                                                        _5_next->labelBlock = &($5->nextBlock);

                                                                        concatBlock(b, _5_next);
                                                                        concatBlock(b, colon());
                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock(b, $5);
                                                                    }
                                                                }
elsePart            :   ELSE stmtList                           {   $$ = $2;    }
                    |   epsilon                                 {   $$ = NULL;  }
whileStmt           :   WHILE bExp COLON stmtList END           {
                                                                    char *begin = new_label();
                                                                    appendCode($2->trueBlock->code, new_label());

                                                                    Block* b = createBlock();
                                                                    $$ = b;
                                                                    b->nextBlock = createBlock();

                                                                    $2->falseBlock = b->nextBlock;
                                                                    if($4->nextBlock==NULL)
                                                                        $4->nextBlock = createBlock();
                                                                    appendCode($4->nextBlock->code, begin);

                                                                    Block* _begin = createBlock();
                                                                    _begin->labelBlock = &($4->nextBlock);

                                                                    concatBlock(b, _begin);
                                                                    concatBlock(b, colon());
                                                                    concatBlock(b, newline());

                                                                    concatBlock(b, $2);

                                                                    Block* b_true = createBlock();
                                                                    b_true->labelBlock = &($2->trueBlock);

                                                                    concatBlock(b, b_true);
                                                                    concatBlock(b, colon());
                                                                    concatBlock(b, newline());
                                                                    concatBlock(b, $4);

                                                                    Block* nb = createBlock();
                                                                    appendCode(nb->code, "goto ");

                                                                    concatBlock(b, nb);

                                                                    Block* _begin2 = createBlock();
                                                                    _begin2->labelBlock = &($4->nextBlock);

                                                                    concatBlock(b, _begin2);
                                                                    concatBlock(b, newline());
                                                                    
                                                                    free(begin);
                                                                }
exitLoop            :   EXITLOOP
skip                :   SKIP
id                  :   ID indxListO                {
                                                        char *c = str_concat(2, $<code_str>1, $2->code->code);
                                                        $$ = createBlock();
                                                        free($$->var);
                                                        $$->var = c;
                                                    }   
indxListO           :   indxList
                    |   epsilon
indxList            :   indxList LEFT_SQ_BKT exp RIGHT_SQ_BKT       {
                                                                        char *c = str_concat(4, $1->code->code, $<code_str>2, $3->var, $<code_str>4);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        $$ = b;
                                                                    }   
                    |   LEFT_SQ_BKT exp RIGHT_SQ_BKT                {
                        char *c = str_concat(3, $<code_str>1, $2->var, $<code_str>3);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        $$ = b;
                                                                    }
exp                 :   exp PLUS exp                                 {
                                                                        char *temp = new_variable();
                                                                        char *c = str_concat(5, temp, " = ", $1->var, " + ", $3->var);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock($1, $3);
                                                                        concatBlock($1, b);
                                                                        
                                                                        free($1->var);
                                                                        $1->var = temp;
                                                                        
                                                                        $$ = $1;
                                                                    }
                    |   exp MINUS exp                                {
                                                                        char *temp = new_variable();
                                                                        char *c = str_concat(5, temp, " = ", $1->var, " - ", $3->var);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock($1, $3);
                                                                        concatBlock($1, b);
                                                                        
                                                                        free($1->var);
                                                                        $1->var = temp;
                                                                        
                                                                        $$ = $1;
                                                                    }
                    |   exp MULT exp                                 {
                                                                        char *temp = new_variable();
                                                                        char *c = str_concat(5, temp, " = ", $1->var, " * ", $3->var);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock($1, $3);
                                                                        concatBlock($1, b);
                                                                        
                                                                        free($1->var);
                                                                        $1->var = temp;
                                                                        
                                                                        $$ = $1;
                                                                    }
                    |   exp DIV exp                                  {
                                                                        char *temp = new_variable();
                                                                        char *c = str_concat(5, temp, " = ", $1->var, " / ", $3->var);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock($1, $3);
                                                                        concatBlock($1, b);
                                                                        
                                                                        free($1->var);
                                                                        $1->var = temp;
                                                                        
                                                                        $$ = $1;
                                                                    }
                    |   exp MOD exp                                  {
                                                                        char *temp = new_variable();
                                                                        char *c = str_concat(5, temp, " = ", $1->var, " % ", $3->var);
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);

                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock($1, $3);
                                                                        concatBlock($1, b);
                                                                        
                                                                        free($1->var);
                                                                        $1->var = temp;
                                                                        
                                                                        $$ = $1;
                                                                    }
                    |   LEFT_PAREN exp RIGHT_PAREN                  {
                                                                        $$ = $2;
                                                                    }
                    |   INT_CONST                                    {
                                                                        Block *b = createBlock();
                                                                        free(b->var);
                                                                        b->var = $<code_str>1;
                                                                        $$ = b;
                                                                    }
                    |   FLOAT_CONST                                  {
                                                                        Block *b = createBlock();
                                                                        free(b->var);
                                                                        b->var = $<code_str>1;
                                                                        $$ = b;
                                                                    }
                    |   STRING                                       {
                                                                        Block *b = createBlock();
                                                                        free(b->var);
                                                                        b->var = $<code_str>1;
                                                                        $$ = b;
                                                                    }
                    |   dotId                                        {
                                                                        $$ = $1;
                                                                    }
bExp                :   bExp AND bExp                               {
                                                                        $1->trueBlock = createBlock();
                                                                        $1->falseBlock = $3->falseBlock;
                                                                        $3->trueBlock = createBlock();
                                                                        
                                                                        char *l1 = new_label();
                                                                        appendCode($1->trueBlock->code, l1);
                                                                        
                                                                        Block *b = createBlock();
                                                                        Block *_1_true = createBlock();
                                                                        _1_true->labelBlock = &($1->trueBlock);
                                                                        
                                                                        concatBlock(b, $1);
                                                                        concatBlock(b, _1_true);
                                                                        concatBlock(b, colon());
                                                                        concatBlock(b, newline());
                                                                        concatBlock(b, $3);
                                                                        
                                                                        b->trueBlock = $3->trueBlock;
                                                                        b->falseBlock = $3->falseBlock;
                                                                        
                                                                        $$ = b;
                                                                        free(l1);
                                                                    }
                    |   bExp OR bExp                                {
                                                                        $1->falseBlock = createBlock();
                                                                        $1->trueBlock = $3->trueBlock;
                                                                        $3->falseBlock = createBlock();
                                                                        
                                                                        char *l1 = new_label();
                                                                        appendCode($1->falseBlock->code, l1);
                                                                        
                                                                        Block *b = createBlock();
                                                                        Block *_1_false = createBlock();
                                                                        _1_false->labelBlock = &($1->falseBlock);
                                                                        
                                                                        concatBlock(b, $1);
                                                                        concatBlock(b, _1_false);
                                                                        concatBlock(b, colon());
                                                                        concatBlock(b, newline());
                                                                        concatBlock(b, $3);
                                                                        
                                                                        b->trueBlock = $3->trueBlock;
                                                                        b->falseBlock = $3->falseBlock;
                                                                        
                                                                        $$ = b;
                                                                        free(l1);
                                                                    }
                    |   NOT bExp                                    {
                                                                        Block *b = createBlock();
                                                                        concatBlock(b, $2);
                                                                        b->trueBlock = $2->falseBlock;
                                                                        b->falseBlock = $2->trueBlock;
                                                                        $$ = b;
                                                                    }
                    |   exp relOP exp                               {
                                                                        char *temp = new_variable();
                                                                        char *c = str_concat(5, temp, " = ", $1->var, " ", $<code_str>2);
                                                                        char *c2 = str_concat(2, c, " ");
                                                                        free(c);
                                                                        c = str_concat(2, c2, $3->var);
                                                                        free(c2);
                                                                        
                                                                        Block *b = createBlock();
                                                                        appendCode(b->code, c);
                                                                        free(c);
                                                                        concatBlock(b, newline());
                                                                        
                                                                        concatBlock($1, $3);
                                                                        concatBlock($1, b);
                                                                        
                                                                        $$ = $1;
                                                                        $$->trueBlock = createBlock();
                                                                        $$->falseBlock = createBlock();
                                                                        
                                                                        Block *ifBlock = createBlock();
                                                                        appendCode(ifBlock->code, "if ");
                                                                        appendCode(ifBlock->code, temp);
                                                                        appendCode(ifBlock->code, " goto ");
                                                                        
                                                                        Block *gotoFalse = createBlock();
                                                                        appendCode(gotoFalse->code, "goto ");
                                                                        
                                                                        concatBlock($$, ifBlock);
                                                                        
                                                                        Block *_true = createBlock();
                                                                        _true->labelBlock = &($$->trueBlock);
                                                                        
                                                                        concatBlock($$, _true);
                                                                        concatBlock($$, newline());
                                                                        concatBlock($$, gotoFalse);
                                                                        
                                                                        Block *_false = createBlock();
                                                                        _false->labelBlock = &($$->falseBlock);
                                                                        
                                                                        concatBlock($$, _false);
                                                                        concatBlock($$, newline());
                                                                        
                                                                        free(temp);
                                                                    }
                    |   LEFT_PAREN bExp RIGHT_PAREN                 {   $$ = $2;    }
relOP               :   LT                                          {   $$ = $1;    }
                    |   LE                                          {   $$ = $1;    }
                    |   GT                                          {   $$ = $1;    }
                    |   GE                                          {   $$ = $1;    }
                    |   EQ                                          {   $$ = $1;    }
                    |   NE                                          {   $$ = $1;    }
epsilon             :                                               {   $$ = createBlock();   }
%%

int yyerror(char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <input_file> <output_file>\n", argv[0]);
        return 1;
    }
    
    FILE *input = fopen(argv[1], "r");
    if (!input) {
        printf("Could not open input file %s\n", argv[1]);
        return 1;
    }
    
    outfile = fopen(argv[2], "w");
    if (!outfile) {
        printf("Could not open output file %s\n", argv[2]);
        fclose(input);
        return 1;
    }
    
    // Set input to yyin
    extern FILE *yyin;
    yyin = input;
    
    // Parse the input
    yyparse();
    
    // Clean up
    fclose(input);
    fclose(outfile);
    
    return 0;
}                                                                