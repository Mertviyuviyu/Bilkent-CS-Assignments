//Mustafa Mert Gülhan CS201-1 22201895

#include "Pathway.h"

Pathway::Pathway(const int id, const std::string name) {
    this->id = id;
    this->name = name;
    this->next = nullptr;
    this->proteinHead = nullptr;
}

Pathway::~Pathway() {
    Protein* curr = proteinHead;
    while (curr != nullptr){
        Protein* next = curr->next;
        delete curr;
        curr = next;
    }
}
