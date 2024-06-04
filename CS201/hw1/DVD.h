//Mustafa Mert Gülhan CS201-01 22201895
#ifndef HW1_DVD_H
#define HW1_DVD_H
#include <string>
using namespace std;

class DVD {
public:
    DVD();
    DVD(const string& serialNumber, const string& title, const string& director);
    string serialNumber;
    string title;
    string director;
    bool available{};
    int renterID;
};
#endif //HW1_DVD_H
