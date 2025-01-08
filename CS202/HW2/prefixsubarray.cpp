/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Question 3 Main File
*/

#include <iostream>
#include <fstream>
#include "AVLTree.h"

bool canSatisfy(int N, int M, int* aArr, int* bArr){
    AVLTree a;
    AVLTree b;

    for(int i = 0; i < N; i++){ // N*logM
        a.insertKey(aArr[i]);
        if(a.getSize() > M){
            a.removeKey(a.getMin());
        }
        b.insertKey(bArr[i]);
        if(b.getSize() > M){
            b.removeKey(b.getMax());
        }
    }
    while(a.getSize() != 0 && b.getSize() != 0){
        if(a.getMin() <= b.getMin()){
            return false;
        }
        a.removeKey(a.getMin());
        b.removeKey(b.getMin());
    }
    //total N*logM
    return true;
}

int main(int argc, char* argv[]){
    if (argc < 2) {
        std::cout << "No input file is given." << std::endl;
        return 1;
    }
    std::string in = argv[1];
    std::ifstream file(in);
    std::ofstream outputFile;
    if (!file.is_open()) {
        std::cout << "File cannot be opened." << std::endl;
        return 1;
    }
    if (argc >= 3) {
        outputFile.open(argv[2]);
    }

    int N;
    file >> N;
    int M;
    file >> M;


    int* aArr = new int[N];
    int* bArr = new int[N];
    for(int i = 0; i < N; i++){
        file >> aArr[i];
    }
    for(int i = 0; i < N; i++){
        file >> bArr[i];
    }
    int L = 0;

    int left = M;
    int right = N;

    while(left <= right){ //Binary search logN
        int mid = left+((right-left)/2);
        if(canSatisfy(mid,M,aArr,bArr)){ // canSatisfy = N*logM
            L = mid;
            right = mid-1;
        }
        else{
            left = mid+1;
        }
    }

    if(outputFile.is_open()){
        outputFile << L << std::endl;
    }
    else{
        std::cout << L << std::endl;
    }

    file.close();
    outputFile.close();
    delete[] aArr;
    delete[] bArr;
    return 0;
}