//Mustafa Mert Gülhan CS201-01 22201895
#include "Customer.h"

Customer::Customer() = default;

Customer::Customer(const int customerID, const string &name) {
    this->customerID = customerID;
    this->name = name;
    this->rentedDVDCount = 0;
}
