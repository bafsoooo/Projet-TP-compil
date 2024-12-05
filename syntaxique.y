%{
#include <stdio.h>
#include "syntaxique.tab.h"  // Inclure les tokens définis
%}

%token DEBUT EXECUTION FIN NUM REAL SI ALORS TEXT ELSE TANTQUE FAIRE
%token ID CST STRING ET_LOGIQUE OU_LOGIQUE NEGATION FIXE AFFICHE LIRE EGAL DIFFERENT ASSIGNATION SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL AFFECTATION PLUS MOINS FOIS DIVISER POINT_VIRGULE DEUX_POINTS VIRGULE POINT PARENTHESE_OUVRANTE PARENTHESE_FERMANTE CROCHET_OUVRANT CROCHET_FERMANT ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token GUILLEMENT DOUBLE_SHARP
%token E_ACUTE E_GRAVE E_CIRCUMFLEX A_GRAVE U_GRAVE C_CEDILLA O_CIRCUMFLEX A_CIRCUMFLEX I_CIRCUMFLEX
%token COMMENT_SINGLE COMMENT_MULTI

%start program

%%

program:
    DEBUT declarations EXECUTION block FIN {
        printf("Programme syntaxiquement correct.\n");
    }
    ;

declarations:
    /* Liste de déclarations de variables */
    | declarations declaration
    | /* vide */
    ;

declaration:
    type ID POINT_VIRGULE
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
    ;

%%

int main() {
    return yyparse();  // Appel de l'analyseur syntaxique généré par Bison
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);  // Utiliser fprintf pour afficher sur stderr
    return 0;
}
