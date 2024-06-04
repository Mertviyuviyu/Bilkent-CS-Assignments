//
// Created by Mert on 8.05.2024.
//

#ifndef HW4_BUILDINGMAP_H
#define HW4_BUILDINGMAP_H
#include <string>
#include <fstream>
#include "Block.h"
#include "Stack.h"

using namespace std;

class BuildingMap {
public:

    BuildingMap(const string buildingMapFile);

    int col;
    int row;
    Block** blockArr;

    void findAdj(Block* block);
    ~BuildingMap();
    void displayAllCubicles() const;
    void displayAdjacentCubicles(const int row, const int col) const;
    void displayBuildingMap() const;
    void findPaths(const int startRow, const int startCol, const int endRow, const int endCol);
    void findPaths(const int startRow, const int startCol, const int endRow, const int endCol, const int avoidRow, const int avoidCol);
};


#endif //HW4_BUILDINGMAP_H
