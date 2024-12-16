
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     DEBUT = 258,
     EXECUTION = 259,
     FIN = 260,
     NUM = 261,
     REAL = 262,
     SI = 263,
     ALORS = 264,
     TEXT = 265,
     SINON = 266,
     TANTQUE = 267,
     FAIRE = 268,
     ID = 269,
     CST = 270,
     STRING = 271,
     ET_LOGIQUE = 272,
     OU_LOGIQUE = 273,
     NEGATION = 274,
     FIXE = 275,
     AFFICHE = 276,
     LIRE = 277,
     EGAL = 278,
     DIFFERENT = 279,
     ASSIGNATION = 280,
     SUPERIEUR = 281,
     SUP_EGAL = 282,
     INFERIEUR = 283,
     INF_EGAL = 284,
     AFFECTATION = 285,
     PLUS = 286,
     MOINS = 287,
     MUL = 288,
     DIV = 289,
     POINT_VIRGULE = 290,
     DEUX_POINTS = 291,
     VIRGULE = 292,
     POINT = 293,
     PARENTHESE_OUVRANTE = 294,
     PARENTHESE_FERMANTE = 295,
     CROCHET_OUVRANT = 296,
     CROCHET_FERMANT = 297,
     ACCOLADE_OUVRANTE = 298,
     ACCOLADE_FERMANTE = 299,
     GUILLEMENT = 300,
     DOUBLE_SHARP = 301,
     COMMENT_SINGLE = 302,
     COMMENT_MULTI = 303
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 15 "syntaxique.y"

    int entier;     // Pour les constantes entières
    char* str;      // Pour les chaînes de caractères
    float numvrg;   // Pour les constantes réelles



/* Line 1676 of yacc.c  */
#line 108 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


