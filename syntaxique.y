%{
#include <stdio.h>
#include <stdlib.h>
#include "syntaxique.tab.h"
#include "TS.h"
// Fonction pour vérifier la division par zéro
void check_division_by_zero(int value) {
    if (value == 0) {
        fprintf(stderr, "Erreur: Division par zéro\n");
        exit(EXIT_FAILURE);
    }
}

extern int nb_ligne;
extern int nb_colonne;
void yyerror(const char *msg);

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
%type <entier> logique
%type <entier> comparaison

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
        verifierDoubleDeclaration($3);
        inserer($3, "idf", $1);
    }
    | type DEUX_POINTS ID CROCHET_OUVRANT CST CROCHET_FERMANT POINT_VIRGULE {
        verifierDoubleDeclaration($3);
        inserer($3, "idf", $1);
    }
    | constant
    ;

constant:
    FIXE type DEUX_POINTS ID ASSIGNATION CST POINT_VIRGULE {
        verifierDoubleDeclaration($4);
        inserer($4, "idf", $2);
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
        verifierDeclaration($1);
        TypeTS* var = recherche($1);
        verifierCompatibiliteType(var->TypeEntite, $3);
    }
    ;

affectation:
    ID AFFECTATION expression POINT_VIRGULE {
        verifierDeclaration($1);
        TypeTS* var = recherche($1);
        verifierCompatibiliteType(var->TypeEntite, $3);
    }
    | ID CROCHET_OUVRANT expression CROCHET_FERMANT AFFECTATION expression POINT_VIRGULE {
        verifierDeclaration($1);
        TypeTS* var = recherche($1);
        verifierCompatibiliteType(var->TypeEntite, $6);
    }
    ;

variables:
    CST { $$ = "NUM"; }
    | ID { verifierDeclaration($1); TypeTS* var = recherche($1); $$ = var->TypeEntite; }
    ;

expression:
    arithmetique                     /* Niveau de base */
    | logique  /* Logiques produisent des expressions */   
    | STRING separateurs             
    ;
separateurs:
    DEUX_POINTS
    |POINT
    |POINT_VIRGULE
arithmetique:
    variables
    | arithmetique PLUS arithmetique { verifierCompatibiliteType($1, $3); $$ = $1; }
    | arithmetique MOINS arithmetique { verifierCompatibiliteType($1, $3); $$ = $1; }
    | arithmetique MUL arithmetique { verifierCompatibiliteType($1, $3); $$ = $1; }
    | arithmetique DIV arithmetique {
        check_division_by_zero($3);
        verifierCompatibiliteType($1, $3);
        $$ = $1;
        printf("La division est : %d / %d = %d\n", $1, $3, $$);
    }
    | PARENTHESE_OUVRANTE arithmetique PARENTHESE_FERMANTE { $$ = $2; }
    ;

logique:
    comparaison
    | logique ET_LOGIQUE logique { verifierCompatibiliteType($1, $3); $$ = $1; }
    | logique OU_LOGIQUE logique { verifierCompatibiliteType($1, $3); $$ = $1; }
    | NEGATION logique { $$ = $2; }
    | PARENTHESE_OUVRANTE logique PARENTHESE_FERMANTE { $$ = $2; }
    ;

comparaison:
    arithmetique comparaison_operateurs arithmetique { verifierCompatibiliteType($1, $3); $$ = "NUM"; }
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
    AFFICHE PARENTHESE_OUVRANTE GUILLEMENT expression GUILLEMENT PARENTHESE_FERMANTE
    | AFFICHE PARENTHESE_OUVRANTE GUILLEMENT expression GUILLEMENT PLUS ID PARENTHESE_FERMANTE
    ;

lire:
    LIRE PARENTHESE_OUVRANTE variables PARENTHESE_FERMANTE
    ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Erreur Syntaxique à la ligne %d, colonne %d: %s\n", nb_ligne, nb_colonne, msg);
}
main ()
{
    yyparse();
    afficher();
}
yywrap(){
}