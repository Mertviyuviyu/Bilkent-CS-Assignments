/**
* Title: Binary Search Trees
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 1
* Description : analysis implementation for question 3
*/

#include "analysis.h"

void analysis::timeAnalysis() {
    int size = 10000;
    int* arr = new int[size];
    srand(time(0));
    for(int i = 0; i < size; i++){
        arr[i] = rand();
    }
    BST tree(nullptr,0);
    int insertionLength = 1000;
    for(int i = 0; i < size/insertionLength; i++){
        int lowerBound = i * insertionLength;
        int upperBound = (i+1) * insertionLength;
        std::cout << "Insertion of " << lowerBound << " to " << upperBound << std::endl;
        std::cout << "-------------------------------------------------------" << std::endl;
        clock_t before = clock();
        for(int j = lowerBound; j < upperBound; j++){
            tree.insertKeyNoPrint(arr[j]);
        }
        clock_t after = clock() - before;
        std::cout << "a) Time taken for insertions: " << (float)after / CLOCKS_PER_SEC * 1000 << " milliseconds" << std::endl;
        std::cout << "b) Height of the tree is: " << tree.treeHeight() << std::endl;
        std::cout << "-------------------------------------------------------" << std::endl;
    }


    delete[] arr;
}
