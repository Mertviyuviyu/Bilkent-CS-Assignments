//Mustafa Mert Gülhan 22201895 CS201-1

#include <cstdlib>
#include <algorithm>
#include <iostream>
#include <cmath>

void swap(int& a, int& b){
    int temp = a;
    a = b;
    b = temp;
}
int insertionSort(int arr[], int size){
    int timeCount = 0;
    int sel;
    for(int i = 0; i < size; i++){
        sel = arr[i];
        timeCount +=5;
        int j = i;
        timeCount++; //comparing in while
        while( j > 0 && arr[j-1] > sel){
            arr[j] = arr[j-1];
            timeCount += 5;
            j = j-1;
            timeCount++; //compares again if it does not exit the while loop
        }
        arr[j] = sel;
        timeCount += 5;
    }
    return timeCount;
}

int selectionSort(int arr[], int size){
    int timeCount = 0;
    for(int i = 0; i < size-1; i++){
        int indMin = i;
        for(int j = i+1; j < size; j++){
            timeCount++; //comparison
            if(arr[j] < arr[indMin]){
                indMin = j;
            }
        }
        if(indMin != i){
            swap(arr[indMin],arr[i]);
            timeCount += 15; //swap
        }
    }
    return timeCount;
}

int bubbleSort(int arr[], int size){
    int timeCount = 0;
    bool swapped = true;
    while(swapped){
        swapped = false;
        for(int i = 1; i <= size-1; i++){
            timeCount++; //comparison
            if(arr[i-1] > arr[i]){
                swap(arr[i-1],arr[i]);
                timeCount += 15; //swap
                swapped = true;
            }
        }
    }
    return timeCount;
}
int partition(int arr[], int lowerBound, int upperBound, int& timeCount){
    int pivot = arr[upperBound];
    timeCount+=5;
    int tempPivot = lowerBound-1;
    for(int j = lowerBound; j < upperBound; j++){
        timeCount++; //comparison
        if(arr[j] <= pivot){
            tempPivot++;
            swap(arr[tempPivot], arr[j]);
            timeCount+=15; //swap
        }
    }
    tempPivot++;
    swap(arr[tempPivot],arr[upperBound]);
    timeCount+=15; //swap
    return tempPivot;
}
void quickSort(int arr[], int lowerBound, int upperBound, int& timeCount){
    if(lowerBound >= upperBound || lowerBound < 0){
        return; //invalid bounds
    }
    int p = partition(arr,lowerBound,upperBound,timeCount);

    quickSort(arr,lowerBound,p-1,timeCount);
    quickSort(arr,p+1,upperBound,timeCount);
}

//My suggested algorithm for Task 3, timeCount1 refers to first worker and timeCount2 refers to second worker
void quickSort2(int arr[], int lowerBound, int upperBound, int& timeCount1, int& timeCount2){
    if(lowerBound >= upperBound || lowerBound < 0){
        return; //invalid bounds
    }
    int p = partition(arr,lowerBound,upperBound,timeCount1);
    if(upperBound-lowerBound <= 128){
        timeCount1 += selectionSort(arr+lowerBound,(p-1)-lowerBound+1);
        timeCount2 += selectionSort(arr+p+1,upperBound-(p+1)+1);
    }
    else{
        quickSort2(arr,lowerBound,p-1,timeCount1,timeCount2);
        quickSort2(arr,p+1,upperBound,timeCount2,timeCount1);
    }
}

void printArr (const int arr[], int size){
    std::cout << "[";
    for(int i = 0; i < size-1; i++){
        std::cout << arr[i] << ", ";
    }
    std::cout << arr[size-1] <<  "]" << std::endl;
}

int *generate_random_array(int size) {
// TODO: you have to implement this
    srand((unsigned int)time(NULL));
    int* arr = new int[size];
    for(int i = 0; i < size; i++){
        arr[i] = rand();
    }
    return arr;
}
int *generate_almost_sorted_array(int size) {
    srand((unsigned int)time(NULL));
    int *random_array = generate_random_array(size);

// TODO: here, you have to sort this array.
    int timeCount = 0;
    quickSort(random_array,0,size-1,timeCount);

    int swap_count = size * 0.03;
    if(swap_count == 0){
        int first_index = std::rand() % size;
        int second_index = size - first_index;
        int temp = random_array[first_index];
        random_array[first_index] = random_array[second_index];
        random_array[second_index] = temp;
    }
    for (int i = 0; i < swap_count; i++) {
        int first_index = std::rand() % size;
        int second_index = size - first_index;
        int temp = random_array[first_index];
        random_array[first_index] = random_array[second_index];
        random_array[second_index] = temp;
    }
    return random_array;
}

int main() {

    //Task 3

    int timeCount1 = 0;
    int timeCount3 = 0; //first worker count
    int timeCount4 = 0; //second worker count
    int size = pow(2,12);
    int* arr = generate_random_array(size);
    int* arr2 = generate_random_array(size);
    //printArr(arr,size);
    //printArr(arr2,size);
    quickSort(arr,0,size-1,timeCount1); //for comparison
    //printArr(arr,size);
    //printArr(arr2,size);
    quickSort2(arr2,0,size-1,timeCount3,timeCount4); //method for Task3 timeCount3 is the first worker and timeCount 4 is the second worker
    //printArr(arr2,size);
    std::cout << "Solo worker: " << timeCount1 << std::endl;

    std::cout << "First worker2: " << timeCount3 << std::endl;
    std::cout << "Second worker2: " << timeCount4 << std::endl;
    std::cout << "Total work2: " << timeCount3+timeCount4 << std::endl;

    delete[] arr;
    //delete[] arr2;

    //Task 2

    /*
    int timeCount = 0;
    int size = pow(2,8);
    int* arr = generate_almost_sorted_array(size);
    //printArr(arr,size);
    timeCount = bubbleSort(arr,size);
    //printArr(arr,size);
    delete[] arr;
    std::cout << "Time took for sorting: " << timeCount << std::endl;
     */

    /*
    int timeCount = 0;
    int size = pow(2,3);
    for(int i = 0; i < 5; i++){
        int specificTime = 0;
        srand((unsigned int)time(NULL)+i);
        int* arr = generate_almost_sorted_array(size);
        //printArr(arr,size);
        quickSort(arr,0,size-1,specificTime);
        //printArr(arr,size);
        timeCount += specificTime;
        delete[] arr;
        std::cout << "Time took for sorting: " << specificTime << std::endl;
    }
    std::cout << "Average time took for sorting: " << timeCount/5 << std::endl;
    */

    //Task 1

    /*
    int timeCount = 0;
    int size = pow(2,12);
    int* arr = generate_random_array(size);
    //printArr(arr,size);
    timeCount = selectionSort(arr,size);
    //printArr(arr,size);
    delete[] arr;
    std::cout << "Time took for sorting: " << timeCount << std::endl;
     */
}
