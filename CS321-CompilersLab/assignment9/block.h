#ifndef BLOCK_H
#define BLOCK_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *outfile;

typedef struct Code {
    char *code;
    struct Code *next;
} Code;

typedef struct Block {
    Code *code;
    struct Block *trueBlock;
    struct Block *falseBlock;
    struct Block *nextBlock;
    struct Block *next;
    struct Block **labelBlock;
    char *var;
} Block;

// Function to create a new Code node
Code* createCode() {
    Code *newCode = (Code*)malloc(sizeof(Code));
    newCode->code = (char*)malloc(1);
    newCode->code[0] = '\0';
    newCode->next = NULL;
    return newCode;
}

// Function to append string to Code
void appendCode(Code *code, const char *line) {
    int currentLen = strlen(code->code);
    int appendLen = strlen(line);
    code->code = (char*)realloc(code->code, currentLen + appendLen + 1);
    strcat(code->code, line);
}

// Function to print Code
void printCode(Code *code) {
    fprintf(outfile, "%s", code->code);
}

// Function to create a new Block
Block* createBlock() {
    Block *newBlock = (Block*)malloc(sizeof(Block));
    newBlock->code = createCode();
    newBlock->trueBlock = NULL;
    newBlock->falseBlock = NULL;
    newBlock->nextBlock = NULL;
    newBlock->next = NULL;
    newBlock->labelBlock = NULL;
    newBlock->var = (char*)malloc(1);
    newBlock->var[0] = '\0';
    return newBlock;
}

// Function to concatenate a block to another
void concatBlock(Block *block, Block *newblock) {
    Block *ptr = block;
    while (ptr->next != NULL) {
        ptr = ptr->next;
    }
    ptr->next = newblock;
}

// Function to print a Block
void printBlock(Block *block) {
    Block *ptr = block;
    while (ptr != NULL) {
        if (ptr->labelBlock == NULL)
            printCode(ptr->code);
        else
            printBlock(*(ptr->labelBlock));
        ptr = ptr->next;
    }
}

// Function to free a Block and all its resources
void freeBlock(Block *block) {
    if (block == NULL)
        return;
        
    // Free the code
    free(block->code->code);
    free(block->code);
    
    // Free the var
    free(block->var);
    
    // We don't free trueBlock, falseBlock, or labelBlock
    // as they point to other blocks that are freed separately
    
    // Free the next block
    freeBlock(block->next);
    
    // Free this block
    free(block);
}

#endif  