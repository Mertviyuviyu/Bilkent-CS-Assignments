//Mustafa Mert Gülhan CS201-1 22201895

#ifndef UNTITLED_PROTEIN_H
#define UNTITLED_PROTEIN_H
#include <string>
#include "Gene.h"

class Protein {
public:
    Protein(const int id);
    ~Protein();
    int id;
    Protein* next;
    Gene* geneHead;

};


#endif //UNTITLED_PROTEIN_H
