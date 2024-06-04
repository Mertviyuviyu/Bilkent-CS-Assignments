//
// Created by Mert on 8.05.2024.
//

#include <iostream>
#include "BuildingMap.h"
#include "Stack.h"

BuildingMap::BuildingMap(const string buildingMapFile) {
    std::ifstream file(buildingMapFile);

    if(!file.is_open()){
        std::cout << "File could not be opened." << std::endl;
        exit(1);
    }

    file >> row;
    file >> col;
    blockArr = new Block*[row*col];

    //col*(block's row) + (block's col) = loc in arr
    for(int i = 0; i < row; i++){
        for(int j = 0; j < col; j++){
            blockArr[col*i+j] = new Block(i,j);
        }
    }

    for(int i = 0; i < row; i++){
        std::string line;
        file >> line;
        for(int k = col-1; k >= 0; k--){
            blockArr[col*i+k]->type = line[k] - '0'; //Converting char to int
        }
    }


    for(int i = 0; i < row; i++){
        for(int j = 0; j < col; j++){
            findAdj(blockArr[col*i+j]);
        }
    }
    std::cout << row << " rows and " << col << " columns have been read." << std::endl;
}

BuildingMap::~BuildingMap() {
    for(int i = 0; i < col*row; i++){
        delete blockArr[i];
    }
    delete[] blockArr;
}

void BuildingMap::findAdj(Block* block) {
    Block* u = nullptr;
    Block* r = nullptr;

    //Always adding in order up,left,right,down to ensure lexicographical order

    if(block->row != 0){
        u = blockArr[col*(block->row-1)+block->col];
    }
    if(block->col != col-1){
        r = blockArr[col*(block->row)+(block->col+1)];
    }

    if(u != nullptr){
        if(u->type != 2 && u->type != 3){
            block->addAdj(u);
        }
    }
    if(block->type == 3){
        if(r != nullptr){
            if(r->type != 1 && r->type!=3){
                block->addAdj(r);
            }
        }
    }
    if(block->type == 2){
        if(block->col != 0){
            block->addAdj(blockArr[col*block->row+((block->col)-1)]);
        }
        if(r != nullptr){
            if(r->type != 1 && r->type!=3){
                block->addAdj(r);
            }
        }
    }
    if(block->type == 1){
        if(r != nullptr){
            if(r->type != 1 && r->type!=3){
                block->addAdj(r);
            }
        }
        if(block->row != row-1){
            block->addAdj(blockArr[col*(block->row+1)+(block->col)]);
        }
    }
    if(block->type == 0){
        if(block->col != 0){
            block->addAdj(blockArr[col*block->row+(block->col-1)]) ;
        }
        if(r != nullptr){
            if(r->type != 1 && r->type!=3){
                block->addAdj(r);
            }
        }
        if(block->row != row-1){
            block->addAdj(blockArr[col*(block->row+1)+(block->col)]);
        }
    }
}

void BuildingMap::displayAllCubicles() const {
    std::cout << "The cubicles in the building are:" << std::endl;
    for(int i = 0; i < row; i++){
        for(int j = 0; j < col; j++){
            if(j == col-1){
                std::cout << "(" << i << "," << j << ")" << std::endl;
            }
            else{
                std::cout << "(" << i << "," << j << "),";
            }
        }
    }
}

void BuildingMap::displayAdjacentCubicles(const int row, const int col) const {
    Block* b = blockArr[(this->col*row)+col];
    std::cout << "The cubicles adjacent to " << b->toString() << " are:" << std::endl;
    std::cout << b->toString() << " -> ";
    for(int i=0; i < b->adjCount; i++){
        if(i == b->adjCount-1){
            std::cout << b->adj[i]->toString();
        }
        else{
            std::cout << b->adj[i]->toString() << ",";
        }
    }
    std::cout << std::endl;
}

void BuildingMap::displayBuildingMap() const {
    std::cout << "The building map is as follows:" << std::endl;
    for(int i = 0; i < row; i++){
        for(int j = 0; j < col; j++){
            Block* b = blockArr[(this->col*i)+j];
            std::cout << b->toString() << " -> ";
            for(int k=0; k < b->adjCount; k++){
                if(k == b->adjCount-1){
                    std::cout << b->adj[k]->toString();
                }
                else{
                    std::cout << b->adj[k]->toString() << ",";
                }
            }
            std::cout << std::endl;
        }
    }
}

void BuildingMap::findPaths(const int startRow, const int startCol, const int endRow, const int endCol) {
    std::cout << "Paths from (" << startRow << "," << startCol << ") to (" << endRow << "," << endCol << ") are:" << std::endl;

    int pathCount = 0;
    int pathCapacity = 8; //initial capacity
    Stack* paths = new Stack[pathCapacity]; 

    bool** visitedArr = new bool*[row*col];
    for(int i = 0; i < row*col; i++){
        visitedArr[i] = new bool[row*col];
    }
    for (int i = 0; i < row*col; i++){
        for (int j = 0; j < row*col; j++)
            visitedArr[i][j] = false;
    }

    Block* start = blockArr[col*startRow+startCol];
    Block* end = blockArr[col*endRow+endCol];
    Stack pathStack;
    pathStack.push(start);

    while(!pathStack.isEmpty()){
        Block* curr = pathStack.peek();
        if(curr == end){
            //Ensuring that paths array has enough capacity
            if(pathCount == pathCapacity){
                Stack* temp = new Stack[pathCapacity*2];
                for(int i = 0; i < pathCapacity; i++){
                    temp[i] = paths[i];
                }
                delete[] paths;
                paths = temp;
                pathCapacity *= 2;
            }
            paths[pathCount] = pathStack;
            pathCount++;
            pathStack.pop();
        }
        else{
            bool valid = false;
            for(int i = 0; i < curr->adjCount; i++){
                Block* child = curr->adj[i];
                if(!visitedArr[col*curr->row+curr->col][col*child->row+child->col]){
                    valid = true;
                    for(int j = 0; j < child->adjCount; j++){
                        Block* child_child = child->adj[j];
                        if(visitedArr[col*child->row+child->col][col*child_child->row+child_child->col]){
                            valid = false;
                            break;
                        }
                    }
                    if(valid){
                        visitedArr[col*curr->row+curr->col][col*child->row+child->col] = true;
                        pathStack.push(child);
                        break;
                    }
                }
            }
            if(!valid){
                for(int i = 0; i < row*col; i++){
                    visitedArr[col*curr->row+curr->col][i] = false;
                }
                pathStack.pop();
            }
        }
    }

    if(pathCount == 0){
        std::cout << "None" << std::endl;
    }
    for(int i = 0; i < pathCount; i++){ //Reversing the paths before printing because they're end -> start
        Stack curr = paths[i];
        Stack temp;
        while(!curr.isEmpty()){
            Block* topBlock = curr.peek();
            temp.push(topBlock);
            curr.pop();
        }
        while(!temp.isEmpty()){
            std::cout << temp.peek()->toString();
            temp.pop();
            if(!temp.isEmpty()){
                std::cout << " -> ";
            }
        }
        std::cout << std::endl;
    }


    for(int i = 0; i < col*row; i++){
        delete[] visitedArr[i];
    }
    delete[] visitedArr;
    delete[] paths;
}

void
BuildingMap::findPaths(const int startRow, const int startCol, const int endRow, const int endCol, const int avoidRow, const int avoidCol) {
    std::cout << "Paths from (" << startRow << "," << startCol << ") to (" << endRow << "," << endCol << ") avoiding (" << avoidRow << "," << avoidCol << ") are:"<< std::endl;
    
    int pathCount = 0;
    int pathCapacity = 100;
    Stack* paths = new Stack[pathCapacity];

    bool** visitedArr = new bool*[row*col];
    for(int i = 0; i < row*col; i++){
        visitedArr[i] = new bool[row*col];
    }
    for (int i = 0; i < row*col; i++){
        for (int j = 0; j < row*col; j++)
            visitedArr[i][j] = false;
    }

    Block* start = blockArr[col*startRow+startCol];
    Block* end = blockArr[col*endRow+endCol];
    Block* avoid = blockArr[col*avoidRow+avoidCol];
    Stack pathStack;
    pathStack.push(start);

    //Just added a (&& child != avoid) in if statement, before going in it and pushing to stack, it also checks that the child chosen is not same with the avoided block (line 300).
    while(!pathStack.isEmpty()){
        Block* curr = pathStack.peek();
        if(curr == end){
            if(pathCount == pathCapacity){
                Stack* temp = new Stack[pathCapacity*2];
                for(int i = 0; i < pathCapacity; i++){
                    temp[i] = paths[i];
                }
                delete[] paths;
                paths = temp;
                pathCapacity *= 2;
            }
            paths[pathCount] = pathStack;
            pathCount++;
            pathStack.pop();
        }
        else{
            bool valid = false;
            for(int i = 0; i < curr->adjCount; i++){
                Block* child = curr->adj[i];
                if(!visitedArr[col*curr->row+curr->col][col*child->row+child->col] && child != avoid){
                    valid = true;
                    for(int j = 0; j < child->adjCount; j++){
                        Block* child_child = child->adj[j];
                        if(visitedArr[col*child->row+child->col][col*child_child->row+child_child->col]){
                            valid = false;
                            break;
                        }
                    }
                    if(valid){
                        visitedArr[col*curr->row+curr->col][col*child->row+child->col] = true;
                        pathStack.push(child);
                        break;
                    }
                }
            }
            if(!valid){
                for(int i = 0; i < row*col; i++){
                    visitedArr[col*curr->row+curr->col][i] = false;
                }
                pathStack.pop();
            }
        }
    }
    if(pathCount == 0){
        std::cout << "None" << std::endl;
    }
    for(int i = 0; i < pathCount; i++){
        Stack curr = paths[i];
        Stack temp;
        while(!curr.isEmpty()){
            Block* topBlock = curr.peek();
            temp.push(topBlock);
            curr.pop();
        }
        while(!temp.isEmpty()){
            std::cout << temp.peek()->toString();
            temp.pop();
            if(!temp.isEmpty()){
                std::cout << " -> ";
            }
        }
        std::cout << std::endl;
    }

    for(int i = 0; i < col*row; i++){
        delete[] visitedArr[i];
    }
    delete[] visitedArr;
    delete[] paths;
}
