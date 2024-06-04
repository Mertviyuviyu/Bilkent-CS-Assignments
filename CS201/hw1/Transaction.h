//Mustafa Mert Gülhan CS201-01 22201895
#ifndef HW1_TRANSACTION_H
#define HW1_TRANSACTION_H
#include <string>
using namespace std;


class Transaction {
public:
    Transaction();
    Transaction(const string& serialNo, int customerID, const string& transactionType);
    string serialNo;
    int customerID{};
    string transactionType; // "Rental" or "Return"
};


#endif //HW1_TRANSACTION_H
