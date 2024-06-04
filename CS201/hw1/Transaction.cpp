//Mustafa Mert Gülhan CS201-01 22201895

#include "Transaction.h"
Transaction::Transaction() = default;

Transaction::Transaction(const string &serialNo, int customerID, const string &transactionType) {
    this->customerID = customerID;
    this->serialNo = serialNo;
    this->transactionType = transactionType;
}
