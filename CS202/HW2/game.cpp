/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : Question 2 Main File
*/

#include <iostream>
#include <fstream>
#include "AVLTree.h"

int main(int argc, char *argv[]) {
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
    int cardSize;
    file >> cardSize;

    AVLTree bobo;
    AVLTree holosko;
    for(int i = 0; i < cardSize; i++){
        int currNum;
        file >> currNum;
        bobo.insertKey(currNum);
    }
    for(int i = 0; i < cardSize; i++){
        int currNum;
        file >> currNum;
        holosko.insertKey(currNum);
    }

    int boboScore = 0;
    int holoskoScore = 0;

    for(int i = 0; i < cardSize; i++){
        //odd bobo's turn
        if(i % 2 == 0){
            int boboCard = bobo.getMax();
            int holoskoHighest = holosko.getMax();
            int holoskoCard;
            if(holoskoHighest < boboCard){
                holoskoCard = holoskoHighest;
            }
            else{
                holoskoCard = holosko.getLargestSmallerThan(boboCard);
                if(holoskoCard == -1){
                    //we couldn't find any card to beat so just eliminate opponent's highest card
                    holoskoCard = holosko.getMax();
                }
            }
            if(boboCard > holoskoCard){
                boboScore++;
            }
            else{
                holoskoScore++;
            }
            bobo.removeKey(boboCard);
            holosko.removeKey(holoskoCard);
        }
        else{
            int holoskoCard = holosko.getMax();
            int boboHighest = bobo.getMax();
            int boboCard;
            if(boboHighest < holoskoCard){
                boboCard = boboHighest;
            }
            else{
                boboCard = bobo.getLargestSmallerThan(holoskoCard);
                if(boboCard == -1){
                    boboCard = bobo.getMax();
                }
            }
            if(boboCard > holoskoCard){
                boboScore++;
            }
            else{
                holoskoScore++;
            }
            bobo.removeKey(boboCard);
            holosko.removeKey(holoskoCard);
        }
    }

    if(!outputFile.is_open()){
        std::cout << boboScore << " " << holoskoScore << std::endl;
    }
    else{
        outputFile << boboScore << " " << holoskoScore << std::endl;
    }
    file.close();
    outputFile.close();
    return 0;
}