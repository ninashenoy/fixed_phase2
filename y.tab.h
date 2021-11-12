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
    L_PAREN = 258,
    R_PAREN = 259,
    L_SQUARE_BRACKET = 260,
    R_SQUARE_BRACKET = 261,
    ADD = 262,
    SUB = 263,
    MULT = 264,
    DIV = 265,
    MOD = 266,
    EQ = 267,
    NEQ = 268,
    LT = 269,
    LTE = 270,
    GT = 271,
    GTE = 272,
    AND = 273,
    OR = 274,
    NOT = 275,
    ASSIGN = 276,
    FUNCTION = 277,
    BEGIN_PARAMS = 278,
    END_PARAMS = 279,
    BEGIN_LOCALS = 280,
    END_LOCALS = 281,
    BEGIN_BODY = 282,
    END_BODY = 283,
    CONTINUE = 284,
    INTEGER = 285,
    ARRAY = 286,
    OF = 287,
    IF = 288,
    THEN = 289,
    ENDIF = 290,
    WHILE = 291,
    DO = 292,
    BEGINLOOP = 293,
    ENDLOOP = 294,
    BREAK = 295,
    READ = 296,
    WRITE = 297,
    TRUE = 298,
    FALSE = 299,
    RETURN = 300,
    SEMICOLON = 301,
    COLON = 302,
    COMMA = 303,
    ELSE = 304,
    IDENT = 305,
    NUMBER = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 22 "mini_l.y" /* yacc.c:1909  */
 
	int num_val;
	char *ident_val;

#line 111 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
