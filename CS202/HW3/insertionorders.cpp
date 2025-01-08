/**
* Title: Hashing
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 3
* Description : Answer to Question5
*/
#include <iostream>
#include <fstream>

const int MOD = 1000000009;

long long mod_pow(long long base, long long exp, long long mod) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

long long mod_inv(long long a, long long mod) {
    return mod_pow(a, mod - 2, mod);
}

long long factorial(int n) {
    long long f = 1;
    for (int i = 1; i <= n; ++i) {
        f = (f * i) % MOD;
    }
    return f;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cout << "Incorrect usage. Usage: ./insertionorders <input_file> <optional_output_file>" << std::endl;
        return 1;
    }
    std::ifstream file(argv[1]);
    if (!file.is_open()) {
        std::cout << "Input file cannot be opened." << std::endl;
        return 1;
    }
    if (argc > 2) {
        freopen(argv[2], "w", stdout);
    }

    int n;
    int tableSize = 0;
    file >> n;
    int* table = new int[n];
    int* diffPos = new int[n + 2];
    for (int i = 0; i < n; i++) {
        file >> table[i];
        if(table[i] != -1){
            tableSize++;
        }
    }
    for (int i = 0; i < n; i++) {
        if(table[i] != -1){
            int origPos = table[i] % n;
            if (origPos <= i) {
                diffPos[i] = i - origPos;
            } else {
                diffPos[i] = n - origPos + i;
            }
        }
        else{
            diffPos[i] = -1;
        }
    }
    diffPos[n] = diffPos[0];
    diffPos[n + 1] = diffPos[1];
    long long result = factorial(tableSize);
    for (int i = 0; i < n; i++) {
        int first = diffPos[i];
        int second = diffPos[i + 1];
        int third = diffPos[i + 2];
        if (first == 0 && second == 1 && third == 0) {
            result = (result * mod_inv(2, MOD)) % MOD;  // result /= 2
        }
        else if (first == 0 && second == 0 && third == 2) {
            result = (result * mod_inv(3, MOD)) % MOD;  // result /= 3
            i++;
        }
        else if (first == 0 && second == 1 && third == 2) {
            result = (result * mod_inv(6, MOD)) % MOD;  // result /= 6
            i++;
        }
        else if (first == 0 && second == 1 && third == 1) {
            result = (result * mod_inv(6, MOD)) % MOD;  // result /= 6
            i++;
        }
    }

    std::cout << result << std::endl;

    delete[] diffPos;
    delete[] table;
    return 0;
}