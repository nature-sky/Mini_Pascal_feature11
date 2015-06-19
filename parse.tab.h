/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

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

#ifndef YY_YY_PARSE_TAB_H_INCLUDED
# define YY_YY_PARSE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT_ = 258,
    TEXT_ = 259,
    ID_ = 260,
    AND_ = 261,
    DIV_ = 262,
    DOWNTO_ = 263,
    GE_ = 264,
    LE_ = 265,
    MOD_ = 266,
    NE_ = 267,
    NOT_ = 268,
    OR_ = 269,
    TO_ = 270,
    ARRAY_ = 271,
    BEGIN_ = 272,
    CASE_ = 273,
    CONST_ = 274,
    DO_ = 275,
    ELSE_ = 276,
    END_ = 277,
    FOR_ = 278,
    FUNCTION_ = 279,
    IF_ = 280,
    NIL_ = 281,
    OF_ = 282,
    PROCEDURE_ = 283,
    PROGRAM_ = 284,
    RECORD_ = 285,
    REPEAT_ = 286,
    THEN_ = 287,
    TYPE_ = 288,
    UNTIL_ = 289,
    VAR_ = 290,
    WHILE_ = 291,
    COLON_EQ_ = 292,
    DOT_DOT_ = 293
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 15 "parse.y" /* yacc.c:1909  */

  int        ival;     /* INTEGER literals */
  TEXT      *tval;     /* string literals (points to text table entry) */
  IDENT     *id;       /* identifiers (points to identifier table entry) */
  PROGRAM   *prog_;
  BLOCK     *block_;
  DECLLIST  *decllist_;
  DECL      *decl_;
  EXPR      *expr_;
  TYPE      *type_;
  STMT      *stmt_;
  STMTLIST  *stmtlist_;
  MODEWHICH  mode_;
  FIELDLIST *fieldlist_;
  CASELIST  *caselist_;
  CASEARM   *casearm_;
  EXPRLIST  *exprlist_;
  BINDLIST  *bindlist_;

#line 113 "parse.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSE_TAB_H_INCLUDED  */
