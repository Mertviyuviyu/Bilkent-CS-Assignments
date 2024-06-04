//
// Created by Mert on 8.05.2024.
//

#include "Block.h"
Block::Block(int row, int col) {
    this->row = row;
    this->col = col;
    this->type = -1;
    this->adjCount = 0;
    adj = new Block*[4]; // a block has max 4 adj;
}


Block::Block() {
    row = -1;
    col = -1;
    this->type = -1;
    this->adjCount = 0;
    adj = nullptr;
}

Block::~Block() {
    delete[] adj;
}

void Block::addAdj(Block* block) {
    if(adjCount > 3){
        return;
    }
    this->adj[adjCount] = block;
    this->adjCount++;
}

std::string Block::toString() {
    std::string str;
    str += "(" + std::to_string(row) + "," + std::to_string(col) + ")";
    return str;
}
