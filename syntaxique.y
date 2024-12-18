%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "syntaxique.tab.h"
int yyerror(char *s);
extern int yylex();
extern int yylineno;

// Fonction pour vérifier la division par zéro
void check_division_by_zero(int value) {
    if (value == 0) {
        fprintf(stderr, "Erreur: Division par zéro\n");
        exit(EXIT_FAILURE);
    }
}
%}

%union {
    int entier;     // Pour les constantes entières
    char* str;      // Pour les chaînes de caractères
    float numvrg;   // Pour les constantes réelles
}

%token DEBUT EXECUTION FIN NUM REAL SI ALORS TEXT SINON TANTQUE FAIRE
%token ID CST STRING ET_LOGIQUE OU_LOGIQUE NEGATION FIXE AFFICHE LIRE EGAL DIFFERENT 
%token ASSIGNATION SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL AFFECTATION PLUS MOINS MUL DIV POINT_VIRGULE
%token DEUX_POINTS VIRGULE POINT PARENTHESE_OUVRANTE PARENTHESE_FERMANTE CROCHET_OUVRANT 
%token CROCHET_FERMANT ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token GUILLEMENT DOUBLE_SHARP
%token COMMENT_SINGLE COMMENT_MULTI

%left OU_LOGIQUE      
%left ET_LOGIQUE    
%left NEGATION   
%left EGAL DIFFERENT SUPERIEUR SUP_EGAL INFERIEUR INF_EGAL
%left PLUS MOINS
%left MUL DIV

%type <entier> CST
%type <str> ID STRING
%type <numvrg> NUM REAL
%type <str> type
%type <entier> variables
%type <entier> arithmetique
%type <entier> comparaison
%type <entier> affectation





%start program

%%

program:
    DEBUT declarations EXECUTION block FIN {
        printf("Programme syntaxiquement correct.\n");
        YYACCEPT;
    }
    ;

declarations:
     declarations declaration
    | /* vide */
    ;

declaration:
    type DEUX_POINTS ID POINT_VIRGULE {
        // Insertion d'une variable simple
        inserer($3, $1, "Variable simple", 0, 0, "globale", "");
    }
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT POINT_VIRGULE {
        // Insertion d'un tableau
        inserer($3, $1, "Tableau", 0, $5, "globale", "");
    }
    | constant
    ;

constant:
    FIXE type DEUX_POINTS ID ASSIGNATION CST POINT_VIRGULE {
        // Insertion d'une constante
        char valeur[20];
        sprintf(valeur, "%d", $6);
        inserer($4, $2, "Constante", 0, 0, "globale", valeur);
    }
    ;

type:
    NUM { $$ = "NUM"; }
    | REAL { $$ = "REAL"; }
    | TEXT { $$ = "TEXT"; }
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
    ID ASSIGNATION expression POINT_VIRGULE {
        verifierDeclaration($1);  // Vérification de l'existence dans la table
    }
    ;

   affectation:
    ID AFFECTATION expression POINT_VIRGULE
    {
        printf("Affectation : %s = %d\n", $1, $3);
    }
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT AFFECTATION expression POINT_VIRGULE
    {
        printf("Affectation : %s[%d] = %d\n", $1, $3, $6);
    }
;

variables:
    CST { $$ = $1; }
    | ID { $$ = 0; }
    ;

expression:
    arithmetique                     /* Niveau de base */
    | logique  /* Logiques produisent des expressions */   
;
arithmetique:
    variables
    | arithmetique PLUS arithmetique  { $$ = $1 + $3; }
    | arithmetique MOINS arithmetique { $$ = $1 - $3; }
    | arithmetique MUL arithmetique { $$ = $1 * $3; }
    | arithmetique DIV arithmetique {
        check_division_by_zero($3);
        $$ = $1 / $3;
        printf("La division est : %d / %d = %d\n", $1, $3, $$);
    }
    | PARENTHESE_OUVRANTE arithmetique PARENTHESE_FERMANTE { $$ = $2; }
    ;

logique:
    comparaison
    | logique ET_LOGIQUE logique
    | logique OU_LOGIQUE logique
    | NEGATION logique
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
    SI PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE ALORS block
    | SI PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE ALORS block SINON block
    ;

instTantQue:
    TANTQUE PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE FAIRE block
    ;

affiche:
    AFFICHE PARENTHESE_OUVRANTE STRING PARENTHESE_FERMANTE POINT_VIRGULE
    | AFFICHE PARENTHESE_OUVRANTE STRING VIRGULE ID PARENTHESE_FERMANTE POINT_VIRGULE {
        verifierDeclaration($4);
    }
    | AFFICHE PARENTHESE_OUVRANTE STRING VIRGULE STRING PARENTHESE_FERMANTE POINT_VIRGULE
    ;
lire:
    LIRE PARENTHESE_OUVRANTE ID PARENTHESE_FERMANTE POINT_VIRGULE {
        verifierDeclaration($3);
    }
    ;

%%

int yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);
    return 0;
}

int main() {
    yyparse();
    afficher();  // Afficher la table des symboles à la fin
    return 0;
}

int yywrap() { return 1; }