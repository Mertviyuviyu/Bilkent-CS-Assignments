//Mustafa Mert Gülhan CS201-01 22201895
#ifndef HW1_DVDSTOREMANAGEMENTSYSTEM_H
#define HW1_DVDSTOREMANAGEMENTSYSTEM_H
#include <string>
#include "DVD.h"
#include "Customer.h"
#include "Transaction.h"
using namespace std;

class DVDStoreManagementSystem {
public:
    DVDStoreManagementSystem();
    ~DVDStoreManagementSystem();
    void addDVD( const string serialNo, const string title, const string director );
    void removeDVD( const string serialNo );
    void addCustomer( const int customerID, const string name );
    void removeCustomer( const int customerID );
    void rentDVD( const int customerID, const string serialNo );
    void returnDVD( const int customerID, const string serialNo );
    void showAllDVDs() const;
    void showAllCustomers() const;
    void showDVD( const string serialNo ) const;
    void showCustomer( const int customerID ) const;
    void showTransactionHistory() const;
private:
    Customer* customers;
    DVD* DVDs;
    Transaction* transactions;
    int dvdCount;
    int customerCount;
    int transactionCount;
};

#endif //HW1_DVDSTOREMANAGEMENTSYSTEM_H
