%{
#include <stdio.h>
#include <stdlib.h>
#include "syntaxique.tab.h"  // Inclure les tokens définis

void check_division_by_zero(int value) {
    if (value == 0) {
        fprintf(stderr, "Erreur: Division par zéro\n");
        exit(EXIT_FAILURE);
    }
}
%}

%union {
    int entier;
    char* str; 
    float numvrg;   
}

%token DEBUT EXECUTION FIN NUM REAL SI ALORS TEXT SINON TANTQUE FAIRE
%token ID CST STRING ET_LOGIQUE OU_LOGIQUE NEGATION FIXE AFFICHE LIRE EGAL DIFFERENT 
%token ASSIGNATION SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL AFFECTATION PLUS MOINS MUL DIV POINT_VIRGULE
%token DEUX_POINTS VIRGULE POINT PARENTHESE_OUVRANTE PARENTHESE_FERMANTE CROCHET_OUVRANT 
%token CROCHET_FERMANT ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token GUILLEMENT DOUBLE_SHARP
%token COMMENT_SINGLE COMMENT_MULTI

%type <entier> CST
%type <str> ID STRING
%type <numvrg> NUM REAL

%start program

%%

program:
    DEBUT declarations EXECUTION block FIN {
        printf("Programme syntaxiquement correct.\n");
    }
    ;

declarations:

    /* Liste de déclarations */
    declaration
    | declarations declaration
    | /* vide */
    ;

declaration:
        type DEUX_POINTS ID POINT_VIRGULE
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT POINT_VIRGULE
    | FIXE type DEUX_POINTS ID ASSIGNATION CST POINT_VIRGULE 

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
    /* Liste d'instructions */
    | COMMENT_SINGLE
    | COMMENT_MULTI
    | affectation
    | instSI
    | instTantQue
    | affiche
    | lire
    instruction instructions
    | /* vide */
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
   ID ASSIGNATION ID 
   |ID ASSIGNATION ID operateur variables
   ;
    ID AFFECTATION expression POINT_VIRGULE;

variables:
    CST
    | ID
    ;

expression:
    variables                              /* Une variable ou une constante */
   | expression PLUS expression           /* Opérations arithmétiques */
    | expression MOINS expression
    | expression MUL expression
    | expression DIV expression {
        check_division_by_zero($3);
        printf("la divion est%s= %s/%d",$1,$3,$$);
        YYACCEPT;
    }
    | expression ET_LOGIQUE expression     /* Opération logique ET */
    | expression OU_LOGIQUE expression     /* Opération logique OU */
    | NEGATION expression                  /* Négation */
    | expression comparaison expression    /* Comparaison */
    | PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE  /* Expression entre parenthèses */
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT       /* Accès à un tableau */
    | expression DEUX_POINTS
    ;

comparaison:
    EGAL
    | DIFFERENT
    | SUPERIEUR
    | SUP_EGAL
    | INFERIEUR
    | INF_EGAL
    ;

operateur:
    PLUS 
    | MOINS
    | MUL 
    | DIV
    ;

instSI:
    SI PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE ALORS ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE SINON ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    | SI PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE ALORS ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    ;

instTantQue:
    TANTQUE PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE FAIRE ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    ;

affiche:
    AFFICHE PARENTHESE_OUVRANTE GUILLEMENT expression GUILLEMENT PARENTHESE_FERMANTE  /* Chaîne simple */
    | AFFICHE PARENTHESE_OUVRANTE GUILLEMENT expression GUILLEMENT PLUS ID PARENTHESE_FERMANTE  /* Chaîne + Expression */
    ;

lire:
    LIRE PARENTHESE_OUVRANTE variables PARENTHESE_FERMANTE 
    ;
%%

int main() {
    afficher();
    return yyparse();  // Appel de l'analyseur syntaxique généré par Bison
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);  // Utiliser fprintf pour afficher sur stderr
    return 0;
}