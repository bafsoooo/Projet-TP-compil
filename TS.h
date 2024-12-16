// structure de la table de symbole
typedef struct
{
    char NomEntite[20];
    char CodeEntite[20];
    char TypeEntite[20];
} TypeTS;
// initiation d'un tableau qui va contenir les elements de la table de symbole
TypeTS ts[100];
// un compteur global pour la table de symbole
int CpTabSym = 0;

int recherche(char entite[])
{
    int i = 0;
    while (i < CpTabSym)
    {
        if (strcmp(entite, ts[i].NomEntite) == 0)
            return i;
        i++;
    }
    return -1;
}

void inserer(char entite[], char code[])
{
    if (recherche(entite) == -1)
    {
        strcpy(ts[CpTabSym].NomEntite, entite);
        strcpy(ts[CpTabSym].CodeEntite, code);
        CpTabSym++;
    }
}

void insererType(char entite[], char type[])
{
    int pos = recherche(entite);
    if (pos != -1)
    {
        strcpy(ts[pos].TypeEntite, type);
    }
}

void afficher()
{
    printf("\n/*************** Table des symboles ******************/\n");
    printf("_____________________________________________________\n");
    printf("\t| NomEntite  | CodeEntite  | TypeEntite\n");
    printf("_____________________________________________________\n");
    int i = 0;
    while (i < CpTabSym)
    {
        printf("\t|%11s |%13s |%12s |\n", ts[i].NomEntite, ts[i].CodeEntite, ts[i].TypeEntite);
        i++;
    }
}
