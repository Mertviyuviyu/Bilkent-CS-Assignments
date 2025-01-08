/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Heap implementation
*/

#include "Heap.h"
#include <climits>

Heap::Heap() {
    size = 0;
}

void Heap::swap(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}

bool Heap::isEmpty() {
    return size == 0;
}

void Heap::insertItem(int item) {
    if(size >= MAX_HEAP_SIZE){
        std::cout << "Heap is full. Item not added." << std::endl;
        return;
    }
    items[size] = item;

    int place = size;
    int parent = (place-1)/2;
    while(place > 0 && items[place] < items[parent]){
        swap(items[parent],items[place]);
        place = parent;
        parent = (place-1)/2;
    }
    size++;
}

void Heap::deleteTop() {
    if(isEmpty()){
        std::cout << "Heap is empty. Cannot delete root." << std::endl;
        return;
    }
    if(size == 1){
        size--;
        return;
    }
    items[0] = items[size-1];
    size--;
    heapify(items,size,0);
}

void Heap::heapify(int arr[], int s, int index) {
    int smallest = index;
    int rightIndex = 2*index+2;
    int leftIndex = 2*index+1;

    if(leftIndex < s && arr[leftIndex] < arr[smallest]){
        smallest = leftIndex;
    }
    if(rightIndex < s && arr[rightIndex] < arr[smallest]){
        smallest = rightIndex;
    }
    if(smallest != index){
        swap(arr[index], arr[smallest]);
        heapify(arr, s, smallest);
    }
}

int* Heap::showSmallestFive() {
    if(size < 5){
        return nullptr;
    }
    int* result = new int[5];
    int* temp = new int[1000];
    int* tempIndex = new int[1000];
    result[0] = items[0];
    int resultSize = 1;
    int tempSize = 0;

    int parentIndex = 0;
    while(resultSize < 5){ //K iterations
        int left = parentIndex*2+1;
        int right = parentIndex*2+2;
        if(left < size){
            temp[tempSize] = items[left];
            tempIndex[tempSize] = left;
            tempSize++;
        }
        if(right < size){
            temp[tempSize] = items[right];
            tempIndex[tempSize] = right;
            tempSize++;
        }
        int smallest = INT_MAX;
        int smallestIndex = 0;
        for(int i = 0; i < tempSize; i++){ //Worst 2k iterations, we add 2 children of k elements
            if(temp[i] < smallest){
                smallest = temp[i];
                smallestIndex = i;
            }
        }
        result[resultSize] = smallest;
        resultSize++;
        parentIndex = tempIndex[smallestIndex];
        swap(temp[smallestIndex],temp[tempSize-1]);
        swap(tempIndex[smallestIndex],tempIndex[tempSize-1]);
        tempSize--;
    }
    delete[] temp;
    delete[] tempIndex;
    //O(2k^2) which is O(k^2)
    return result;
}

int Heap::getSize() const {
    return size;
}

int Heap::getTop() {
    if(getSize() == 0){
        return -1;
    }
    else{
        return items[0];
    }
}
