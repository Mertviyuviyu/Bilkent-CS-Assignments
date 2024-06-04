//Mustafa Mert Gülhan CS201-1 22201895

#ifndef UNTITLED_GENE_H
#define UNTITLED_GENE_H
#include <string>

class Gene {
public:
    Gene(const int id, const std::string name);
    int id;
    std::string name;
    Gene* next;
};


#endif //UNTITLED_GENE_H
