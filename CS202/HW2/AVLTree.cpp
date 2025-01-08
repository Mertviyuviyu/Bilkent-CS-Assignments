/**
* Title: AVL Trees & Heap
* Author: Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 2
* Description : AVL Tree implementation
*/

#include "AVLTree.h"
AVLTree::AVLTree() {
    root = nullptr;
    size = 0;
}

AVLTree::~AVLTree() {
    delete root;
}

void AVLTree::insertKey(int key) {
    root = insert(root, key);
    size++;
}

void AVLTree::removeKey(int key) {
    root = deleteNode(root, key);
    size--;
}

int AVLTree::getMax() {
    if(root == nullptr){
        return -1;
    }
    else{
        Node* maxNode = findMax(root);
        return maxNode->key;
    }
}

int AVLTree::getMin() {
    if(root == nullptr){
        return -1;
    }
    else{
        Node* minNode = findMin(root);
        return minNode->key;
    }
}

int AVLTree::getLargestSmallerThan(int key) {
    Node* result = findLargestSmallerThan(root,key, nullptr);
    if(result == nullptr){
        return -1;
    }
    else{
        return result->key;
    }
}

int AVLTree::getSize() const{
    return size;
}

int AVLTree::height(Node *node) {
    if(node == nullptr){
        return 0;
    }
    else{
        return node->height;
    }
}

int AVLTree::balanceFactor(Node *node) {
    if(node == nullptr){
        return 0;
    }
    else{
        return height(node->right) - height(node->left);
    }
}

void AVLTree::updateHeight(Node *node) {
    if(node != nullptr){
        int leftHeight = height(node->left);
        int rightHeight = height(node->right);
        if(leftHeight > rightHeight){
            node->height = 1 + leftHeight;
        }
        else{
            node->height = 1 + rightHeight;
        }
    }
}

Node *AVLTree::rotateLeft(Node *A) {
    Node* B = A->right;
    Node* C = B->left;

    B->left = A;
    A->right = C;

    updateHeight(A);
    updateHeight(B);

    //return new top
    return B;
}

Node *AVLTree::rotateRight(Node *B) {
    Node* A = B->left;
    Node* C = A->right;

    A->right = B;
    B->left = C;

    updateHeight(A);
    updateHeight(B);

    return A;
}

Node *AVLTree::insert(Node *node, int key) {
    if(node == nullptr){
        return new Node(key);
    }
    if(key < node->key){
        node->left = insert(node->left, key);
    }
    else{
        node->right = insert(node->right, key);
    }
    updateHeight(node);
    int factor = balanceFactor(node);

    //Left child of left subtree
    if(factor < -1 && key < node->left->key){
        return rotateRight(node);
    }
    //Right child of right subtree
    if(factor > 1 && key >= node->right->key){
        return rotateLeft(node);
    }
    //Right child of left subtree so LR
    if(factor < -1 && key >= node->left->key){
        node->left = rotateLeft(node->left);
        return rotateRight(node);
    }
    //Left child of right subtree so RL
    if(factor > 1 && key < node->right->key){
        node->right = rotateRight(node->right);
        return rotateLeft(node);
    }
    return node;
}

Node *AVLTree::findMax(Node *node) {
    if(node->right != nullptr){
        return findMax(node->right);
    }
    else{
        return node;
    }
}

Node *AVLTree::findMin(Node *node) {
    if(node->left != nullptr){
        return findMin(node->left);
    }
    else{
        return node;
    }
}

Node *AVLTree::deleteNode(Node *node, int key) {
    if(node == nullptr){
        return nullptr;
    }
    if(key < node->key){
        node->left = deleteNode(node->left, key);
    }
    else if(key > node->key){
        node->right = deleteNode(node->right, key);
    }
    else{
        if(node->left == nullptr) {
            Node* temp = node->right;
            node->right = nullptr;
            delete node;
            return temp;
        }
        else if(node->right == nullptr) {
            Node* temp = node->left;
            node->left = nullptr;
            delete node;
            return temp;
        }

        Node* successor = findMin(node->right);
        node->key = successor->key;
        node->right = deleteNode(node->right, successor->key);
    }

    if(node == nullptr){
        return nullptr;
    }
    updateHeight(node);
    int factor = balanceFactor(node);
    if(factor < -1 && balanceFactor(node->left) <= 0){
        return rotateRight(node);
    }
    if(factor < -1 && balanceFactor(node->left) > 0 ){
        node->left = rotateLeft(node->left);
        return rotateRight(node);
    }
    if(factor > 1 && balanceFactor(node->right) >= 0){
        return rotateLeft(node);
    }
    if(factor > 1 && balanceFactor(node->right) < 0){
        node->right = rotateRight(node->right);
        return rotateLeft(node);
    }
    return node;
}

Node *AVLTree::findLargestSmallerThan(Node *node, int key, Node *lastSmaller) {
    if(node == nullptr){
        return lastSmaller;
    }
    if(node->key >= key){
        return findLargestSmallerThan(node->left,key,lastSmaller);
    }
    else{
        return findLargestSmallerThan(node->right,key,node);
    }
}
