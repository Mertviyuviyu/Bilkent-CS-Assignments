/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Heap header file
*/

#ifndef HW2_HEAP_H
#define HW2_HEAP_H

#include <iostream>

class Heap {
public:
    static const int MAX_HEAP_SIZE = 1000000;

    Heap();
    bool isEmpty();
    void insertItem(int item);
    void deleteTop();
    void heapify(int arr[], int s, int index);
    int* showSmallestFive();
    int getSize() const;
    int getTop();

private:
    int items[MAX_HEAP_SIZE];
    int size;
    void swap(int& a, int& b);
};


#endif //HW2_HEAP_H
