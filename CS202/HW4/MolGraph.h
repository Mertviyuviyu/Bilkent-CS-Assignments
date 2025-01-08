/**
* Title: Graphs
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 4
* Description : Header of MolGraph and Queue
*/

#ifndef HW4_MOLGRAPH_H
#define HW4_MOLGRAPH_H

#include <string>

class Queue {
private:
    struct Node{
        int data;
        Node* next;
        Node(int val){
            this->data = val;
            this->next = nullptr;
        }
    };
    Node* front;
    Node* tail;

public:
    Queue();
    ~Queue();
    void push_back(int val);
    int pop_front();
    bool isEmpty();
};

class MolGraph {
public:
    MolGraph(const std::string& filename);
    ~MolGraph();
    void minBondPath(int source, int destination);
    void getDiameter();
    void getMST();

    int nodeCount;
    bool** adjMatrix;
    int* degrees;
};


#endif //HW4_MOLGRAPH_H
