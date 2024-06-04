//
// Created by Mert on 11.05.2024.
//
#include "Stack.h"
#include "Block.h"

Stack::Stack() {
    top = nullptr;
}
Stack::Stack(const Stack& other) {
    if(other.top != nullptr){
        top = new Node(other.top->data);
        Node* temp = top;
        for(Node* i = other.top->link; i != nullptr; i = i->link){
            temp->link = new Node(i->data);
            temp = temp->link;
        }
        temp->link = nullptr;
    }
    else {
        top = nullptr;
    }
}
Stack& Stack::operator=(const Stack& other) {
    if(this == &other){
        return *this;
    }
    while(!isEmpty()){
        this->pop();
    }
    if(other.top != nullptr){
        top = new Node(other.top->data);
        Node* temp = top;
        for(Node* i = other.top->link; i != nullptr; i = i->link){
            temp->link = new Node(i->data);
            temp = temp->link;
        }
        temp->link = nullptr;
    }
    else {
        top = nullptr;
    }
    return *this;
}
Stack::~Stack() {
    while(!isEmpty()){
        this->pop();
    }
}

bool Stack::isEmpty() {
    return top == nullptr;
}

bool Stack::push(Block *b) {
    Node* temp = new Node(b);
    temp->link = top;
    top = temp;
    return true;
}

bool Stack::pop() {
    if(isEmpty()){
        return false;
    }
    else{
        Node* temp = top;
        top = top->link;
        temp->link = nullptr;
        delete temp;
        return true;
    }
}

Block* Stack::peek() {
    if(!isEmpty()){
        return top->data;
    }
    return nullptr;
}
