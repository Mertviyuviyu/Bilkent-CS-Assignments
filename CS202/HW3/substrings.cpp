/**
* Title: Hashing
* Author : Mustafa Mert Gülhan
* ID: 22201895
* Section : 1
* Homework : 3
* Description : Answer to Question1
*/

#include <iostream>
#include <fstream>
#include <cstring>
#include <algorithm>

const int BASE1 = 257;
const int BASE2 = 263;
const int MOD1 = 1000000007;
const int MOD2 = 1000000009;

struct HashPair {
    int hash1;
    int hash2;
    bool operator<(const HashPair& other) const {
        if (hash1 == other.hash1) {
            return hash2 < other.hash2;
        }
        return hash1 < other.hash1;
    }
    bool operator==(const HashPair& other) const {
        return hash1 == other.hash1 && hash2 == other.hash2;
    }
};

HashPair hash(const char* s, int length) {
    int hash1 = 0, hash2 = 0;
    for (int i = 0; i < length; ++i) {
        hash1 = (1LL * hash1 * BASE1 + s[i]) % MOD1;
        hash2 = (1LL * hash2 * BASE2 + s[i]) % MOD2;
    }
    return {hash1, hash2};
}

HashPair rollHash(const HashPair& hash, int highestPow1, int highestPow2, char remove, char add) {
    int newHash1 = (hash.hash1 - (1LL * remove * highestPow1) % MOD1 + MOD1) % MOD1;
    newHash1 = (1LL * newHash1 * BASE1 + add) % MOD1;

    int newHash2 = (hash.hash2 - (1LL * remove * highestPow2) % MOD2 + MOD2) % MOD2;
    newHash2 = (1LL * newHash2 * BASE2 + add) % MOD2;

    return {newHash1, newHash2};
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

void getSubstring(const char* str, int start, int length, char* result) {
    for (int i = 0; i < length; ++i) {
        result[i] = str[start + i];
    }
    result[length] = '\0';
}

struct PatternInfo {
    HashPair hash;
    int index;
    bool operator<(const PatternInfo& other) const {
        return hash < other.hash;
    }
};

int binarySearch(PatternInfo* arr, int size, const HashPair& targetHash) {
    int left = 0, right = size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid].hash == targetHash) {
            return mid;
        } else if (arr[mid].hash < targetHash) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return -1;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cout << "Incorrect usage. Usage: ./substrings <input_file> <optional_output_file>" << std::endl;
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

    char* temp = new char[100001];  // Temporary buffer for reading text
    file >> temp;
    int textLen = strlen(temp);
    char* text = new char[textLen + 1];  // +1 for null terminator
    strcpy(text, temp);
    delete[] temp;

    int patternSize;
    file >> patternSize;
    char** patterns = new char*[patternSize];
    int* answers = new int[patternSize];
    int* patternLengths = new int[patternSize];

    int minLen = 100000;
    int maxLen = 0;
    char* tempPattern = new char[300001];  // Temporary buffer for reading patterns

    for (int i = 0; i < patternSize; i++) {
        file >> tempPattern;
        patternLengths[i] = strlen(tempPattern);
        patterns[i] = new char[patternLengths[i] + 1];  // +1 for null terminator
        strcpy(patterns[i], tempPattern);
        answers[i] = 0;

        if (patternLengths[i] < minLen) {
            minLen = patternLengths[i];
        }
        if (patternLengths[i] > maxLen) {
            maxLen = patternLengths[i];
        }
    }
    delete[] tempPattern;

    // minLen and maxLen differs at most 5
    for (int currLen = minLen; currLen <= maxLen; ++currLen) {
        // Collect patterns of current length
        int count = 0;
        for (int i = 0; i < patternSize; ++i) {
            if (patternLengths[i] == currLen) {
                count++;
            }
        }
        if (count == 0) continue;

        // Arrays to store pattern hashes and indices
        PatternInfo* patternInfos = new PatternInfo[count];
        int idx = 0;
        for (int i = 0; i < patternSize; ++i) {
            if (patternLengths[i] == currLen) {
                patternInfos[idx].hash = hash(patterns[i], currLen);
                patternInfos[idx].index = i;
                idx++;
            }
        }

        std::sort(patternInfos, patternInfos + count);

        int highestPow1 = powMod(BASE1, currLen - 1, MOD1);
        int highestPow2 = powMod(BASE2, currLen - 1, MOD2);

        if (textLen < currLen) {
            delete[] patternInfos;
            continue;
        }
        HashPair windowHash = hash(text, currLen);
        // Check the first window
        int pos = binarySearch(patternInfos, count, windowHash);
        if (pos != -1) {
            int left = pos, right = pos;
            // Check for duplicate hashes
            while (left > 0 && patternInfos[left - 1].hash == windowHash) {
                left--;
            }
            while (right < count - 1 && patternInfos[right + 1].hash == windowHash) {
                right++;
            }
            for (int k = left; k <= right; ++k) {
                int index = patternInfos[k].index;
                answers[index]++;
            }
        }

        // Slide the window
        for (int j = 1; j <= textLen - currLen; ++j) {
            windowHash = rollHash(windowHash, highestPow1, highestPow2, text[j - 1], text[j + currLen - 1]);
            pos = binarySearch(patternInfos, count, windowHash);
            if (pos != -1) {
                int left = pos, right = pos;
                // Check for duplicate hashes
                while (left > 0 && patternInfos[left - 1].hash == windowHash) {
                    left--;
                }
                while (right < count - 1 && patternInfos[right + 1].hash == windowHash) {
                    right++;
                }
                for (int k = left; k <= right; ++k) {
                    int index = patternInfos[k].index;
                    answers[index]++;
                }
            }
        }

        delete[] patternInfos;
    }

    for (int i = 0; i < patternSize; i++) {
        std::cout << answers[i] << std::endl;
    }

    for (int i = 0; i < patternSize; i++) {
        delete[] patterns[i];
    }
    delete[] patterns;
    delete[] patternLengths;
    delete[] text;
    delete[] answers;
}