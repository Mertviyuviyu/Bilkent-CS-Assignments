//Mustafa Mert Gülhan CS201-1 22201895

#include "BiologicalPathway.h"
#include <iostream>

BiologicalPathway::BiologicalPathway() {
    this->pathwayHead = nullptr;
}

BiologicalPathway::~BiologicalPathway() {
    Pathway* curr = pathwayHead;
    while (curr != nullptr){
        Pathway* next = curr->next;
        delete curr;
        curr = next;
    }
}

template<typename T>
bool BiologicalPathway::exists(T* head, const int id) const {
    while (head != nullptr){
        if(head->id == id){
            return true;
        }
        head = head->next;
    }
    return false;
}

template<typename T>
void BiologicalPathway::addAscending(T*& head, T*& node) {
    if(head == nullptr || head->id >= node->id){
        node->next = head;
        head = node;
        return;
    }

    T* curr = head;
    while(curr->next != nullptr && curr->next->id < node->id ){
        curr = curr->next;
    }
    node->next = curr->next;
    curr->next = node;
}

template<typename T>
void BiologicalPathway::remove(T*& head, const int id) {
    T* before = head;
    T* curr = head->next;
    if(head->id == id){
        head = head->next;
        delete before;
        return;
    }
    while(curr->id != id && curr != nullptr){
        before = curr;
        curr = curr->next;
    }
    before->next = curr->next;
    delete curr;
}

template<typename T>
int BiologicalPathway::length(T* head) const {
    int count = 0;
    while(head != nullptr){
        count++;
        head = head->next;
    }
    return count;
}

template<typename T>
T *BiologicalPathway::find(T* head, const int id) const {
    while (head != nullptr){
        if(head->id == id){
            return head;
        }
        head = head->next;
    }
    return nullptr;
}

void BiologicalPathway::printGenesInList(Gene *head) const{
    if(head == nullptr){
        std::cout << "None" << std::endl;
        return;
    }
    std::cout << "[";
    while(head->next != nullptr){
        std::cout << head->id << ", ";
        head = head->next;
    }
    std::cout << head->id << "]" << std::endl; //last element
}

void BiologicalPathway::addPathway(const int pathwayId, const string pathwayName) {
    if(exists(pathwayHead,pathwayId)){
        std::cout << "Cannot add pathway. There is already a pathway with ID " << pathwayId << "." << std::endl;
        return;
    }
    else{
        Pathway* p = new Pathway(pathwayId,pathwayName);
        addAscending(pathwayHead,p);
        std::cout << "Added pathway " << pathwayId << "." << std::endl;
    }
}

void BiologicalPathway::removePathway(const int pathwayId) {
    if(!exists(pathwayHead,pathwayId)){
        std::cout << "Cannot remove pathway. There is no pathway with ID " << pathwayId << "." << std::endl;
        return;
    }
    else{
        remove(pathwayHead,pathwayId);
        std::cout << "Removed pathway " << pathwayId << "." << std::endl;
    }
}

void BiologicalPathway::printPathways() const {
    if(pathwayHead == nullptr){
        std::cout << "There are no pathways to show." << std::endl;
        return;
    }
    Pathway* p = pathwayHead;
    std::cout << "Pathways in the system:" << std::endl;
    while(p != nullptr){
        std::cout << "Pathway " << p->id << " : " << p->name << " (" << length(p->proteinHead) << " Proteins) (";
        int geneCount = 0;
        Protein* pr = p->proteinHead;
        while(pr != nullptr){
            geneCount += length(pr->geneHead);
            pr = pr->next;
        }
        std::cout << geneCount << " Genes)" << std::endl;
        p = p->next;
    }
}

void BiologicalPathway::addProtein(const int proteinId, const int pathwayId) {
    if(!exists(pathwayHead,pathwayId)){
        std::cout << "Cannot add protein. There is no pathway with ID " << pathwayId << "." << std::endl;
        return;
    }
    Pathway* p = pathwayHead;
    bool proteinFound = false;
    while(p != nullptr){
        if(exists(p->proteinHead,proteinId)){
            proteinFound = true;
        }
        p = p->next;
    }
    if(proteinFound){
        std::cout << "Cannot add protein. There is a pathway having a protein with ID " << proteinId << "." << std::endl;
        return;
    }
    Pathway* chosenPath = find(pathwayHead,pathwayId);
    Protein* protein = new Protein(proteinId);
    addAscending(chosenPath->proteinHead, protein);
    std::cout << "Added protein " << proteinId << " to pathway " << pathwayId << "." << std::endl;
}

void BiologicalPathway::removeProtein(const int proteinId, const int pathwayId) {
    if(!exists(pathwayHead,pathwayId)){
        std::cout << "Cannot remove protein. There is no pathway with ID " << pathwayId << "." << std::endl;
        return;
    }
    Pathway* p = find(pathwayHead,pathwayId);
    if(!exists(p->proteinHead,proteinId)){
        std::cout << "Cannot remove protein. Pathway "<< pathwayId << " does not have a protein with ID " << proteinId << "." << std::endl;
        return;
    }
    remove(p->proteinHead,proteinId);
    std::cout << "Removed protein " << proteinId << " from pathway " << pathwayId << "." << std::endl;
}

void BiologicalPathway::printProteinsInPathway(const int pathwayId) const {
    if(!exists(pathwayHead,pathwayId)){
        std::cout << "Cannot print proteins. There is no pathway with ID " << pathwayId << "." << std::endl;
        return;
    }
    Pathway* p = find(pathwayHead, pathwayId);
    if(p->proteinHead == nullptr){
        std::cout << "There are no proteins to show in pathway " << pathwayId << "." << std::endl;
        return;
    }
    std::cout << "Proteins in pathway " << pathwayId << ":" << std::endl;
    Protein* protein = p->proteinHead;
    while(protein != nullptr){
        std::cout << "Protein ID : " << protein->id << ", Gene IDs : ";
        printGenesInList(protein->geneHead);
        protein = protein->next;
    }
}

void BiologicalPathway::addGene(const int geneID, const string geneName, const int proteinId) {
    Pathway* p = pathwayHead;
    Protein* chosenProtein = nullptr;
    bool geneExists = false;
    Protein* proteinIterator = nullptr;
    while(p != nullptr){
        proteinIterator = p->proteinHead;
        while(proteinIterator != nullptr){
            if(exists(proteinIterator->geneHead,geneID)){
                geneExists = true;
            }
            proteinIterator = proteinIterator->next;
        }
        if(exists(p->proteinHead,proteinId)){
            chosenProtein = find(p->proteinHead,proteinId);
        }
        p = p->next;
    }
    if(geneExists){
        std::cout << "Cannot add gene. Gene " << geneID << " is already in use." << std::endl;
        return;
    }
    if(chosenProtein == nullptr){
        std::cout << "Cannot add gene. There is no protein with ID " << proteinId << "." << std::endl;
        return;
    }
    Gene* gene = new Gene(geneID,geneName);
    addAscending(chosenProtein->geneHead,gene);
    std::cout << "Added gene " << geneID << " to protein " << proteinId << "." << std::endl;
}

void BiologicalPathway::removeGene(const int geneID, const int proteinId) {
    Pathway* p = pathwayHead;
    Protein* chosenProtein = nullptr;
    while(p != nullptr){
        if(exists(p->proteinHead,proteinId)){
            chosenProtein = find(p->proteinHead,proteinId);
        }
        p = p->next;
    }
    if(chosenProtein == nullptr){
        std::cout << "Cannot remove gene. There is no protein with ID " << proteinId << "." << std::endl;
        return;
    }
    Gene* chosenGene = find(chosenProtein->geneHead,geneID);
    if(chosenGene == nullptr){
        std::cout << "Cannot remove gene. There is no gene " << geneID << " encoding protein " << proteinId << "." << std::endl;
        return;
    }
    remove(chosenProtein->geneHead,geneID);
    std::cout << "Removed gene " << geneID << " from protein " << proteinId << "." << std::endl;
}

void BiologicalPathway::printGenesOfProtein(const int proteinId) const {
    Pathway* p = pathwayHead;
    Protein* chosenProtein = nullptr;
    while(p != nullptr){
        if(exists(p->proteinHead,proteinId)){
            chosenProtein = find(p->proteinHead,proteinId);
        }
        p = p->next;
    }
    if(chosenProtein == nullptr){
        std::cout << "Cannot print genes. There is no protein with ID " << proteinId << "." << std::endl;
        return;
    }
    if(chosenProtein->geneHead == nullptr){
        std::cout << "There are no genes to show in protein " << proteinId << "." << std::endl;
        return;
    }
    Gene* geneIterator = chosenProtein->geneHead;
    std::cout << "Genes in protein " << proteinId << ":" << std::endl;
    while(geneIterator != nullptr){
        std::cout << "GENE " << geneIterator->id << " : " << geneIterator->name << std::endl;
        geneIterator = geneIterator->next;
    }
}
