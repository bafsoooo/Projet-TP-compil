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
    ID AFFECTATION expression POINT_VIRGULE;

variables:
    CST
    | ID

expression:
    variables
    | expression operateur expression
    | expression ET_LOGIQUE expression
    | expression OU_LOGIQUE expression
    | NEGATION expression
    | expression comparaison expression
    | PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT  /* Accès à un tableau */
    ;

comparaison:
    EGAL
    | DIFFERENT
    | SUPERIEUR
    | SUP_EGAL
    | INFERIEUR
    | INF_EGAL
    ;

operateur :
   PLUS 
   | MOINS
   | MUL 
   | DIV
   ;


instSI :
    SI PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE ALORS ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    | SI PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE ALORS ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE SINON ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE  
    

instTantQue :
    TANTQUE PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE FAIRE ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE

affiche :
    AFFICHE PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE

lire:
    LIRE PARENTHESE_OUVRANTE variables  PARENTHESE_FERMANTE
%%

int main() {
    return yyparse();  // Appel de l'analyseur syntaxique généré par Bison
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);  // Utiliser fprintf pour afficher sur stderr
    return 0;
}