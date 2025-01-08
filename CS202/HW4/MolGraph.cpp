
/**
* Title: Graphs
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 4
* Description : Implementation of MolGraph and Queue
*/

#include <fstream>
#include <iostream>
#include "MolGraph.h"

Queue::Queue() {
    front = nullptr;
    tail = nullptr;
}

Queue::~Queue() {
    while(!isEmpty()){
        pop_front();
    }
}

void Queue::push_back(int val) {
    Node* newNode = new Node(val);
    if(tail){
        tail->next = newNode;
    }
    else{
        front = newNode;
    }
    tail = newNode;
}

int Queue::pop_front() {
    if(isEmpty()){
        return -1;
    }
    Node* temp = front;
    int data = front->data;
    front = front->next;
    if(!front){
        tail = nullptr;
    }
    delete temp;
    return data;
}

bool Queue::isEmpty() {
    return front == nullptr;
}

MolGraph::MolGraph(const std::string &filename) {
    std::ifstream file(filename);
    nodeCount = 0;
    if(!file.is_open()){
        std::cout << "Input file cannot be opened" << std::endl;
        exit(1);
    }
    file >> nodeCount;
    adjMatrix = new bool*[nodeCount]();
    for(int i = 0; i < nodeCount; i++){
        adjMatrix[i] = new bool[nodeCount]();
    }
    degrees = new int[nodeCount];
    int id, degree;
    int neighbour;
    for(int i = 0; i < nodeCount; i++){
        file >> id;
        file >> degree;
        degrees[i] = degree;
        for(int j = 0; j < degree; j++){
            file >> neighbour;
            adjMatrix[id][neighbour] = true;
            adjMatrix[neighbour][id] = true; //bidirectional
        }
    }

}

MolGraph::~MolGraph() {
    for(int i = 0; i < nodeCount; i++){
        delete[] adjMatrix[i];
    }
    delete[] adjMatrix;
    delete[] degrees;
}

void MolGraph::minBondPath(int source, int destination) {
    bool* visited = new bool[nodeCount];
    int* parent = new int[nodeCount];
    for(int i = 0; i < nodeCount; i++){
        visited[i] = false,
        parent[i] = -1;
    }
    Queue q;
    visited[source] = true;
    q.push_back(source);
    while(!q.isEmpty()){
        int curr = q.pop_front();
        for(int v = 0; v < nodeCount; v++){
            if(adjMatrix[curr][v] && !visited[v]){
                visited[v] = true;
                parent[v] = curr;
                q.push_back(v);

                if(v == destination){
                    break;
                }
            }
        }
    }
    if(!visited[destination]){
        std::cout << "No path is found between " << source << ", " << destination << std::endl;
    }
    else{
        int* path = new int[nodeCount];
        int pathLen = 0;
        int curr = destination;
        while (curr != -1){
            path[pathLen] = curr;
            pathLen++;
            curr = parent[curr];
        }
        std::cout << "Minimum number of bonds to traverse from atom " << source << " to atom " << destination << ": " << pathLen-1 << std::endl;
        std::cout << "Path: ";
        for(int i = pathLen-1; i >= 0; i--){
            std::cout << path[i];
            if(i != 0){
                std::cout << " -> ";
            }

        }
        std::cout << std::endl;
        delete[] path;
    }

    delete[] visited;
    delete[] parent;
}

void MolGraph::getDiameter() {
    int diameter = 0;
    //Calculating the shortest path for each node and updating diameter if a larger one is found
    for(int i = 0; i < nodeCount; i++){
        bool* visited = new bool[nodeCount];
        int* distance = new int[nodeCount];
        for(int j = 0; j < nodeCount; j++){
            visited[j] = false;
            distance[j] = 0;
        }
        Queue q;
        visited[i] = true;
        q.push_back(i);
        while(!q.isEmpty()){
            int curr = q.pop_front();
            for(int v = 0; v < nodeCount; v++){
                if(adjMatrix[curr][v] && !visited[v]){
                    visited[v] = true;
                    distance[v] = distance[curr] + 1;
                    q.push_back(v);
                }
            }
        }
        int maxDistance = 0;
        for(int j = 0; j < nodeCount; j++){
            if(distance[j] > maxDistance){
                maxDistance = distance[j];
            }
        }
        if(maxDistance > diameter){
            diameter = maxDistance;
        }
        delete[] visited;
        delete[] distance;
    }
    std::cout << "Diameter of the molecule: " << diameter << std::endl;
}

void MolGraph::getMST() {
    if(nodeCount <= 0){
        std::cout << "Minimum Spanning Tree:" << std::endl;
        std::cout << "Cost: 0" << std::endl;
        std::cout << "Edges:" << std::endl;
        std::cout << "None." << std::endl;
        return;
    }
    bool* visited = new bool[nodeCount];
    int* edgeStart = new int[nodeCount];
    int* edgeEnd = new int[nodeCount];
    for(int i = 0; i < nodeCount; i++){
        visited[i] = false;
        edgeEnd[i] = -1;
        edgeStart[i] = -1;
    }

    Queue q;
    q.push_back(0);
    visited[0] = true;

    //Because graph is unweighted we can adapt BFS for Prim's algorithm.
    int count = 0;
    while(!q.isEmpty()){
        int curr = q.pop_front();
        for(int i = 0; i < nodeCount; i++){
            if(adjMatrix[curr][i] && !visited[i]){
                q.push_back(i);
                visited[i] = true;

                edgeStart[count] = curr;
                edgeEnd[count] = i;
                count++;
            }
        }
    }

    std::cout << "Minimum Spanning Tree:" << std::endl;
    std::cout << "Cost: " << count << std::endl;
    std::cout << "Edges:" << std::endl;
    for(int i = 0; i < count; i++){
        std::cout << edgeStart[i] << " - " << edgeEnd[i] << std::endl;
    }
    delete[] visited;
    delete[] edgeStart;
    delete[] edgeEnd;
}
