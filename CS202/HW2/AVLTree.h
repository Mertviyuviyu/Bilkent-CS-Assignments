/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : AVL Tree Header File
*/

#ifndef HW2_AVLTREE_H
#define HW2_AVLTREE_H


#include "Node.h"

class AVLTree {
private:
    Node* root;
    int size;

    int height(Node* node);
    int balanceFactor(Node* node);
    void updateHeight(Node* node);
    Node* rotateLeft(Node* A);
    Node* rotateRight(Node* B);
    Node* insert(Node* node, int key);
    Node* findMax(Node* node);
    Node* findMin(Node* node);
    Node* deleteNode(Node* node, int key);
    Node* findLargestSmallerThan(Node* node, int key, Node* lastSmaller);
public:
    AVLTree();
    ~AVLTree();
    void insertKey(int key);
    void removeKey(int key);
    int getMax();
    int getMin();
    int getLargestSmallerThan(int key);
    int getSize() const;
};


#endif //HW2_AVLTREE_H
