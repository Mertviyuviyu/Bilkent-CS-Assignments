//Mustafa Mert Gülhan CS201-01 22201895
#ifndef HW1_CUSTOMER_H
#define HW1_CUSTOMER_H
#include <string>
#include "DVD.h"
using namespace std;

class Customer {
public:
    Customer();
    Customer(const int customerID , const string& name);
    int customerID{};
    string name;
    int rentedDVDCount{};
};

#endif //HW1_CUSTOMER_H
