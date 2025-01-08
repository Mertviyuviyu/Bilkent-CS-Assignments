/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Node implementation for AVLTree
*/

#include "Node.h"

Node::Node(int k) {
    this->key = k;
    left = nullptr;
    right = nullptr;
    height = 1;
}

Node::~Node() {
    delete left;
    delete right;
}
