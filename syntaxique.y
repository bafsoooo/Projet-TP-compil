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

<<<<<<< HEAD
<<<<<<< HEAD

 
=======
>>>>>>> 2b17d74aea473e47d0ade34e0b4b21052dd6849e
=======

 
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
%start program

%%

program:
    DEBUT declarations EXECUTION block FIN {
        printf("Programme syntaxiquement correct.\n");
    }
    ;

declarations:
<<<<<<< HEAD
<<<<<<< HEAD
=======
    /* Liste de déclarations */
>>>>>>> 2b17d74aea473e47d0ade34e0b4b21052dd6849e
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
    declaration
    | declarations declaration
    | /* vide */
    ;

declaration:
<<<<<<< HEAD
<<<<<<< HEAD
    type DEUX_POINTS ID POINT_VIRGULE
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT POINT_VIRGULE
    | FIXE type DEUX_POINTS ID ASSIGNATION CST POINT_VIRGULE 
=======
    type DEUX_POINTS ID 
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT 
    | FIXE type DEUX_POINTS ID ASSIGNATION CST 
>>>>>>> 2b17d74aea473e47d0ade34e0b4b21052dd6849e
=======
    type DEUX_POINTS ID POINT_VIRGULE
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT POINT_VIRGULE
    | FIXE type DEUX_POINTS ID ASSIGNATION CST POINT_VIRGULE 
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
    | COMMENT_SINGLE
    | COMMENT_MULTI
    | affectation
    | instSI
    | instTantQue
    | affiche
    | lire
<<<<<<< HEAD
=======
    instruction instructions
    | /* vide */
>>>>>>> 2b17d74aea473e47d0ade34e0b4b21052dd6849e
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
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
<<<<<<< HEAD
=======
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
>>>>>>> 2b17d74aea473e47d0ade34e0b4b21052dd6849e
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
    ;

comparaison:
    EGAL
    | DIFFERENT
    | SUPERIEUR
    | SUP_EGAL
    | INFERIEUR
    | INF_EGAL
    ;

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
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
<<<<<<< HEAD
=======
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

>>>>>>> 2b17d74aea473e47d0ade34e0b4b21052dd6849e
=======
>>>>>>> d12b265f9d4a01db78d17e8e15a75faf5c95c6f8
%%

int main() {
    return yyparse();  // Appel de l'analyseur syntaxique généré par Bison
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);  // Utiliser fprintf pour afficher sur stderr
    return 0;
}