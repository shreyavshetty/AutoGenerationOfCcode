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
    ASSIGN = 268,
    FLOATING_NUMBER = 269,
    BREAK = 270,
    RETURN = 271,
    END_FUNCTION = 272,
    START_PROCEDURE = 273,
    CLOSE_BRACKET = 274,
    OPEN_BRACKET = 275,
    EXP = 276,
    DIV = 277,
    MUL = 278,
    MINUS = 279,
    PLUS = 280,
    NOT = 281,
    ELSE = 282,
    ENDIF = 283,
    COMMA = 284,
    NEWLINE = 285,
    ENDWHILE = 286,
    INT = 287,
    FLOAT = 288,
    CHAR = 289,
    DOUBLE = 290,
    LONG = 291,
    ID = 292,
    NUM = 293,
    LESS = 294,
    GREAT = 295,
    LESS_E = 296,
    GREAT_E = 297,
    NOT_EQUAL = 298,
    EQUAL = 299,
    OR = 300,
    AND = 301,
    NAME_PROCEDURE = 302
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
#define ASSIGN 268
#define FLOATING_NUMBER 269
#define BREAK 270
#define RETURN 271
#define END_FUNCTION 272
#define START_PROCEDURE 273
#define CLOSE_BRACKET 274
#define OPEN_BRACKET 275
#define EXP 276
#define DIV 277
#define MUL 278
#define MINUS 279
#define PLUS 280
#define NOT 281
#define ELSE 282
#define ENDIF 283
#define COMMA 284
#define NEWLINE 285
#define ENDWHILE 286
#define INT 287
#define FLOAT 288
#define CHAR 289
#define DOUBLE 290
#define LONG 291
#define ID 292
#define NUM 293
#define LESS 294
#define GREAT 295
#define LESS_E 296
#define GREAT_E 297
#define NOT_EQUAL 298
#define EQUAL 299
#define OR 300
#define AND 301
#define NAME_PROCEDURE 302

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 24 "optimized.y" /* yacc.c:1909  */
char* dataType; char* IdName; struct attributes{
	char* code; 
	char* addr;
	char* specifier;
}A;

#line 155 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
