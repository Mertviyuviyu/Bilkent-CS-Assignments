//Mustafa Mert Gülhan CS201-1 22201895

#include "Protein.h"

Protein::Protein(const int id) {
    this->id = id;
    this->geneHead = nullptr;
    this->next = nullptr;
}

Protein::~Protein() {
    Gene* curr = geneHead;
    while(curr != nullptr){
        Gene* next = curr->next;
        delete curr;
        curr = next;
    }
}
