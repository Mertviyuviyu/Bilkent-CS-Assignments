/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Node header for AVLTree implementation
*/

#ifndef HW2_NODE_H
#define HW2_NODE_H

class Node {
public:
    int key;
    Node* left;
    Node* right;
    int height;
    Node(int k);
    ~Node();
};


#endif //HW2_NODE_H
