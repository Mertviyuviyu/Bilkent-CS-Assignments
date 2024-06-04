//Mustafa Mert Gülhan CS201-1 22201895

#ifndef UNTITLED_PATHWAY_H
#define UNTITLED_PATHWAY_H

#include <string>
#include "Protein.h"

class Pathway {
public:
    Pathway(const int id, const std::string name);
    ~Pathway();
    int id;
    std::string name;
    Protein* proteinHead;
    Pathway* next;
};


#endif //UNTITLED_PATHWAY_H
