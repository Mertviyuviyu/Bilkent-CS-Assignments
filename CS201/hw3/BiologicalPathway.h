//Mustafa Mert Gülhan CS201-1 22201895

#ifndef UNTITLED_BIOLOGICALPATHWAY_H
#define UNTITLED_BIOLOGICALPATHWAY_H

#include <string>
#include "Pathway.h"

using namespace std;



class BiologicalPathway {
public:
    BiologicalPathway();
    ~BiologicalPathway();

    Pathway* pathwayHead;

    template<typename T>
    bool exists(T* head, const int id) const;
    template<typename T>
    void addAscending(T*& head, T*& node);
    template<typename T>
    void remove(T*& head, const int id);
    template<typename T>
    int length(T* head) const;
    template<typename T>
    T* find(T* head, const int id) const;

    void printGenesInList(Gene* head) const;


    void addPathway( const int pathwayId, const string pathwayName );
    void removePathway( const int pathwayId );
    void printPathways() const;

    void addProtein( const int proteinId, const int pathwayId );
    void removeProtein( const int proteinId, const int pathwayId );
    void printProteinsInPathway( const int pathwayId ) const;

    void addGene( const int geneID, const string geneName, const int proteinId );
    void removeGene( const int geneID, const int proteinId );
    void printGenesOfProtein( const int proteinId ) const;

};


#endif //UNTITLED_BIOLOGICALPATHWAY_H
