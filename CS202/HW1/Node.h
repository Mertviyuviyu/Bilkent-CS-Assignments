/**
* Title: Binary Search Trees
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 1
* Description : Node header for BST
*/

#ifndef UNTITLED_NODE_H
#define UNTITLED_NODE_H


class Node {
public:
    int key;
    Node* left;
    Node* right;
    Node(const int& key);

    ~Node();

};


#endif //UNTITLED_NODE_H
