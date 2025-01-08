/**
* Title: Hashing
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 3
* Description : Answer to Question4
*/
#include <iostream>
#include <fstream>

int main(int argc, char* argv[]){
    if(argc < 2){
        std::cout << "Incorrect usage. Usage: ./lexicographic <input_file> <optional_output_file>" << std::endl;
        return 1;
    }
    std::ifstream file(argv[1]);
    if(!file.is_open()){
        std::cout << "Input file cannot be opened." << std::endl;
        return 1;
    }
    if (argc > 2){
        freopen(argv[2], "w", stdout);
    }

    int n;
    file >> n;
    int* table = new int[n];
    int occupiedCount = 0;
    for(int i = 0; i < n; i++){
        file >> table[i];
        if(table[i] != -1){
            occupiedCount++;
        }
    }
    int* before = new int[n]();
    bool** isBefore = new bool*[n]();
    for(int i = 0; i < n; i++){
        isBefore[i] = new bool[n]();
    }
    for (int i = 0; i < n; i++){
        if (table[i] == -1){
            before[i] = -1;
            continue;
        }

        int orig_pos = table[i] % n;
        if (orig_pos == i){
            before[i] = 0;
            continue;
        }
        if (orig_pos < i){
            for (int j = orig_pos; j < i; j++){
                isBefore[i][j] = true;
            }
            before[i] = i - orig_pos;
        }
        else{
            for (int j = 0; j < i; j++){
                isBefore[i][j] = true;
            }
            for (int j = orig_pos; j < n; j++){
                isBefore[i][j] = true;
            }
            before[i] = n - (orig_pos - i);
        }
    }
    int* result = new int[occupiedCount];
    bool impossible = false;
    int resultSize = 0;
    while(resultSize < occupiedCount){
        int minIndex = -1;
        int minVal = 0;
        bool first = true;
        for(int i = 0; i < n; i++){
            if(table[i] != -1 && before[i] == 0){
                if(first){
                    minVal = table[i];
                    minIndex = i;
                    first = false;
                }
                else{
                    if(table[i] < minVal){
                        minVal = table[i];
                        minIndex = i;
                    }
                }

            }
        }
        if(minIndex == -1){
            impossible = true;
            break;
        }
        for(int j = 0; j < n; j++){
            if(isBefore[j][minIndex]){
                isBefore[j][minIndex] = false;
                before[j]--;
            }
        }
        result[resultSize] = minVal;
        table[minIndex] = -1;
        resultSize++;
    }

    if(impossible){
        std::cout << "Impossible" << std::endl;
    }
    else{
        for(int i = 0; i < resultSize; i++){
            if(i != resultSize-1){
                std::cout << result[i] << " ";
            }
            else{
                std::cout << result[i] << std::endl;
            }
        }
    }

    delete[] table;
    delete[] before;
    for(int i = 0; i < n; i++){
        delete[] isBefore[i];
    }
    delete[] isBefore;
    delete[] result;
}