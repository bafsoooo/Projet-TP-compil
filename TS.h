#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Définir la taille de la table de hachage
#define TAILLE_TABLE 100

// Structure de la table de symboles
typedef struct TypeTS {
    char NomEntite[20];
    char CodeEntite[20];
    char TypeEntite[20];
    struct TypeTS* suivant; // Pointeur vers le prochain élément en cas de collision
} TypeTS;

// Table de hachage
TypeTS* table[TAILLE_TABLE];

// Fonction de hachage
unsigned int hash(char* str) {
    unsigned int hash = 0;
    while (*str) {
        hash = (hash << 5) + *str++;
    }
    return hash % TAILLE_TABLE;
}

// Recherche dans la table de hachage
TypeTS* recherche(char* entite) {
    unsigned int index = hash(entite);
    TypeTS* courant = table[index];
    while (courant != NULL) {
        if (strcmp(courant->NomEntite, entite) == 0) {
            return courant;
        }
        courant = courant->suivant;
    }
    return NULL;
}

// Insertion dans la table de hachage
void inserer(char* entite, char* code, char* type) {
    if (recherche(entite) == NULL) {
        unsigned int index = hash(entite);
        TypeTS* nouvelElement = (TypeTS*)malloc(sizeof(TypeTS));
        strcpy(nouvelElement->NomEntite, entite);
        strcpy(nouvelElement->CodeEntite, code);
        strcpy(nouvelElement->TypeEntite, type);
        nouvelElement->suivant = table[index];
        table[index] = nouvelElement;
    }
}
// Insertion du type dans la table de hachage
void insererType(char* entite, char* type) {
    TypeTS* element = recherche(entite);
    if (element != NULL) {
        strcpy(element->TypeEntite, type);
    }
}

// Affichage de la table de hachage
void afficher() {
    printf("\n/*************** Table des symboles ******************/\n");
    printf("_____________________________________________________\n");
    printf("\t| NomEntite  | CodeEntite  | TypeEntite\n");
    printf("_____________________________________________________\n");
    for (int i = 0; i < TAILLE_TABLE; i++) {
        TypeTS* courant = table[i];
        while (courant != NULL) {
            printf("\t|%11s |%13s |%12s |\n", courant->NomEntite, courant->CodeEntite, courant->TypeEntite);
            courant = courant->suivant;
        }
    }
}