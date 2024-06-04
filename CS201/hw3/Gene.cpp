//Mustafa Mert Gülhan CS201-1 22201895

#include "Gene.h"

Gene::Gene(const int id, const std::string name) {
    this->id = id;
    this->name = name;
    this->next = nullptr;
}
