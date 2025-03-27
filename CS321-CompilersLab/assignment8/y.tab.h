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
    REQUEST = 258,                 /* REQUEST  */
    GIVE = 259,                    /* GIVE  */
    SHOW = 260,                    /* SHOW  */
    UPDATE = 261,                  /* UPDATE  */
    ME = 262,                      /* ME  */
    THE = 263,                     /* THE  */
    ALL = 264,                     /* ALL  */
    INFORMATION = 265,             /* INFORMATION  */
    ROLLNUMBERS = 266,             /* ROLLNUMBERS  */
    ROLLNUMBER = 267,              /* ROLLNUMBER  */
    NAME = 268,                    /* NAME  */
    CPI = 269,                     /* CPI  */
    STUDENTS = 270,                /* STUDENTS  */
    STUDENT = 271,                 /* STUDENT  */
    WHOSE = 272,                   /* WHOSE  */
    HAVING = 273,                  /* HAVING  */
    WITH = 274,                    /* WITH  */
    IS = 275,                      /* IS  */
    ARE = 276,                     /* ARE  */
    MORETHAN = 277,                /* MORETHAN  */
    LESSTHAN = 278,                /* LESSTHAN  */
    EQUALTO = 279,                 /* EQUALTO  */
    NO = 280,                      /* NO  */
    AND = 281,                     /* AND  */
    OF = 282,                      /* OF  */
    NUMBER = 283                   /* NUMBER  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define REQUEST 258
#define GIVE 259
#define SHOW 260
#define UPDATE 261
#define ME 262
#define THE 263
#define ALL 264
#define INFORMATION 265
#define ROLLNUMBERS 266
#define ROLLNUMBER 267
#define NAME 268
#define CPI 269
#define STUDENTS 270
#define STUDENT 271
#define WHOSE 272
#define HAVING 273
#define WITH 274
#define IS 275
#define ARE 276
#define MORETHAN 277
#define LESSTHAN 278
#define EQUALTO 279
#define NO 280
#define AND 281
#define OF 282
#define NUMBER 283

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 21 "Q.y"

    int num;
    char *str;

#line 128 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
