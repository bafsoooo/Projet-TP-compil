%{
#include "syntaxique.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define _GNU_SOURCE
#include "TS.h"
extern YYSTYPE yylval;
int nb_ligne = 1;
%}

%%

"DEBUT"                    { return DEBUT; }
"EXECUTION"                { return EXECUTION; }
"FIN"                      { return FIN; }
"NUM"                      { yylval.str = strdup(yytext); return NUM; }
"REAL"                     { yylval.str = strdup(yytext); return REAL; }
"TEXT"                     { yylval.str = strdup(yytext); return TEXT; }
"SI"                       { return SI; }
"SINON"                    { return SINON; }
"ALORS"                    { return ALORS; }
"TANTQUE"                  { return TANTQUE; }
"FAIRE"                    { return FAIRE; }
"ET"                       { return ET_LOGIQUE; }
"OU"                       { return OU_LOGIQUE; }
"NON"                      { return NEGATION; }
"FIXE"                     { return FIXE; }
"affiche"                  { return AFFICHE; }
"lire"                     { return LIRE; }
\"([^\"\\]|\\.)*\"         { yylval.str = strdup(yytext); return STRING; }
[A-Za-z][A-Za-z0-9_éèêàùçàôâîù]{0,9}  { yylval.str = strdup(yytext); return ID; }
[0-9]+                     { yylval.entier = atoi(yytext); return CST; }
"=="                       { return EGAL; }
"!="                       { return DIFFERENT; }
"="                        { return ASSIGNATION; }
">"                        { return SUPERIEUR; }
">="                       { return SUP_EGAL; }
"<"                        { return INFERIEUR; }
"<="                       { return INF_EGAL; }
"<-"                       { return AFFECTATION; }
"+"                        { return PLUS; }
"-"                        { return MOINS; }
"*"                        { return MUL; }
"/"                        { return DIV; }
";"                        { return POINT_VIRGULE; }
":"                        { return DEUX_POINTS; }
","                        { return VIRGULE; }
"."                        { return POINT; }
"("                        { return PARENTHESE_OUVRANTE; }
")"                        { return PARENTHESE_FERMANTE; }
"["                        { return CROCHET_OUVRANT; }
"]"                        { return CROCHET_FERMANT; }
"{"                        { return ACCOLADE_OUVRANTE; }
"}"                        { return ACCOLADE_FERMANTE; }
"--"([^#\n]*|#[^#])*"##"   { return COMMENT_SINGLE; }
"\\{-"(.|\n)*?"-\\}"       { /* Ignore multi-line comment */ }
[ \t\r]+                   { /* Ignore spaces and tabs */ }
\n                         { nb_ligne++; }
.                          { /* Ignore unrecognized tokens */ }

%%



