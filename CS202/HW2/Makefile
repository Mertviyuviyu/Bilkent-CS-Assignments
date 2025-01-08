#**/
#* Title: AVL Trees & Heap
#* Author: Mustafa Mert Gülhan
#* ID: 22201895
#* Section : 1
#* Homework : 2
#* Description : Makefile to produce executables for Question 1,2,3,4
#*/

make: build

build: least5 game prefixsubarray subarray

least5: least5.cpp Heap.cpp
	g++ -Wall -o least5 Heap.cpp least5.cpp

game: game.cpp AVLTree.cpp Node.cpp
	g++ -Wall -o game game.cpp AVLTree.cpp Node.cpp

prefixsubarray: prefixsubarray.cpp AVLTree.cpp Node.cpp
	g++ -Wall -o prefixsubarray prefixsubarray.cpp AVLTree.cpp Node.cpp

subarray: subarray.cpp AVLTree.cpp Node.cpp
	g++ -Wall -o subarray subarray.cpp AVLTree.cpp Node.cpp

clean:
	rm -f least5 game prefixsubarray subarray