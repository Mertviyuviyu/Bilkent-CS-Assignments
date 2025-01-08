/**
* Title: Hashing
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 3
* Description : Answer to Question2
*/

#include <iostream>
#include <cstring>
#include <fstream>
#include <algorithm>

const int BASE1 = 257;
const int BASE2 = 263;
const int MOD1 = 1000000007;
const int MOD2 = 1000000009;

struct HashPair {
    int hash1;
    int hash2;
    int index;
    int length;
    bool operator<(const HashPair& other) const {
        if (length != other.length){
            return length < other.length;
        }
        if (hash1 != other.hash1){
            return hash1 < other.hash1;
        }
        if (hash2 != other.hash2){
            return hash2 < other.hash2;
        }
        return index < other.index;
    }
};
void reverse(char* arr) {
    int length = strlen(arr);
    for (int i = 0; i < length / 2; ++i) {
        char temp = arr[i];
        arr[i] = arr[length - 1 - i];
        arr[length - 1 - i] = temp;
    }
}

HashPair hash(const char* s, int length, int index) {
    int hash1 = 0, hash2 = 0;
    for (int i = 0; i < length; ++i) {
        hash1 = (1LL * hash1 * BASE1 + s[i]) % MOD1;
        hash2 = (1LL * hash2 * BASE2 + s[i]) % MOD2;
    }
    return {hash1, hash2, index, length};
}

HashPair rollHash(const HashPair& hash, int highestPow1, int highestPow2, char remove, char add) {
    int newHash1 = (hash.hash1 - (1LL * remove * highestPow1) % MOD1 + MOD1) % MOD1;
    newHash1 = (1LL * newHash1 * BASE1 + add) % MOD1;

    int newHash2 = (hash.hash2 - (1LL * remove * highestPow2) % MOD2 + MOD2) % MOD2;
    newHash2 = (1LL * newHash2 * BASE2 + add) % MOD2;

    return {newHash1, newHash2, hash.index, hash.length};
}
int powMod(int base, int exp, int mod) {
    int result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (1LL * result * base) % mod;
        }
        base = (1LL * base * base) % mod;
        exp /= 2;
    }
    return result;
}
int findStringWithHash(HashPair temp, const HashPair* sortedHashes, const int n) {
    int tempHash1 = temp.hash1;
    int tempHash2 = temp.hash2;
    int tempLen = temp.length;

    int left = 0;
    int right = n - 1;
    int result = -1;

    // Find leftmost matching element
    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (sortedHashes[mid].length != tempLen) {
            if (sortedHashes[mid].length < tempLen) left = mid + 1;
            else right = mid - 1;
            continue;
        }

        if (sortedHashes[mid].hash1 == tempHash1 &&
            sortedHashes[mid].hash2 == tempHash2) {
            result = mid;  // Found a match
            right = mid - 1;  // Keep searching left
        }
        else if (sortedHashes[mid].hash1 < tempHash1 ||
                 (sortedHashes[mid].hash1 == tempHash1 &&
                  sortedHashes[mid].hash2 < tempHash2)) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}
int main(int argc, char* argv[]){
    if(argc < 2){
        std::cout << "Incorrect usage. Usage: ./minimalset <input_file> <optional_output_file>" << std::endl;
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
    char* temp = new char[10000001];  // Temporary buffer for reading
    char** strings = new char*[n];

    for(int i = 0; i < n; i++) {
        file >> temp;
        int len = strlen(temp);
        strings[i] = new char[len + 1];  // +1 for null terminator
        strcpy(strings[i], temp);
    }
    delete[] temp;
    HashPair* sortedHashes = new HashPair[n];
    for(int i = 0; i < n; i++) {
        sortedHashes[i] = hash(strings[i], strlen(strings[i]), i);
    }
    std::sort(sortedHashes, sortedHashes + n);
    int reverseOps = 0;
    int minimalSubset = 0;
    bool* visited = new bool[n]();
    int countLeft = 0;
    int countRight = 0;
    for(int i = 0; i < n; i++) {
        if(!visited[i]) {
            visited[i] = true;
            minimalSubset++;
            int len = strlen(strings[i]);

            HashPair temporary = hash(strings[i],len,i);

            countLeft = 1;
            countRight = 0;
            int highestPow1 = powMod(BASE1, len - 1, MOD1);
            int highestPow2 = powMod(BASE2, len - 1, MOD2);
            for(int j = 0; j < len-1; j++) {
                temporary = rollHash(temporary,highestPow1,highestPow2,strings[i][j],strings[i][j]);
                int id = findStringWithHash(temporary, sortedHashes, n);
                if(id != -1) {
                    for(int k = id; k < n && sortedHashes[k].hash1 == sortedHashes[id].hash1 && sortedHashes[k].hash2 == sortedHashes[id].hash2; k++) {
                        if(!visited[sortedHashes[k].index]) {
                            visited[sortedHashes[k].index] = true;
                            countLeft++;
                        }
                    }
                }
            }
            char* tempstr = new char[len+1];
            strcpy(tempstr, strings[i]);
            reverse(tempstr);
            temporary = hash(tempstr,len,i);
            for(int j = 0; j < len; j++) {
                int id = findStringWithHash(temporary, sortedHashes, n);
                if(id != -1) {
                    for(int k = id; k < n && sortedHashes[k].hash1 == sortedHashes[id].hash1 && sortedHashes[k].hash2 == sortedHashes[id].hash2; k++) {
                        if(!visited[sortedHashes[k].index]) {
                            visited[sortedHashes[k].index] = true;
                            countRight++;
                        }
                    }
                }
                temporary = rollHash(temporary,highestPow1,highestPow2,tempstr[j],tempstr[j]);
            }

            reverseOps += (countLeft < countRight) ? countLeft : countRight;
            delete[] tempstr;
        }
    }
    std::cout << reverseOps << std::endl;
    std::cout << minimalSubset << std::endl;
    for(int i = 0; i < n; i++){
        delete[] strings[i];
    }
    delete[] strings;
    delete[] visited;
    delete[] sortedHashes;
    file.close();
    return 0;
}
