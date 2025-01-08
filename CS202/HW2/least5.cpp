/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Question 1 Main File
*/

#include <iostream>
#include <fstream>
#include <string>
#include "Heap.h"

int main(int argc, char *argv[]){
    if(argc < 2){
        std::cout << "No input file is given." << std::endl;
        return 1;
    }
    std::string in = argv[1];
    std::ifstream file(in);
    std::ofstream outputFile;
    if(!file.is_open()){
        std::cout << "File cannot be opened." << std::endl;
        return 1;
    }
    if (argc >= 3) {
        outputFile.open(argv[2]);
    }
    int actionSize;
    file >> actionSize;
    std::string operation;
    Heap h;
    for(int i = 0; i < actionSize && file >> operation; i++){
        if(operation == "a"){
            int val;
            if (file >> val){
                h.insertItem(val);
            }
        }
        else if(operation == "r"){
            h.deleteTop();
        }
        else if(operation == "g"){
            if(h.getSize() < 5){
                if(outputFile.is_open()){
                    outputFile << -1 << std::endl;
                }
                else{
                    std::cout << -1 << std::endl;
                }
            }
            else{
                int *arr = h.showSmallestFive();
                for(int j = 0; j < 5 && arr; j++){
                    if(outputFile.is_open()){
                        outputFile << arr[j] << std::endl;
                    }
                    else{
                        std::cout << arr[j] << std::endl;
                    }
                }
                delete[] arr;
            }
        }
        else{
            if(outputFile.is_open()){
                outputFile << "Unknown operation." << std::endl;
            }
            else{
                std::cout << "Unknown operation." << std::endl;
            }
        }
    }
    file.close();
    outputFile.close();
    return 0;
}
