//
// Created by Mert on 8.05.2024.
//

#ifndef HW4_STACK_H
#define HW4_STACK_H

#include "Block.h"
class Node{
public:
    Block* data;
    Node* link;
    Node(Block* b){
        data = b;
        link = nullptr;
    }
};
class Stack {
private:
    Node* top;
public:
    Stack& operator=(const Stack& other);
    Stack();
    Stack(const Stack& other);
    ~Stack();
    bool isEmpty();
    bool push(Block* b);
    bool pop();
    Block* peek();

};


#endif //HW4_STACK_H
