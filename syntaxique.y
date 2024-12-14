%{
#include <stdio.h>
#include "syntaxique.tab.h"
%}

%token DEBUT EXECUTION FIN NUM REAL SI ALORS TEXT SINON TANTQUE FAIRE
%token ID CST STRING ET_LOGIQUE OU_LOGIQUE NEGATION FIXE AFFICHE LIRE EGAL DIFFERENT 
%token ASSIGNATION SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL AFFECTATION PLUS MOINS MUL DIV POINT_VIRGULE
%token DEUX_POINTS VIRGULE POINT PARENTHESE_OUVRANTE PARENTHESE_FERMANTE CROCHET_OUVRANT 
%token CROCHET_FERMANT ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token GUILLEMENT DOUBLE_SHARP
%token COMMENT_SINGLE COMMENT_MULTI

%union {
    int entier;
    char* str;    
}
%left OU_LOGIQUE      
%left ET_LOGIQUE    
%left NEGATION   
%left EGAL DIFFERENT SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL
%left PLUS MOINS
%left MUL DIV

%start program


%%

program:
    DEBUT declarations EXECUTION block FIN
    ;

declarations:
    /* vide */
    | declarations declaration
    ;

declaration:
    type DEUX_POINTS ID 
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT 
    | FIXE type DEUX_POINTS ID ASSIGNATION CST 
    ;

type:
    NUM
    | REAL
    | TEXT
    ;

block:
    ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    ;

instructions:
    /* vide */
    | instruction instructions
    ;

instruction:
    COMMENT_SINGLE
    | COMMENT_MULTI
    | affectation
    | assignation
    | instSI
    | instTantQue
    | affiche
    | lire
    ;

assignation:
    ID ASSIGNATION expression
    ;

affectation:
    ID AFFECTATION expression
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT AFFECTATION expression
    ;

variables:
    CST
    | ID
    ;

expression:
    arithmetique                     /* Niveau de base */
    | logique                        /* Logiques produisent des expressions */
    ;

arithmetique:
    variables
    | arithmetique PLUS arithmetique
    | arithmetique MOINS arithmetique
    | arithmetique MUL arithmetique
    | arithmetique DIV arithmetique
    | PARENTHESE_OUVRANTE arithmetique PARENTHESE_FERMANTE
    ;

logique:
    comparaison                     /* Comparaison comme base logique */
    | logique ET_LOGIQUE logique    /* Opérateur logique `ET` */
    | logique OU_LOGIQUE logique    /* Opérateur logique `OU` */
    | NEGATION logique              /* Négation */
    | PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE
    ;

comparaison:
    arithmetique comparaison_operateurs arithmetique
    ;

comparaison_operateurs:
    EGAL
    | DIFFERENT
    | SUPERIEUR
    | SUP_EGAL
    | INFERIEUR
    | INF_EGAL
    ;

instSI:
    SI PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE ALORS block SINON block
    | SI PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE ALORS block
    ;

instTantQue:
    TANTQUE PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE FAIRE block
    ;

affiche:
    AFFICHE PARENTHESE_OUVRANTE GUILLEMENT expression GUILLEMENT PARENTHESE_FERMANTE
    | AFFICHE PARENTHESE_OUVRANTE GUILLEMENT expression GUILLEMENT PLUS ID PARENTHESE_FERMANTE
    ;

lire:
    LIRE PARENTHESE_OUVRANTE variables PARENTHESE_FERMANTE 
    ;

%%

int main() {
    return yyparse();
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);
    return 0;
}
