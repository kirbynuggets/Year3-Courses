/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    KINDLY = 258,                  /* KINDLY  */
    FETCH = 259,                   /* FETCH  */
    DISPLAY = 260,                 /* DISPLAY  */
    EVERY = 261,                   /* EVERY  */
    DETAILS = 262,                 /* DETAILS  */
    FOR = 263,                     /* FOR  */
    STUDENTS = 264,                /* STUDENTS  */
    LIST = 265,                    /* LIST  */
    WITH = 266,                    /* WITH  */
    VALUE = 267,                   /* VALUE  */
    HIGHER = 268,                  /* HIGHER  */
    THAN = 269,                    /* THAN  */
    LOWER = 270,                   /* LOWER  */
    SAME = 271,                    /* SAME  */
    AS = 272,                      /* AS  */
    MODIFY = 273,                  /* MODIFY  */
    CHANGE = 274,                  /* CHANGE  */
    TO = 275,                      /* TO  */
    CALLED = 276,                  /* CALLED  */
    ROLL = 277,                    /* ROLL  */
    CPI = 278,                     /* CPI  */
    NAMES = 279,                   /* NAMES  */
    ROLLS = 280,                   /* ROLLS  */
    CPIS = 281,                    /* CPIS  */
    AND = 282,                     /* AND  */
    NUMBERVAL = 283                /* NUMBERVAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define KINDLY 258
#define FETCH 259
#define DISPLAY 260
#define EVERY 261
#define DETAILS 262
#define FOR 263
#define STUDENTS 264
#define LIST 265
#define WITH 266
#define VALUE 267
#define HIGHER 268
#define THAN 269
#define LOWER 270
#define SAME 271
#define AS 272
#define MODIFY 273
#define CHANGE 274
#define TO 275
#define CALLED 276
#define ROLL 277
#define CPI 278
#define NAMES 279
#define ROLLS 280
#define CPIS 281
#define AND 282
#define NUMBERVAL 283

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "Q.y"

    char *str;
    float num;

#line 128 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
