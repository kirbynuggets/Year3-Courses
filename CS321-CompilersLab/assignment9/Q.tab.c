/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "Q.y"

#define YYDEBUG 0

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *outfile;

int yyerror(char *s);

#include "block.h"

#include "y.tab.h"
#include "lex.yy.c"

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
    Block* block = (Block*)malloc(sizeof(Block));
    Code* curr = (Code*)malloc(sizeof(Code));
    curr->append = "\n";
    block->code = curr;

    return block;
}

Block* colon()
{
    Block* block = (Block*)malloc(sizeof(Block));
    Code* curr = (Code*)malloc(sizeof(Code));
    curr->append = " :";
    block->code = curr;

    return block;
}

#line 125 "Q.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "Q.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_AND = 3,                        /* AND  */
  YYSYMBOL_ASSIGN = 4,                     /* ASSIGN  */
  YYSYMBOL_COLON = 5,                      /* COLON  */
  YYSYMBOL_COMMA = 6,                      /* COMMA  */
  YYSYMBOL_DEF = 7,                        /* DEF  */
  YYSYMBOL_DIV = 8,                        /* DIV  */
  YYSYMBOL_DOT = 9,                        /* DOT  */
  YYSYMBOL_ELSE = 10,                      /* ELSE  */
  YYSYMBOL_END = 11,                       /* END  */
  YYSYMBOL_EQ = 12,                        /* EQ  */
  YYSYMBOL_EXITLOOP = 13,                  /* EXITLOOP  */
  YYSYMBOL_FLOAT = 14,                     /* FLOAT  */
  YYSYMBOL_FLOAT_CONST = 15,               /* FLOAT_CONST  */
  YYSYMBOL_FORMAT = 16,                    /* FORMAT  */
  YYSYMBOL_GE = 17,                        /* GE  */
  YYSYMBOL_GLOBAL = 18,                    /* GLOBAL  */
  YYSYMBOL_GT = 19,                        /* GT  */
  YYSYMBOL_ID = 20,                        /* ID  */
  YYSYMBOL_IF = 21,                        /* IF  */
  YYSYMBOL_INT = 22,                       /* INT  */
  YYSYMBOL_INT_CONST = 23,                 /* INT_CONST  */
  YYSYMBOL_LEFT_PAREN = 24,                /* LEFT_PAREN  */
  YYSYMBOL_LEFT_SQ_BKT = 25,               /* LEFT_SQ_BKT  */
  YYSYMBOL_LE = 26,                        /* LE  */
  YYSYMBOL_LT = 27,                        /* LT  */
  YYSYMBOL_MINUS = 28,                     /* MINUS  */
  YYSYMBOL_MOD = 29,                       /* MOD  */
  YYSYMBOL_MULT = 30,                      /* MULT  */
  YYSYMBOL_NE = 31,                        /* NE  */
  YYSYMBOL_NOT = 32,                       /* NOT  */
  YYSYMBOL_NUL = 33,                       /* NUL  */
  YYSYMBOL_OR = 34,                        /* OR  */
  YYSYMBOL_PLUS = 35,                      /* PLUS  */
  YYSYMBOL_PRINT = 36,                     /* PRINT  */
  YYSYMBOL_PRODUCT = 37,                   /* PRODUCT  */
  YYSYMBOL_READ = 38,                      /* READ  */
  YYSYMBOL_RIGHT_PAREN = 39,               /* RIGHT_PAREN  */
  YYSYMBOL_RIGHT_SQ_BKT = 40,              /* RIGHT_SQ_BKT  */
  YYSYMBOL_SEMICOLON = 41,                 /* SEMICOLON  */
  YYSYMBOL_SKIP = 42,                      /* SKIP  */
  YYSYMBOL_STRING = 43,                    /* STRING  */
  YYSYMBOL_WHILE = 44,                     /* WHILE  */
  YYSYMBOL_YYACCEPT = 45,                  /* $accept  */
  YYSYMBOL_code = 46,                      /* code  */
  YYSYMBOL_prog = 47,                      /* prog  */
  YYSYMBOL_declList = 48,                  /* declList  */
  YYSYMBOL_decl = 49,                      /* decl  */
  YYSYMBOL_typeList = 50,                  /* typeList  */
  YYSYMBOL_varList = 51,                   /* varList  */
  YYSYMBOL_var = 52,                       /* var  */
  YYSYMBOL_sizeListO = 53,                 /* sizeListO  */
  YYSYMBOL_sizeList = 54,                  /* sizeList  */
  YYSYMBOL_type = 55,                      /* type  */
  YYSYMBOL_typeDef = 56,                   /* typeDef  */
  YYSYMBOL_stmtListO = 57,                 /* stmtListO  */
  YYSYMBOL_stmtList = 58,                  /* stmtList  */
  YYSYMBOL_stmt = 59,                      /* stmt  */
  YYSYMBOL_assignmentStmt = 60,            /* assignmentStmt  */
  YYSYMBOL_dotId = 61,                     /* dotId  */
  YYSYMBOL_readStmt = 62,                  /* readStmt  */
  YYSYMBOL_printStmt = 63,                 /* printStmt  */
  YYSYMBOL_ifStmt = 64,                    /* ifStmt  */
  YYSYMBOL_elsePart = 65,                  /* elsePart  */
  YYSYMBOL_whileStmt = 66,                 /* whileStmt  */
  YYSYMBOL_exitLoop = 67,                  /* exitLoop  */
  YYSYMBOL_skip = 68,                      /* skip  */
  YYSYMBOL_id = 69,                        /* id  */
  YYSYMBOL_indxListO = 70,                 /* indxListO  */
  YYSYMBOL_indxList = 71,                  /* indxList  */
  YYSYMBOL_bExp = 72,                      /* bExp  */
  YYSYMBOL_relOP = 73,                     /* relOP  */
  YYSYMBOL_exp = 74,                       /* exp  */
  YYSYMBOL_epsilon = 75                    /* epsilon  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  8
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   200

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  45
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  31
/* YYNRULES -- Number of rules.  */
#define YYNRULES  75
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  138

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   299


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    81,    81,    86,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   133,   151,   152,
     153,   154,   155,   156,   157,   158,   172,   173,   184,   197,
     208,   221,   285,   286,   287,   331,   332,   333,   343,   344,
     345,   356,   366,   387,   408,   418,   419,   465,   466,   467,
     468,   469,   470,   471,   493,   515,   537,   559,   581,   600,
     603,   625,   628,   632,   644,   656
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "AND", "ASSIGN",
  "COLON", "COMMA", "DEF", "DIV", "DOT", "ELSE", "END", "EQ", "EXITLOOP",
  "FLOAT", "FLOAT_CONST", "FORMAT", "GE", "GLOBAL", "GT", "ID", "IF",
  "INT", "INT_CONST", "LEFT_PAREN", "LEFT_SQ_BKT", "LE", "LT", "MINUS",
  "MOD", "MULT", "NE", "NOT", "NUL", "OR", "PLUS", "PRINT", "PRODUCT",
  "READ", "RIGHT_PAREN", "RIGHT_SQ_BKT", "SEMICOLON", "SKIP", "STRING",
  "WHILE", "$accept", "code", "prog", "declList", "decl", "typeList",
  "varList", "var", "sizeListO", "sizeList", "type", "typeDef",
  "stmtListO", "stmtList", "stmt", "assignmentStmt", "dotId", "readStmt",
  "printStmt", "ifStmt", "elsePart", "whileStmt", "exitLoop", "skip", "id",
  "indxListO", "indxList", "bExp", "relOP", "exp", "epsilon", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-85)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
       1,    19,    13,   -85,     7,    71,    19,   -85,   -85,     8,
       6,    20,    25,   -85,   -85,    10,   159,    -2,    16,   -85,
     159,    29,    17,   -85,   -85,    63,   -85,   -85,   -85,   -85,
     -85,   -85,    37,   -85,   -85,    41,    56,   -85,    55,   -85,
     -85,    61,   111,    61,   165,   -85,    62,   -85,   -85,   -85,
     159,   165,   159,   165,   -85,     5,   129,   165,   -85,   165,
      18,   -85,    71,   165,    65,     7,    46,    70,    69,    99,
     -85,   102,   -85,   -85,   -85,   -85,   -85,   -85,   165,    60,
     165,     3,    93,   143,   -85,   143,   159,    71,   159,   165,
     165,   -85,   -85,   -85,   -85,   -85,   165,   165,   165,   -85,
     165,   165,   141,   141,    71,   -85,   141,   -85,    33,   -85,
      76,   111,    21,   -85,    68,   -85,   -85,   -85,    -3,   -85,
     108,   -85,   143,   108,   108,   143,   141,    42,   -85,   -85,
     -85,   -85,    71,   100,   -85,   -85,    17,   -85
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,    75,     0,     2,     0,    75,    75,     5,     1,    75,
       0,     0,    11,     9,    45,    75,     0,     0,     0,    46,
       0,     0,    24,    27,    28,     0,    29,    30,    31,    32,
      33,    34,    36,    25,     4,     0,     0,    12,    13,    14,
       6,     0,     0,     0,     0,    47,    48,    49,    74,    73,
       0,     0,     0,     0,    72,     0,     0,     0,    39,     0,
       0,     3,     0,     0,     0,     0,     0,     0,    75,     0,
      18,    22,    17,    20,    19,     8,    21,    10,     0,     0,
       0,     0,     0,    68,    54,    69,     0,     0,     0,     0,
       0,    57,    60,    61,    58,    59,     0,     0,     0,    62,
       0,     0,    40,    38,     0,    26,    35,    37,     0,    16,
       0,     0,     0,    51,     0,    55,    71,    53,    75,    52,
      66,    70,    64,    67,    65,    63,    56,     0,    23,    15,
       7,    50,     0,     0,    43,    44,    42,    41
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -85,   -85,   -85,   112,   -85,    64,    32,   -85,   -85,   -85,
      15,   -40,   -85,   -84,    72,   -85,    66,   -85,   -85,   -85,
     -85,   -85,   -85,   -85,    -5,   -85,   -85,   -16,   -85,   -35,
      -4
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_uint8 yydefgoto[] =
{
       0,     2,     3,     5,     6,    10,    11,    12,    37,    38,
      75,    13,    21,    22,    23,    24,    25,    26,    27,    28,
     133,    29,    30,    31,    54,    45,    46,    55,   101,    56,
       7
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      32,    33,    76,   118,    60,    39,    86,   132,    86,    79,
      87,    47,    35,     8,    57,    82,    83,    40,    85,     1,
     127,    86,   102,   104,   103,    42,     4,     9,   106,    89,
      90,    43,    59,    36,    81,    44,    84,    88,    62,    88,
      61,    58,   115,   112,   128,   114,    64,    41,   136,    96,
      97,    98,    88,   135,   120,   121,   100,    32,    62,    32,
     116,   122,   123,   124,    39,   125,   126,    63,    89,    90,
     117,    76,   119,    69,    41,    77,    89,    90,    65,    66,
      67,    68,    32,    62,    14,    15,   109,    80,    96,    97,
      98,    15,    16,   110,    36,   100,    96,    97,    98,    32,
     113,    89,    90,   100,   111,    91,    35,    17,   131,    18,
      92,   137,    93,    19,   134,    20,   129,    90,    34,    94,
      95,    96,    97,    98,    99,    70,   130,    32,   100,   108,
     107,    71,   116,    72,   105,     0,     0,    89,    90,     0,
       0,    91,     0,     0,    73,     0,    92,     0,    93,    89,
      90,    89,    90,     0,    74,    94,    95,    96,    97,    98,
      99,     0,     0,     0,   100,     0,     0,     0,     0,    96,
      97,    98,    97,    98,    48,     0,   100,     0,     0,    15,
      48,     0,    49,    50,     0,    15,     0,    51,    49,    78,
       0,    52,     0,    51,    53,     0,     0,     0,     0,     0,
      53
};

static const yytype_int16 yycheck[] =
{
       5,     5,    42,    87,    20,     9,     3,    10,     3,    44,
       5,    15,     4,     0,    16,    50,    51,    11,    53,    18,
     104,     3,    57,     5,    59,     5,     7,    20,    63,     8,
       9,     6,    16,    25,    50,    25,    52,    34,    41,    34,
      11,    43,    39,    78,    11,    80,     9,    41,   132,    28,
      29,    30,    34,    11,    89,    90,    35,    62,    41,    64,
      39,    96,    97,    98,    68,   100,   101,     4,     8,     9,
      86,   111,    88,    41,    41,    43,     8,     9,    37,    23,
      25,    20,    87,    41,    13,    20,    40,    25,    28,    29,
      30,    20,    21,    23,    25,    35,    28,    29,    30,   104,
      40,     8,     9,    35,     5,    12,     4,    36,    40,    38,
      17,    11,    19,    42,   118,    44,    40,     9,     6,    26,
      27,    28,    29,    30,    31,    14,   111,   132,    35,    65,
      64,    20,    39,    22,    62,    -1,    -1,     8,     9,    -1,
      -1,    12,    -1,    -1,    33,    -1,    17,    -1,    19,     8,
       9,     8,     9,    -1,    43,    26,    27,    28,    29,    30,
      31,    -1,    -1,    -1,    35,    -1,    -1,    -1,    -1,    28,
      29,    30,    29,    30,    15,    -1,    35,    -1,    -1,    20,
      15,    -1,    23,    24,    -1,    20,    -1,    28,    23,    24,
      -1,    32,    -1,    28,    35,    -1,    -1,    -1,    -1,    -1,
      35
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    18,    46,    47,     7,    48,    49,    75,     0,    20,
      50,    51,    52,    56,    13,    20,    21,    36,    38,    42,
      44,    57,    58,    59,    60,    61,    62,    63,    64,    66,
      67,    68,    69,    75,    48,     4,    25,    53,    54,    75,
      11,    41,     5,     6,    25,    70,    71,    75,    15,    23,
      24,    28,    32,    35,    69,    72,    74,    16,    43,    16,
      72,    11,    41,     4,     9,    37,    23,    25,    20,    51,
      14,    20,    22,    33,    43,    55,    56,    51,    24,    74,
      25,    72,    74,    74,    72,    74,     3,     5,    34,     8,
       9,    12,    17,    19,    26,    27,    28,    29,    30,    31,
      35,    73,    74,    74,     5,    59,    74,    61,    50,    40,
      23,     5,    74,    40,    74,    39,    39,    72,    58,    72,
      74,    74,    74,    74,    74,    74,    74,    58,    11,    40,
      55,    40,    10,    65,    75,    11,    58,    11
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    45,    46,    47,    48,    48,    49,    50,    50,    50,
      51,    51,    52,    53,    53,    54,    54,    55,    55,    55,
      55,    55,    55,    56,    57,    57,    58,    58,    59,    59,
      59,    59,    59,    59,    59,    60,    61,    61,    62,    63,
      63,    64,    65,    65,    66,    67,    68,    69,    70,    70,
      71,    71,    72,    72,    72,    72,    72,    73,    73,    73,
      73,    73,    73,    74,    74,    74,    74,    74,    74,    74,
      74,    74,    74,    74,    74,    75
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     4,     2,     1,     3,     5,     3,     1,
       3,     1,     2,     1,     1,     4,     3,     1,     1,     1,
       1,     1,     1,     5,     1,     1,     3,     1,     1,     1,
       1,     1,     1,     1,     1,     3,     1,     3,     3,     2,
       3,     6,     2,     1,     5,     1,     1,     2,     1,     1,
       4,     3,     3,     3,     2,     3,     3,     1,     1,     1,
       1,     1,     1,     3,     3,     3,     3,     3,     2,     2,
       3,     3,     1,     1,     1,     0
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* code: prog  */
#line 81 "Q.y"
                                                                {
                                                                    outfile << "---------------" << endl; 
                                                                    (yyvsp[0].block)->printCode(); 
                                                                    outfile << "---------------" << endl; 
                                                                }
#line 1296 "Q.tab.c"
    break;

  case 3: /* prog: GLOBAL declList stmtListO END  */
#line 86 "Q.y"
                                                                {
                                                                    (yyval.block) = (yyvsp[-1].block);
                                                                }
#line 1304 "Q.tab.c"
    break;

  case 26: /* stmtList: stmtList SEMICOLON stmt  */
#line 111 "Q.y"
                                                                {
                                                                    Block *b = new Block();
                                                                    b->nextBlock = new Block();
                                                                    (yyval.block) = b;

                                                                    if((yyvsp[-2].block)->nextBlock==NULL)
                                                                    {
                                                                        (yyvsp[-2].block)->nextBlock = new Block();
                                                                    }
                                                                    (yyvsp[-2].block)->nextBlock->code->append(new_label());
                                                                    (yyvsp[0].block)->nextBlock = b->nextBlock;

                                                                    b->concat((yyvsp[-2].block));

                                                                    Block *_1_next = new Block();
                                                                    _1_next->labelBlock = &((yyvsp[-2].block)->nextBlock);

                                                                    b->concat(_1_next);
                                                                    b->concat(colon());
                                                                    b->concat(newline());
                                                                    b->concat((yyvsp[0].block));
                                                                }
#line 1331 "Q.tab.c"
    break;

  case 27: /* stmtList: stmt  */
#line 133 "Q.y"
                                                                {
                                                                    if((yyvsp[0].block)->nextBlock == NULL)
                                                                    {   
                                                                        (yyvsp[0].block)->nextBlock = new Block();
                                                                    }
                                                                    (yyvsp[0].block)->nextBlock->code->append(new_label());

                                                                    Block *b = new Block();
                                                                    b->concat((yyvsp[0].block));

                                                                    Block *_1_next = new Block();
                                                                    _1_next->labelBlock = &((yyvsp[0].block)->nextBlock);
                                                                    b->concat(_1_next);
                                                                    b->concat(colon());
                                                                    b->concat(newline());

                                                                    (yyval.block) = b;
                                                                }
#line 1354 "Q.tab.c"
    break;

  case 33: /* stmt: exitLoop  */
#line 156 "Q.y"
                                                        { (yyval.block) = new Block(); }
#line 1360 "Q.tab.c"
    break;

  case 34: /* stmt: skip  */
#line 157 "Q.y"
                                                    { (yyval.block) = new Block(); }
#line 1366 "Q.tab.c"
    break;

  case 35: /* assignmentStmt: dotId ASSIGN exp  */
#line 158 "Q.y"
                                                    {
                                                        string c = (yyvsp[-2].block)->var;
                                                        c+=" = ";
                                                        c+=(yyvsp[0].block)->var;
                                                        Code* curr = new Code();
                                                        curr->append(c);

                                                        Block *b = new Block();
                                                        b->code = curr;

                                                        b->concat(newline());
                                                        (yyvsp[0].block)->concat(b);
                                                        (yyval.block) = (yyvsp[0].block);
                                                    }
#line 1385 "Q.tab.c"
    break;

  case 37: /* dotId: id DOT dotId  */
#line 173 "Q.y"
                                                    {
                                                        string c = (yyvsp[-2].block)->var;
                                                        c+=".";
                                                        c+=(yyvsp[0].block)->var;
                                                        Code* curr = new Code();
                                                        curr->append(c);

                                                        (yyval.block) = new Block();
                                                        (yyval.block)->code = curr;
                                                        (yyval.block)->var = c;
                                                    }
#line 1401 "Q.tab.c"
    break;

  case 38: /* readStmt: READ FORMAT exp  */
#line 184 "Q.y"
                                                    {
                                                        string c = (yyvsp[-2].code_str);
                                                        c+=" ";
                                                        c+=(yyvsp[-1].code_str);
                                                        c+=" ";
                                                        c+=(yyvsp[0].block)->code->code;

                                                        Code* curr = new Code();
                                                        curr->append(c);

                                                        (yyval.block) = new Block();
                                                        (yyval.block)->code = curr;
                                                    }
#line 1419 "Q.tab.c"
    break;

  case 39: /* printStmt: PRINT STRING  */
#line 197 "Q.y"
                                                    {
                                                        string c = (yyvsp[-1].code_str);
                                                        c+=" ";
                                                        c+=(yyvsp[0].code_str);

                                                        Code* curr = new Code();
                                                        curr->append(c);

                                                        (yyval.block) = new Block();
                                                        (yyval.block)->code = curr;
                                                    }
#line 1435 "Q.tab.c"
    break;

  case 40: /* printStmt: PRINT FORMAT exp  */
#line 208 "Q.y"
                                                    {
                                                        string c = (yyvsp[-2].code_str);
                                                        c+=" ";
                                                        c+=(yyvsp[-1].code_str);
                                                        c+=" ";
                                                        c+=(yyvsp[0].block)->code->code;

                                                        Code* curr = new Code();
                                                        curr->append(c);

                                                        (yyval.block) = new Block();
                                                        (yyval.block)->code = curr;
                                                    }
#line 1453 "Q.tab.c"
    break;

  case 41: /* ifStmt: IF bExp COLON stmtList elsePart END  */
#line 221 "Q.y"
                                                                {
                                                                    (yyvsp[-4].block)->trueBlock->code->append(new_label());

                                                                    (yyval.block) = new Block();
                                                                    (yyval.block)->nextBlock = new Block();

                                                                    if((yyvsp[-1].block)==NULL)
                                                                    {
                                                                        (yyvsp[-4].block)->falseBlock = (yyval.block)->nextBlock;

                                                                        (yyvsp[-2].block)->nextBlock = (yyval.block)->nextBlock;

                                                                        (yyval.block)->concat((yyvsp[-4].block));

                                                                        Block* _2_true = new Block();
                                                                        _2_true->labelBlock = &((yyvsp[-4].block)->trueBlock);

                                                                        (yyval.block)->concat(_2_true);
                                                                        (yyval.block)->concat(colon());
                                                                        (yyval.block)->concat(newline());
                                                                        
                                                                        (yyval.block)->concat((yyvsp[-2].block));
                                                                    }
                                                                    else
                                                                    {
                                                                        // Handle else part
                                                                        (yyvsp[-1].block)->nextBlock = (yyval.block)->nextBlock;
                                                                        (yyvsp[-4].block)->falseBlock->code->append(new_label());
                                                                        (yyvsp[-4].block)->falseBlock = (yyvsp[-1].block)->nextBlock;
                                                                        (yyvsp[-2].block)->nextBlock = (yyval.block)->nextBlock;

                                                                        (yyval.block)->concat((yyvsp[-4].block));

                                                                        Block* _2_true = new Block();
                                                                        _2_true->labelBlock = &((yyvsp[-4].block)->trueBlock);

                                                                        (yyval.block)->concat(_2_true);
                                                                        (yyval.block)->concat(colon());
                                                                        (yyval.block)->concat(newline());
                                                                        
                                                                        (yyval.block)->concat((yyvsp[-2].block));

                                                                        Block* goto_block = new Block();
                                                                        Code* goto_code = new Code();
                                                                        goto_code->append("goto ");
                                                                        goto_block->code = goto_code;

                                                                        Block* _next_block = new Block();
                                                                        _next_block->labelBlock = &((yyval.block)->nextBlock);
                                                                        
                                                                        goto_block->concat(_next_block);
                                                                        (yyval.block)->concat(goto_block);
                                                                        (yyval.block)->concat(newline());

                                                                        Block* _5_next = new Block();
                                                                        _5_next->labelBlock = &((yyvsp[-1].block)->nextBlock);

                                                                        (yyval.block)->concat(_5_next);
                                                                        (yyval.block)->concat(colon());
                                                                        (yyval.block)->concat(newline());
                                                                        
                                                                        (yyval.block)->concat((yyvsp[-1].block));
                                                                    }
                                                                }
#line 1522 "Q.tab.c"
    break;

  case 42: /* elsePart: ELSE stmtList  */
#line 285 "Q.y"
                                                                {   (yyval.block) = (yyvsp[0].block);    }
#line 1528 "Q.tab.c"
    break;

  case 43: /* elsePart: epsilon  */
#line 286 "Q.y"
                                                                {   (yyval.block) = NULL;  }
#line 1534 "Q.tab.c"
    break;

  case 44: /* whileStmt: WHILE bExp COLON stmtList END  */
#line 287 "Q.y"
                                                                {
                                                                    string begin = new_label();
                                                                    (yyvsp[-3].block)->trueBlock->code->append(new_label());

                                                                    Block* b = new Block();
                                                                    (yyval.block) = b;
                                                                    b->nextBlock = new Block();

                                                                    (yyvsp[-3].block)->falseBlock = b->nextBlock;
                                                                    if((yyvsp[-1].block)->nextBlock==NULL)
                                                                        (yyvsp[-1].block)->nextBlock = new Block();
                                                                    (yyvsp[-1].block)->nextBlock->code->append(begin);

                                                                    Block* _begin = new Block();
                                                                    _begin->labelBlock = &((yyvsp[-1].block)->nextBlock);

                                                                    b->concat(_begin);
                                                                    b->concat(colon());
                                                                    b->concat(newline());

                                                                    b->concat((yyvsp[-3].block));

                                                                    Block* b_true = new Block();
                                                                    b_true->labelBlock = &((yyvsp[-3].block)->trueBlock);

                                                                    b->concat(b_true);
                                                                    b->concat(colon());
                                                                    b->concat(newline());
                                                                    b->concat((yyvsp[-1].block));

                                                                    string c = "goto ";
                                                                    Code* curr = new Code();
                                                                    curr->append(c);
                                                                    Block* nb = new Block();
                                                                    nb->code = curr;

                                                                    b->concat(nb);

                                                                    Block* _begin2 = new Block();
                                                                    _begin2->labelBlock = &((yyvsp[-1].block)->nextBlock);

                                                                    b->concat(_begin2);
                                                                    b->concat(newline());
                                                                }
#line 1583 "Q.tab.c"
    break;

  case 47: /* id: ID indxListO  */
#line 333 "Q.y"
                                                    {
                                                        string c = (yyvsp[-1].code_str);
                                                        c+=(yyvsp[0].block)->code->code;
                                                        Code* curr = new Code();
                                                        curr->append(c);

                                                        (yyval.block) = new Block();
                                                        // $$->code = curr;
                                                        (yyval.block)->var = c;
                                                    }
#line 1598 "Q.tab.c"
    break;

  case 50: /* indxList: indxList LEFT_SQ_BKT exp RIGHT_SQ_BKT  */
#line 345 "Q.y"
                                                                    {
                                                                        string c = (yyvsp[-3].block)->code->code;
                                                                        c+=(yyvsp[-2].code_str);
                                                                        c+=(yyvsp[-1].block)->var;
                                                                        c+=(yyvsp[0].code_str);
                                                                        Code* curr = new Code();
                                                                        curr->append(c);

                                                                        (yyval.block) = new Block();
                                                                        (yyval.block)->code = curr;
                                                                    }
#line 1614 "Q.tab.c"
    break;

  case 51: /* indxList: LEFT_SQ_BKT exp RIGHT_SQ_BKT  */
#line 356 "Q.y"
                                                                    {
                                                                        string c = (yyvsp[-2].code_str);
                                                                        c+=(yyvsp[-1].block)->var;
                                                                        c+=(yyvsp[0].code_str);
                                                                        Code* curr = new Code();
                                                                        curr->append(c);

                                                                        (yyval.block) = new Block();
                                                                        (yyval.block)->code = curr;
                                                                    }
#line 1629 "Q.tab.c"
    break;

  case 52: /* bExp: bExp OR bExp  */
#line 366 "Q.y"
                                                            {
                                                                Block* b = new Block();
                                                                (yyval.block) = b;
                                                                b->trueBlock = new Block();
                                                                b->falseBlock = new Block();

                                                                (yyvsp[-2].block)->trueBlock = b->trueBlock;
                                                                (yyvsp[-2].block)->falseBlock->code->append(new_label());
                                                                (yyvsp[0].block)->trueBlock = b->trueBlock;
                                                                
                                                                (yyvsp[0].block)->falseBlock = b->falseBlock;
                                                                b->concat((yyvsp[-2].block));
                                                                
                                                                Block* _1_false = new Block();
                                                                _1_false->labelBlock = &((yyvsp[-2].block)->falseBlock);
                                                                b->concat(_1_false);
                                                                b->concat(colon());
                                                                b->concat(newline());

                                                                b->concat((yyvsp[0].block));
                                                            }
#line 1655 "Q.tab.c"
    break;

  case 53: /* bExp: bExp AND bExp  */
#line 387 "Q.y"
                                                            {
                                                                Block* b = new Block();
                                                                (yyval.block) = b;
                                                                b->trueBlock = new Block();
                                                                b->falseBlock = new Block();

                                                                (yyvsp[-2].block)->trueBlock->code->append(new_label());
                                                                (yyvsp[-2].block)->falseBlock = b->falseBlock;
                                                                (yyvsp[0].block)->trueBlock = b->trueBlock;
                                                                
                                                                (yyvsp[0].block)->falseBlock = b->falseBlock;
                                                                b->concat((yyvsp[-2].block));
                                                                
                                                                Block* _1_true = new Block();
                                                                _1_true->labelBlock = &((yyvsp[-2].block)->trueBlock);
                                                                b->concat(_1_true);
                                                                b->concat(colon());
                                                                b->concat(newline());

                                                                b->concat((yyvsp[0].block));
                                                            }
#line 1681 "Q.tab.c"
    break;

  case 54: /* bExp: NOT bExp  */
#line 408 "Q.y"
                                                            {
                                                                (yyval.block) = new Block();
                                                                (yyval.block)->trueBlock = new Block();
                                                                (yyval.block)->falseBlock = new Block();

                                                                (yyvsp[0].block)->trueBlock = (yyval.block)->falseBlock;
                                                                (yyvsp[0].block)->falseBlock = (yyval.block)->trueBlock;
                                                                
                                                                (yyval.block)->concat((yyvsp[0].block));
                                                            }
#line 1696 "Q.tab.c"
    break;

  case 55: /* bExp: LEFT_PAREN bExp RIGHT_PAREN  */
#line 418 "Q.y"
                                                            {   (yyval.block) = (yyvsp[-1].block);    }
#line 1702 "Q.tab.c"
    break;

  case 56: /* bExp: exp relOP exp  */
#line 419 "Q.y"
                                                            {
                                                                Block *b = new Block();

                                                                b->concat((yyvsp[-2].block));
                                                                b->concat((yyvsp[0].block));

                                                                Block *b1 = new Block();
                                                                Code* curr1 = new Code();
                                                                string c1 = "if ";
                                                                c1+=(yyvsp[-2].block)->var;
                                                                c1+=" ";
                                                                c1+=(yyvsp[-1].code_str);
                                                                c1+=" ";
                                                                c1+=(yyvsp[0].block)->var;
                                                                c1+=" goto ";

                                                                curr1->append(c1);
                                                                b1->code = curr1;

                                                                b->concat(b1);
                                                                b->trueBlock = new Block();

                                                                Block *b_true = new Block();
                                                                b_true->labelBlock = &(b->trueBlock);
                                                                b->concat(b_true);

                                                                b->concat(newline());

                                                                Block* b2 = new Block();
                                                                Code* curr2 = new Code();
                                                                string c2 = "goto ";
                                                                curr2->append(c2);
                                                                b2->code = curr2;

                                                                b->falseBlock = new Block();

                                                                Block *b_false = new Block();
                                                                b_false->labelBlock = &(b->falseBlock);
                                                                
                                                                b2->concat(b_false);

                                                                b->concat(b2);
                                                                b->concat(newline());

                                                                (yyval.block) = b;
                                                            }
#line 1753 "Q.tab.c"
    break;

  case 63: /* exp: exp PLUS exp  */
#line 471 "Q.y"
                                                            {
                                                                (yyvsp[-2].block)->concat((yyvsp[0].block));

                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+=(yyvsp[-2].block)->var;
                                                                c+=" + ";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[-2].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[-2].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1780 "Q.tab.c"
    break;

  case 64: /* exp: exp MINUS exp  */
#line 493 "Q.y"
                                                            {
                                                                (yyvsp[-2].block)->concat((yyvsp[0].block));

                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+=(yyvsp[-2].block)->var;
                                                                c+=" - ";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[-2].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[-2].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1807 "Q.tab.c"
    break;

  case 65: /* exp: exp MULT exp  */
#line 515 "Q.y"
                                                            {
                                                                (yyvsp[-2].block)->concat((yyvsp[0].block));

                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+=(yyvsp[-2].block)->var;
                                                                c+=" * ";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[-2].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[-2].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1834 "Q.tab.c"
    break;

  case 66: /* exp: exp DIV exp  */
#line 537 "Q.y"
                                                            {
                                                                (yyvsp[-2].block)->concat((yyvsp[0].block));

                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+=(yyvsp[-2].block)->var;
                                                                c+=" / ";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[-2].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[-2].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1861 "Q.tab.c"
    break;

  case 67: /* exp: exp MOD exp  */
#line 559 "Q.y"
                                                            {
                                                                (yyvsp[-2].block)->concat((yyvsp[0].block));

                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+=(yyvsp[-2].block)->var;
                                                                c+=" % ";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[-2].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[-2].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1888 "Q.tab.c"
    break;

  case 68: /* exp: MINUS exp  */
#line 581 "Q.y"
                                                            {   
                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+="- ";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[0].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[0].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1912 "Q.tab.c"
    break;

  case 69: /* exp: PLUS exp  */
#line 600 "Q.y"
                                                            {   
                                                                (yyval.block) = (yyvsp[0].block);
                                                            }
#line 1920 "Q.tab.c"
    break;

  case 70: /* exp: exp DOT exp  */
#line 603 "Q.y"
                                                            {   
                                                                (yyvsp[-2].block)->concat((yyvsp[0].block));

                                                                string var = new_variable();
                                                                string c = var;
                                                                c+=" = ";
                                                                c+=(yyvsp[-2].block)->var;
                                                                c+=".";
                                                                c+=(yyvsp[0].block)->var;
                                                                
                                                                Code* curr = new Code();
                                                                curr->append(c);

                                                                Block* b = new Block();
                                                                b->code = curr;
                                                                
                                                                b->concat(newline());
                                                                (yyvsp[-2].block)->concat(b);
                                                                
                                                                (yyval.block) = (yyvsp[-2].block);
                                                                (yyval.block)->var = var;
                                                            }
#line 1947 "Q.tab.c"
    break;

  case 71: /* exp: LEFT_PAREN exp RIGHT_PAREN  */
#line 625 "Q.y"
                                                            {   
                                                                (yyval.block) = (yyvsp[-1].block);
                                                            }
#line 1955 "Q.tab.c"
    break;

  case 72: /* exp: id  */
#line 628 "Q.y"
                                                            {   
                                                                (yyval.block) = new Block();
                                                                (yyval.block)->var = (yyvsp[0].block)->var;
                                                            }
#line 1964 "Q.tab.c"
    break;

  case 73: /* exp: INT_CONST  */
#line 632 "Q.y"
                                                            {   
                                                                Code* c = new Code();
                                                                string var = new_variable();
                                                                c->append(var);
                                                                c->append(" = ");
                                                                c->append((yyvsp[0].code_str));
                                                                (yyval.block) = new Block();

                                                                (yyval.block)->code = c;
                                                                (yyval.block)->var = var;
                                                                (yyval.block)->concat(newline());
                                                            }
#line 1981 "Q.tab.c"
    break;

  case 74: /* exp: FLOAT_CONST  */
#line 644 "Q.y"
                                                            {   
                                                                Code* c = new Code();
                                                                string var = new_variable();
                                                                c->append(var);
                                                                c->append(" = ");
                                                                c->append((yyvsp[0].code_str));
                                                                (yyval.block) = new Block();

                                                                (yyval.block)->code = c;
                                                                (yyval.block)->var = var;
                                                                (yyval.block)->concat(newline());
                                                            }
#line 1998 "Q.tab.c"
    break;

  case 75: /* epsilon: %empty  */
#line 656 "Q.y"
                                                            { (yyval.block) = new Block(); }
#line 2004 "Q.tab.c"
    break;


#line 2008 "Q.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 657 "Q.y"
  

int yyerror(char *s)    
{   
    fprintf(stderr, "%s in line no : %d - %s\n", s, yylineno, yytext);
    exit(-1);
}

int main(int argc, char* argv[])
{
#if YYDEBUG
    yydebug = 1;
#endif

    extern FILE *yyin;
    const char* input_file = "input.txt";
    const char* output_file = "output.txt";
    
    // Check if input file is provided as argument
    if (argc > 1) {
        input_file = argv[1];
    }
    
    // Check if output file is provided as argument
    if (argc > 2) {
        output_file = argv[2];
    }
    
    yyin = fopen(input_file, "r");
    if (!yyin) {
        fprintf(stderr, "Cannot open input file: %s\n", input_file);
        return 1;
    }
    
    FILE *outfile = fopen(output_file, "w");
    if (!outfile) {
        fprintf(stderr, "Cannot open output file: %s\n", output_file);
        return 1;
    }

    yyparse();

    printf("Successfully parsed! Output written to %s\n", output_file);
    fclose(outfile);

    return 0;
}
