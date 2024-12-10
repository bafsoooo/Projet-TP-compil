%{
#include <stdio.h>
#include "syntaxique.tab.h"  // Inclure les tokens définis
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
    /* Liste d'instructions */
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
affectation:
    ID AFFECTATION expression 
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT AFFECTATION expression 
    ;

variables:
    CST
    | ID
    ;

expression:
    variables                              /* Une variable ou une constante */
    | expression operateur expression      /* Opérations arithmétiques */
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
    return yyparse();  // Appel de l'analyseur syntaxique généré par Bison
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);  // Utiliser fprintf pour afficher sur stderr
    return 0;
}
