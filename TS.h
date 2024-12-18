#ifndef TS_H
#define TS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Définir la taille de la table de hachage
#define TAILLE_TABLE 100

// Structure de la table de symboles
typedef struct TypeTS {
    char NomEntite[20];       // Nom du symbole
    char TypeEntite[20];      // Type du symbole (int, float, char, etc.)
    char Categorie[20];       // Catégorie du symbole (Variable simple, Constante, Tableau, Fonction)
    int AdresseMemoire;       // Adresse mémoire (offset)
    int Taille;               // Taille (pour les tableaux)
    char Portee[20];          // Portée (locale, globale, etc.)
    char Valeur[50];          // Valeur (si constante ou variable initialisée)
    struct TypeTS* suivant;   // Pointeur vers le prochain élément en cas de collision
} TypeTS;

// Table de hachage
extern TypeTS* table[TAILLE_TABLE];

// Fonction de hachage
unsigned int hash(char* str);

// Recherche dans la table de hachage
TypeTS* recherche(char* entite);

// Insertion dans la table de hachage
void inserer(char* entite, char* type, char* categorie, int adresseMemoire, int taille, char* portee, char* valeur);

// Insertion du type dans la table de hachage
void insererType(char* entite, char* type);

// Vérification de la déclaration d'une variable
void verifierDeclaration(char* entite);

// Vérification de la double déclaration d'une variable
void verifierDoubleDeclaration(char* entite);

// Vérification de la compatibilité des types
void verifierCompatibiliteType(char* type1, char* type2);

// Vérification de la modification d'une constante
void verifierModificationConstante(char* entite);

// Vérification du dépassement de la taille d'un tableau
void verifierDepassementTailleTableau(char* entite, int index);

// Affichage de la table de hachage
void afficher();

#endif // TS_H