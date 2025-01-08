/**
* Title: Binary Search Trees
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 1
* Description : Node implementation for BST
*/

#include "Node.h"

Node::Node(const int &key) {
    this->key = key;
    this->left = nullptr;
    this->right = nullptr;
}

Node::~Node() {
    delete left;
    delete right;
}
