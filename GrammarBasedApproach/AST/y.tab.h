/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    BEG = 258,
    END = 259,
    INIT = 260,
    TO = 261,
    IF = 262,
    THEN = 263,
    WHILE = 264,
    DO = 265,
    PRINT = 266,
    READ = 267,
    FLOATING_NUMBER = 268,
    BREAK = 269,
    END_FUNCTION = 270,
    START_PROCEDURE = 271,
    NEWLINE = 272,
    CLOSE_BRACKET = 273,
    OPEN_BRACKET = 274,
    ELSE = 275,
    ENDIF = 276,
    COMMA = 277,
    ENDWHILE = 278,
    INT = 279,
    FLOAT = 280,
    CHAR = 281,
    DOUBLE = 282,
    LONG = 283,
    ID = 284,
    DIV = 285,
    MUL = 286,
    MINUS = 287,
    PLUS = 288,
    GREAT_E = 289,
    GREAT = 290,
    LESS_E = 291,
    NOT = 292,
    OR = 293,
    LESS = 294,
    EQUAL = 295,
    NOT_EQUAL = 296,
    AND = 297,
    NUM = 298,
    EXP = 299,
    ASSIGN = 300,
    NAME_PROCEDURE = 301,
    RETURN = 302
  };
#endif
/* Tokens.  */
#define BEG 258
#define END 259
#define INIT 260
#define TO 261
#define IF 262
#define THEN 263
#define WHILE 264
#define DO 265
#define PRINT 266
#define READ 267
#define FLOATING_NUMBER 268
#define BREAK 269
#define END_FUNCTION 270
#define START_PROCEDURE 271
#define NEWLINE 272
#define CLOSE_BRACKET 273
#define OPEN_BRACKET 274
#define ELSE 275
#define ENDIF 276
#define COMMA 277
#define ENDWHILE 278
#define INT 279
#define FLOAT 280
#define CHAR 281
#define DOUBLE 282
#define LONG 283
#define ID 284
#define DIV 285
#define MUL 286
#define MINUS 287
#define PLUS 288
#define GREAT_E 289
#define GREAT 290
#define LESS_E 291
#define NOT 292
#define OR 293
#define LESS 294
#define EQUAL 295
#define NOT_EQUAL 296
#define AND 297
#define NUM 298
#define EXP 299
#define ASSIGN 300
#define NAME_PROCEDURE 301
#define RETURN 302

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 25 "project1.y" /* yacc.c:1909  */
char* dataType; char* IdName; struct AST *node;

#line 151 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
