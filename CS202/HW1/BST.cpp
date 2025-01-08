/**
* Title: Binary Search Trees
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 1
* Description : BST implementation for question 2
*/
#include "BST.h"

bool BST::nodeExists(int val) {
    if(root == nullptr){
        return false;
    }
    Node* temp = root;
    while(temp != nullptr){
        if(temp->key == val){
            return true;
        }
        else if(temp->key < val){
            temp = temp->right;
        }
        else{
            temp = temp->left;
        }
    }
    return false;
}

void BST::insertKeyBase(int key) {
    if(nodeExists(key)){
        return;
    }
    else if(root == nullptr){
        root = new Node(key);
        return;
    }

    Node* parent = nullptr;
    Node* curr = root;

    while(curr != nullptr){
        parent = curr;
        if(key < curr->key){
            curr = curr->left;
        }
        else{
            curr = curr->right;
        }
    }

    if(key > parent->key){
        parent->right = new Node(key);
    }
    else{
        parent->left = new Node(key);
    }
}

BST::BST(int *keys, int size) {
    root = nullptr;
    for(int i = 0; i < size; i++){
        insertKeyBase(keys[i]);
    }
    std::cout << "BST with size " << size << " is created." << std::endl;
}

BST::~BST() {
    delete root;
}

void BST::insertKey(int key) {
    if(nodeExists(key)){
        std::cout << "Key " << key << " is not added. It exists!" << std::endl;
        return;
    }
    insertKeyBase(key);
    std::cout << "Key " << key << " is added." << std::endl;
}

void BST::insertKeyNoPrint(int key) {
    if(nodeExists(key)){
        return;
    }
    insertKeyBase(key);
}

void BST::deleteNode(Node *&nodePtr) {
    int replacement;
    if(nodePtr == nullptr){
        return;
    }
    if(nodePtr->left == nullptr && nodePtr->right == nullptr){
        delete nodePtr;
        nodePtr = nullptr;
    }
    else if(nodePtr->left == nullptr){
        nodePtr->key = nodePtr->right->key;
        delete nodePtr->right;
        nodePtr->right = nullptr;
    }
    else if(nodePtr->right == nullptr){
        nodePtr->key = nodePtr->left->key;
        delete nodePtr->left;
        nodePtr->left = nullptr;
    }
    else{
        processLeftmost(nodePtr->right, replacement);
        nodePtr->key = replacement;
    }
}

void BST::processLeftmost(Node *&nodePtr, int& key) {
    if(nodePtr->left == nullptr){
        key = nodePtr->key;
        Node* del = nodePtr;
        nodePtr = nodePtr->right;
        del->right = nullptr;
        delete del;
    }
    else{
        processLeftmost(nodePtr->left, key);
    }
}

void BST::deleteKey(int key) {
    if(!nodeExists(key)){
        std::cout << "Key " << key << " is not deleted. It does not exist!" << std::endl;
        return;
    }
    Node* curr = root;
    Node* parent = nullptr;
    while(curr != nullptr && curr->key != key){
        parent = curr;
        if(key > curr->key){
            curr = curr->right;
        }
        else{
            curr = curr->left;
        }
    }
    if(curr != nullptr){
        if(parent == nullptr){
            deleteNode(root);
        }
        else if(parent->left == curr){
            deleteNode(parent->left);
        }
        else{
            deleteNode(parent->right);
        }
    }
    std::cout << "Key " << key << " is deleted." << std::endl;
}

void BST::inOrderHelper(Node *node, bool &first) {
    if(node == nullptr){
        return;
    }
    inOrderHelper(node->left, first);
    if(first){
        std::cout << node->key;
        first = false;
    }
    else{
        std::cout << ", " << node->key;
    }
    inOrderHelper(node->right, first);
}

void BST::displayInorder() {
    if(root == nullptr){
        std::cout << "Tree is empty." << std::endl;
        return;
    }
    bool first = true;
    std::cout << "Inorder display is: ";
    inOrderHelper(root, first);
    std::cout << std::endl;
}

int BST::getHeight(Node *node) {
    if(node == nullptr){
        return 0;
    }
    int left = getHeight(node->left);
    int right = getHeight(node->right);
    if(left >= right){
        return 1 + left;
    }
    else{
        return 1 + right;
    }
}

int BST::treeHeight() {
    return getHeight(root);
}

bool BST::levelIsFull(Node *node, int level) {
    if(node == nullptr){
        return level <= 0;
    }
    if(level == 1){
        return true;
    }
    return levelIsFull(node->left, level-1) && levelIsFull(node->right, level-1);
}

void BST::findFullBTLevel() {
    if(root == nullptr){
        std::cout << "Full binary tree level is: 0" << std::endl;
        return;
    }
    int height = getHeight(root);
    int left = 1;
    int right = height;

    //recursive binary search
    while(left <= right){
        int mid = left + (right-left) / 2;

        //full at mid height and not full at mid+1 height, so we found the height
        if(levelIsFull(root,mid) && !levelIsFull(root,mid+1)){
            std::cout << "Full binary tree level is: " << mid << std::endl;
            return;
        }
        // level is also full at mid+1 so make left mid+1
        else if(levelIsFull(root,mid)){
            left = mid+1;
        }
        // level is not full at level mid so make right mid-1
        else{
            right = mid-1;
        }
    }
    std::cout << "Full binary tree level is: " << right << std::endl;

}

Node* BST::lcaHelper(Node* node,int A, int B) {
    if(node == nullptr){
        return nullptr;
    }
    if(node->key == A || node->key == B){
        return node;
    }
    if(A < node->key && B < node->key){
        return lcaHelper(node->left, A, B);
    }
    if(A > node->key && B > node->key){
        return lcaHelper(node->right, A, B);
    }
    return node;
}

void BST::lowestCommonAncestor(int A, int B) {
    if(root == nullptr){
        std::cout << "Tree is empty." << std::endl;
        return;
    }
    if(!nodeExists(A) || !nodeExists(B)){
        std::cout << "Node A or B does not exist." << std::endl;
        return;
    }

    Node* lca = lcaHelper(root, A, B);
    if(lca != nullptr){
        std::cout << "Lowest common ancestor of " << A << " and " << B << " is: " << lca->key << std::endl;
    }
    else{
        std::cout << "Lowest common ancestor of " << A << " and " << B << " is: none" << std::endl;
    }

}

void BST::maxSumHelper(Node *node, Node*& maxNode, int currSum, int &maxSum) {
    if(node == nullptr){
        return;
    }
    currSum += node->key;
    if( node->left == nullptr && node->right == nullptr){
        if(currSum > maxSum){
            maxSum = currSum;
            maxNode = node;
        }
    }
    maxSumHelper(node->left,maxNode,currSum,maxSum);
    maxSumHelper(node->right,maxNode,currSum,maxSum);
}

void BST::printPathHelper(Node *start, Node *end, bool &first) {
    if(start == nullptr){
        return;
    }
    if(!first){
        std::cout << ", ";
    }
    else{
        first = false;
    }
    std::cout << start->key;
    if(start != end){
        if(end->key < start->key){
            printPathHelper(start->left,end,first);
        }
        else{
            printPathHelper(start->right,end,first);
        }
    }
}

void BST::maximumSumPath() {
    if(root == nullptr){
        std::cout << "Tree is empty." << std::endl;
        return;
    }
    //assuming no negative nodes
    int maxSum = -1;
    bool first = true;
    Node* maxNode = nullptr;
    maxSumHelper(root, maxNode,0, maxSum);
    std::cout << "Maximum sum path is: ";
    printPathHelper(root,maxNode,first);
    std::cout << std::endl;
}

void BST::maxWidthHelper(Node *node, int level, bool& first) {
    if(node == nullptr){
        return;
    }
    if(level == 1){
        if(!first){
            std::cout << ", ";
        }
        std::cout << node->key;
        first = false;
    }
    else if(level > 1){
        maxWidthHelper(node->left, level-1, first);
        maxWidthHelper(node->right, level-1, first);
    }
}

int BST::countNodesOnLevel(Node *node, int level) {
    if(node == nullptr){
        return 0;
    }
    if(level == 1){
        return 1;
    }
    return countNodesOnLevel(node->left, level-1) + countNodesOnLevel(node->right, level-1);
}

void BST::maximumWidth() {
    if(root == nullptr){
        std::cout << "Tree is empty." << std::endl;
        return;
    }
    std::cout << "Maximum level is: ";
    int height = getHeight(root);
    int maxWidth = 0;
    int maxLevel = 0;
    for(int i = 1; i <= height; i++){
        int width = countNodesOnLevel(root, i);
        if(width > maxWidth){
            maxWidth = width;
            maxLevel = i;
        }
    }
    bool temp = true;
    maxWidthHelper(root, maxLevel, temp);
    std::cout << std::endl;
}

bool BST::pathHelper(Node *node, int key, bool& first) {
    if(node == nullptr){
        return false;
    }
    if(node->key == key || pathHelper(node->left, key, first) || pathHelper(node->right, key, first)){
        if(!first){
            std::cout << ", ";
        }
        std::cout << node->key;
        first = false;
        return true;
    }
    return false;
}

void BST::pathFromAtoB(int A, int B) {
    if(root == nullptr){
        std::cout << "Tree is empty." << std::endl;
        return;
    }
    if(!nodeExists(A) || !nodeExists(B)){
        std::cout << "Node A or B does not exist." << std::endl;
        return;
    }
    Node* LCA = lcaHelper(root, A, B);
    if(LCA == nullptr){
        std::cout << "none" << std::endl;
        return;
    }
    std::cout << "Path from " << A << " to " << B << " is: ";
    bool first = true;
    pathHelper(LCA, A, first);
    if(LCA->key != A){
        if(LCA->key != B){
            Node* temp = LCA;
            while(temp != nullptr && temp->key != B){
                if(temp->key > B){
                    temp = temp->left;
                }
                else if(temp->key < B) {
                    temp = temp->right;
                }
                if(temp != nullptr && temp->key != LCA->key){
                    if(first){
                        std::cout << temp->key;
                        first = false;
                    }
                    else{
                        std::cout << ", " << temp->key;
                    }
                }
            }

        }
    }
    std::cout << std::endl;
}
