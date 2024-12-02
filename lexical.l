%{
#include "syntax.tab.h"
#include <stdio.h>
int nb_ligne = 1;
%}

%%

"DEBUT"                    { printf("Token DEBUT trouvé\n"); return DEBUT; }
"EXECUTION"                { printf("Token EXECUTION trouvé\n"); return EXECUTION; }
"FIN"                      { printf("Token FIN trouvé\n"); return FIN; }
"NUM"                      { printf("Token NUM trouvé\n"); return NUM; }
"REAL"                     { printf("Token REAL trouvé\n"); return REAL; }
"TEXT"                     { printf("Token TEXT trouvé\n"); return TEXT; }
"SI"                       { printf("Token SI trouvé\n"); return SI; }
"ALORS"                    { printf("Token ALORS trouvé\n"); return ALORS; }
"TANTQUE"                  { printf("Token TANTQUE trouvé\n"); return TANTQUE; }
"FAIRE"                    { printf("Token FAIRE trouvé\n"); return FAIRE; }
"ET"                       { printf("Token ET_LOGIQUE trouvé\n"); return ET_LOGIQUE; }
"OU"                       { printf("Token OU_LOGIQUE trouvé\n"); return OU_LOGIQUE; }
"NON"                      { printf("Token NEGATION trouvé\n"); return NEGATION; }
"FIXE"                     { printf("Token FIXE trouvé\n"); return FIXE; }
"afficher"                 { printf("Token AFFICHE trouvé\n"); return AFFICHE; }
"lire"                     { printf("Token LIRE trouvé\n"); return LIRE; }
[a-zA-Z][A-Za-z0-9_éèêàùçàôâîù]{0,9}  { printf("Identifiant : %s\n", yytext); return ID; }
[0-9]+                     { printf("Constante entière : %s\n", yytext); return CST; }
"=="                       { printf("Token EGAL trouvé\n"); return EGAL; }
"!="                       { printf("Token DIFFERENT trouvé\n"); return DIFFERENT; }
"="                        { printf("Token ASSIGNATION trouvé\n"); return ASSIGNATION; }
">"                        { printf("Token SUPERIEUR trouvé\n"); return SUPERIEUR; }
">="                       { printf("Token SUP_EGAL trouvé\n"); return SUP_EGAL; }
"<"                        { printf("Token INFERIEUR trouvé\n"); return INFERIEUR; }
"<="                       { printf("Token INF_EGAL trouvé\n"); return INF_EGAL; }
"<-"                       { printf("Token AFFECTATION trouvé\n"); return AFFECTATION; }
"+"                        { printf("Token PLUS trouvé\n"); return PLUS; }
"-"                        { printf("Token MOINS trouvé\n"); return MOINS; }
"*"                        { printf("Token FOIS trouvé\n"); return FOIS; }
"/"                        { printf("Token DIVISER trouvé\n"); return DIVISER; }
";"                        { printf("Token POINT_VIRGULE trouvé\n"); return POINT_VIRGULE; }
":"                        { printf("Token DEUX_POINTS trouvé\n"); return DEUX_POINTS; }
","                        { printf("Token VIRGULE trouvé\n"); return VIRGULE; }
"."                        { printf("Token POINT trouvé\n"); return POINT; }
"("                        { printf("Token PARENTHESE_OUVRANTE trouvé\n"); return PARENTHESE_OUVRANTE; }
")"                        { printf("Token PARENTHESE_FERMANTE trouvé\n"); return PARENTHESE_FERMANTE; }
"["                        { printf("Token CROCHET_OUVRANT trouvé\n"); return CROCHET_OUVRANT; }
"]"                        { printf("Token CROCHET_FERMANT trouvé\n"); return CROCHET_FERMANT; }
"{"                        { printf("Token ACCOLADE_OUVRANTE trouvé\n"); return ACCOLADE_OUVRANTE; }
"}"                        { printf("Token ACCOLADE_FERMANTE trouvé\n"); return ACCOLADE_FERMANTE; }
"\""                       { printf("Token GUILLEMENT trouvé\n"); return GUILLEMENT; }
"##"                       { printf("Token DOUBLE_SHARP trouvé\n"); return DOUBLE_SHARP; }
"\"([^\"\\]|\\.)*\""       { printf("Chaîne de caractères : %s\n", yytext); return STRING; }
"--"([^#\n]*|#[^#])*"##"   { printf("Commentaire sur une seule ligne ignoré\n"); }
"{-([^{}]*|{[^-]*)*-}"     { printf("Commentaire multi-ligne ignoré\n"); }

[ \t\r]+                   { /* Ignorer les espaces et tabulations */ }
\n                         { nb_ligne++; printf("Nouvelle ligne (%d)\n", nb_ligne); }
.                          { printf("Token non reconnu : %s\n", yytext); }


%%

int yywrap() {
    return 1;  // Indiquer que la lecture du fichier est terminée
}
int main(){
int token;
    while ((token = yylex()) != 0) { // Continuer jusqu'à la fin du fichier
        // yylex() retourne 0 à la fin de l'entrée
    }
    return 0;
}