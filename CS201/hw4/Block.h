//
// Created by Mert on 8.05.2024.
//

#ifndef HW4_BLOCK_H
#define HW4_BLOCK_H
#include <string>

class Block {
public:
    int row;
    int col;
    int type;
    Block** adj;
    int adjCount;
    void addAdj(Block* block);
    Block(int x, int y);
    Block();
    ~Block();

    std::string toString();
};


#endif //HW4_BLOCK_H
