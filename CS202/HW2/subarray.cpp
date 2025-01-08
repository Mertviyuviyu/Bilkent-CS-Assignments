/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Question 4 Main File
*/

#include <iostream>
#include <fstream>
#include <climits>
#include "AVLTree.h"

bool goodSubArray(int* aArr, int* bArr, int M, int K, int left, int right){
    AVLTree a;
    AVLTree b;
    int size = right - left + 1;
    if(size < K || size < M){
        return false;
    }
    for(int i = left; i <= right; i++){
        a.insertKey(aArr[i]);
        if(a.getSize() > M){
            a.removeKey(a.getMin());
        }
        b.insertKey(bArr[i]);
        if(b.getSize() > K){
            b.removeKey(b.getMax());
        }
    }
    //total N logN
    return a.getMin() > b.getMax();
}
int findShortestGood(int* aArr, int* bArr, int N, int M, int K){
    int minLength = INT_MAX;
    int larger = (M > K) ? M : K;
    for(int left = 0; left <= N-larger; left++){ //N
        int low = left+larger-1;
        int high = N-1;
        while(low <= high){ //logN
            int mid = low + (high-low)/2;
            if(goodSubArray(aArr,bArr,M,K,left,mid)){ //NlogN
                if(mid-left+1 < minLength){
                    minLength = mid-left+1;
                }
                high = mid-1;
            }
            else{
                low = mid+1;
            }
        }
    }
    if(minLength == INT_MAX){
        return -1;
    }
    else{
        return minLength;
    }
    //total 2*N^2*logN which is O(N^2*logN)
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
    int N,M,K;
    file >> N;
    file >> M;
    file >> K;
    int* aArr = new int[N];
    int* bArr = new int[N];
    for(int i = 0; i < N; i++){
        file >> aArr[i];
    }
    for(int i = 0; i < N; i++){
        file >> bArr[i];
    }
    int ans = findShortestGood(aArr,bArr,N,M,K);
    if(outputFile.is_open()){
        outputFile << ans << std::endl;
    }
    else{
        std::cout << ans << std::endl;
    }
    file.close();
    outputFile.close();
    delete[] aArr;
    delete[] bArr;
    return 0;
}


