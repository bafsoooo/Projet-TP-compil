%{
#include <stdio.h>
#include "syntaxique.tab.h"  // Inclure les tokens définis
%}

%token DEBUT EXECUTION FIN NUM REAL SI ALORS TEXT ELSE TANTQUE FAIRE
%token ID CST STRING ET_LOGIQUE OU_LOGIQUE NEGATION FIXE AFFICHE LIRE EGAL DIFFERENT 
ASSIGNATION SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL AFFECTATION PLUS MOINS MUL DIV POINT_VIRGULE
 DEUX_POINTS VIRGULE POINT PARENTHESE_OUVRANTE PARENTHESE_FERMANTE CROCHET_OUVRANT 
 CROCHET_FERMANT ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token GUILLEMENT DOUBLE_SHARP
%token COMMENT_SINGLE COMMENT_MULTI

 
%start program

%%

program:
    DEBUT declarations EXECUTION block FIN {
        printf("Programme syntaxiquement correct.\n");
    }
    ;

declarations:
<<<<<<< HEAD
    declaration
    | declarations declaration
    ;

declaration:
    type DEUX_POINTS ID POINT_VIRGULE
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT POINT_VIRGULE
    | FIXE type DEUX_POINTS ID ASSIGNATION CST POINT_VIRGULE 
=======
    /* Liste de déclarations de variables */
    | declarations declaration
    | /* vide */
    ;

declaration:
    type ID POINT_VIRGULE
>>>>>>> a382003054059738377d2ab761e849a761abd61f
    ;

type:
    NUM
    | REAL
    | TEXT
    ;
<<<<<<< HEAD
    
=======

>>>>>>> a382003054059738377d2ab761e849a761abd61f
block:
    ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    ;

instructions:
    /* Liste d'instructions */
    | COMMENT_SINGLE
    | COMMENT_MULTI
<<<<<<< HEAD
    | affectation
    ;

affectation:
    ID AFFECTATION expression POINT_VIRGULE
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT AFFECTATION expression POINT_VIRGULE
    ;

expression:
    CST
    | ID
    | expression OPERATEUR expression
    | expression ET_LOGIQUE expression
    | expression OU_LOGIQUE expression
    | NEGATION expression
    | expression COMPARAISON expression
    | PARENTHESE_OUVRANTE expression PARENTHESE_FERMANTE
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT  /* Accès à un tableau */
    ;

COMPARAISON:
    EGAL
    | DIFFERENT
    | SUPERIEUR
    | SUP_EGAL
    | INFERIEUR
    | INF_EGAL
    ;

OPERATEUR :
   PLUS 
   | MOINS
   | MUL 
   | DIV
   ;

=======
    ;

>>>>>>> a382003054059738377d2ab761e849a761abd61f
%%

int main() {
    return yyparse();  // Appel de l'analyseur syntaxique généré par Bison
}

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);  // Utiliser fprintf pour afficher sur stderr
    return 0;
}
