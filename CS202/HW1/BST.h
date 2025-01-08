/**
* Title: Binary Search Trees
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 1
* Description : BST header for question 3
*/

#ifndef UNTITLED_BST_H
#define UNTITLED_BST_H

#include <iostream>
#include "Node.h"

class BST {
public:
    BST(int keys[], int size);
    ~BST();
    void insertKey(int key);
    void deleteKey(int key);
    void displayInorder();
    void findFullBTLevel();
    void lowestCommonAncestor(int A, int B);
    void maximumSumPath();
    void maximumWidth();
    void pathFromAtoB(int A, int B);

    int treeHeight();
    void insertKeyNoPrint(int key);

private:
    void maxSumHelper(Node* node, Node*& maxNode, int currSum,int& maxSum);
    void printPathHelper(Node* start, Node* end, bool& first);
    void maxWidthHelper(Node* node, int level, bool& first);
    bool pathHelper(Node* node, int key, bool& first);
    int countNodesOnLevel(Node* node, int level);
    Node* lcaHelper(Node* node, int A, int B);
    bool levelIsFull(Node* node, int level);
    int getHeight(Node* node);
    void processLeftmost(Node*& nodePtr, int& key);
    void inOrderHelper(Node* node, bool& first);
    void deleteNode(Node*& node);
    void insertKeyBase(int key);
    bool nodeExists(int val);
    Node* root;
};


#endif //UNTITLED_BST_H
