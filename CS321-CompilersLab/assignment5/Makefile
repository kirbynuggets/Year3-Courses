# Makefile for the Shift-Reduce Parser

CC = gcc
CFLAGS = -g -Wall

all: parser

parser: lex.yy.c y.tab.c
	$(CC) $(CFLAGS) -o parser y.tab.c lex.yy.c -ly -ll

y.tab.c y.tab.h: Q2.y
	yacc -d Q2.y

lex.yy.c: Q2.l y.tab.h
	lex Q2.l

clean:
	rm -f parser lex.yy.c y.tab.c y.tab.h *.o