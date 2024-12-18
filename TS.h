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
void inserer(char* entite, char* type, char* categorie, int adresseMemoire, int taille, char* portee, char* valeur) {
    if (recherche(entite) == NULL) {
        unsigned int index = hash(entite);
        TypeTS* nouvelElement = (TypeTS*)malloc(sizeof(TypeTS));
        strcpy(nouvelElement->NomEntite, entite);
        strcpy(nouvelElement->TypeEntite, type);
        strcpy(nouvelElement->Categorie, categorie);
        nouvelElement->AdresseMemoire = adresseMemoire;
        nouvelElement->Taille = taille;
        strcpy(nouvelElement->Portee, portee);
        strcpy(nouvelElement->Valeur, valeur);
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

// Vérification de la déclaration d'une variable
void verifierDeclaration(char* entite) {
    if (recherche(entite) == NULL) {
        fprintf(stderr, "Erreur sémantique : Variable '%s' non déclarée\n", entite);
        exit(EXIT_FAILURE);
    }
}

// Vérification de la double déclaration d'une variable
void verifierDoubleDeclaration(char* entite) {
    if (recherche(entite) != NULL) {
        fprintf(stderr, "Erreur sémantique : Variable '%s' déjà déclarée\n", entite);
        exit(EXIT_FAILURE);
    }
}

// Vérification de la compatibilité des types
void verifierCompatibiliteType(char* type1, char* type2) {
    if (strcmp(type1, type2) != 0) {
        fprintf(stderr, "Erreur sémantique : Incompatibilité de type entre '%s' et '%s'\n", type1, type2);
        exit(EXIT_FAILURE);
    }
}

// Vérification de la modification d'une constante
void verifierModificationConstante(char* entite) {
    TypeTS* element = recherche(entite);
    if (element != NULL && strcmp(element->Categorie, "Constante") == 0) {
        fprintf(stderr, "Erreur sémantique : Modification de la valeur de la constante '%s'\n", entite);
        exit(EXIT_FAILURE);
    }
}

// Vérification du dépassement de la taille d'un tableau
void verifierDepassementTailleTableau(char* entite, int index) {
    TypeTS* element = recherche(entite);
    if (element != NULL && strcmp(element->Categorie, "Tableau") == 0) {
        if (index >= element->Taille) {
            fprintf(stderr, "Erreur sémantique : Dépassement de la taille du tableau '%s' (index %d, taille %d)\n", entite, index, element->Taille);
            exit(EXIT_FAILURE);
        }
    }
}

// Affichage de la table de hachage
void afficher() {
    printf("\n/*************** Table des symboles ******************/\n");
    printf("_____________________________________________________\n");
    printf("| NomEntite  | TypeEntite  | Categorie  | AdresseMemoire | Taille | Portee | Valeur\n");
    printf("_____________________________________________________\n");
    for (int i = 0; i < TAILLE_TABLE; i++) {
        TypeTS* courant = table[i];
        while (courant != NULL) {
            printf("|%11s |%11s |%11s |%14d |%6d |%7s |%6s |\n", 
                   courant->NomEntite, courant->TypeEntite, courant->Categorie, 
                   courant->AdresseMemoire, courant->Taille, courant->Portee, courant->Valeur);
            courant = courant->suivant;
        }
    }
}