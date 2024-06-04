//Mustafa Mert Gülhan CS201-01 22201895
#include "DVDStoreManagementSystem.h"
#include <iostream>

DVDStoreManagementSystem::DVDStoreManagementSystem() {
    DVDs = nullptr;
    customers = nullptr;
    transactions = nullptr;
    dvdCount = 0;
    customerCount = 0;
    transactionCount = 0;
}

DVDStoreManagementSystem::~DVDStoreManagementSystem() {
    delete[] DVDs;
    delete[] customers;
    delete[] transactions;
}

void DVDStoreManagementSystem::addDVD(const string serialNo, const string title, const string director) {
    if(dvdCount == 0){
        DVDs = new DVD[1];
        DVDs[0] = DVD(serialNo,title,director);
    }
    else{
        for(int i = 0; i < dvdCount; i++){
            if(DVDs[i].serialNumber == serialNo){
                std::cout << "Cannot add DVD. DVD with serial number " << serialNo << " already exists." << std::endl;
                return;
            }
        }
        DVD* temp = new DVD[dvdCount+1];
        for(int i = 0; i < dvdCount; i++){
            temp[i] = DVDs[i];
        }
        delete[] DVDs;
        DVDs = temp;
        DVDs[dvdCount] = DVD(serialNo, title, director);
    }
    std::cout << "DVD with serial number " << serialNo << " successfully added." << std::endl;
    dvdCount++;
}

void DVDStoreManagementSystem::removeDVD(const string serialNo) {
    int index = -1;
    for(int i = 0; i < dvdCount; i++){
        if(DVDs[i].serialNumber == serialNo){
            index = i;
            break;
        }
    }
    if(index == -1){
        std::cout << "Cannot remove DVD. DVD with serial number " << serialNo << " not found." << std::endl;
        return;
    }
    else if(!DVDs[index].available){
        std::cout << "Cannot remove DVD. DVD with serial number " << serialNo << " is currently rented by a customer." << std::endl;
        return;
    }
    else{
        DVD* temp = new DVD[dvdCount-1];
        int indexCount = 0;
        for(int i = 0; i < dvdCount; i++){
            if(i != index){
                temp[indexCount] = DVDs[i];
                indexCount++;
            }
        }
        delete[] DVDs;
        DVDs = temp;
    }
    std::cout << "DVD with serial number " << serialNo << " successfully removed." << std::endl;
    dvdCount--;
}

void DVDStoreManagementSystem::addCustomer(const int customerID, const string name) {
    if(customerCount == 0){
        customers = new Customer[1];
        customers[0] = Customer(customerID, name);
    }
    else{
        for(int i = 0; i < customerCount; i++){
            if(customers[i].customerID == customerID){
                std::cout << "Cannot add customer. Customer with ID " << customerID << " already exists." << std::endl;
                return;
            }
        }
        Customer* temp = new Customer[customerCount+1];
        for(int i = 0; i < customerCount; i++){
            temp[i] = customers[i];
        }
        delete[] customers;
        customers = temp;
        customers[customerCount] = Customer(customerID,name);
    }
    std::cout << "Customer with ID " << customerID << " successfully added." << std::endl;
    customerCount++;
}

void DVDStoreManagementSystem::removeCustomer(const int customerID) {
    int index = -1;
    for(int i = 0; i < customerCount; i++){
        if(customers[i].customerID == customerID){
            index = i;
            break;
        }
    }
    if(index == -1){
        std::cout << "Cannot remove customer. Customer with ID " << customerID << " not found." << std::endl;
        return;
    }
    else if(customers[index].rentedDVDCount != 0){
        std::cout << "Cannot remove customer. Customer with ID " << customerID << " has rented DVDs." << std::endl;
        return;
    }
    else{
        Customer* temp = new Customer[customerCount-1];
        int indexCount = 0;
        for(int i = 0; i < customerCount; i++){
            if(i != index){
                temp[indexCount] = customers[i];
                indexCount++;
            }
        }
        delete[] customers;
        customers = temp;
    }
    std::cout << "Customer with ID " << customerID << " successfully removed." << std::endl;
    customerCount--;
}

void DVDStoreManagementSystem::rentDVD(const int customerID, const string serialNo) {
    int customerIndex = -1;
    int dvdIndex = -1;
    for(int i = 0; i < customerCount; i++){
        if(customers[i].customerID == customerID){
            customerIndex = i;
            break;
        }
    }
    for(int i = 0; i < dvdCount; i++){
        if(DVDs[i].serialNumber == serialNo){
            dvdIndex = i;
            break;
        }
    }
    if(customerIndex == -1 && dvdIndex == -1){
        std::cout << "Cannot rent DVD. Customer with ID " << customerID << " and DVD with serial number " << serialNo << " not found." << std::endl;
        return;
    }
    else if(customerIndex == -1){
        std::cout << "Cannot rent DVD. Customer with ID " << customerID << " not found." << std::endl;
        return;
    }
    else if(dvdIndex == -1){
        std::cout << "Cannot rent DVD. DVD with serial number " << serialNo << " not found." << std::endl;
        return;
    }
    else if(!DVDs[dvdIndex].available){
        std::cout << "Cannot rent DVD. DVD with serial number " << serialNo << " is not available." << std::endl;
        return;
    }
    else{
        DVDs[dvdIndex].available = false;
        DVDs[dvdIndex].renterID = customers[customerIndex].customerID;
        customers[customerIndex].rentedDVDCount++;
        std::cout << "DVD with serial number " << serialNo << " successfully rented by customer with ID " << customerID << "." << std::endl;
        if(transactionCount == 0){
            transactions = new Transaction[1];
            transactions[0] = Transaction(serialNo, customerID, "Rental");
        }
        else{
            Transaction* temp = new Transaction[transactionCount+1];
            for(int i = 0; i < transactionCount; i++){
                temp[i] = transactions[i];
            }
            delete[] transactions;
            transactions = temp;
            transactions[transactionCount] = Transaction(serialNo, customerID, "Rental");
        }
        transactionCount++;
    }
}

void DVDStoreManagementSystem::returnDVD(const int customerID, const string serialNo) {
    int customerIndex = -1;
    int dvdIndex = -1;
    for(int i = 0; i < customerCount; i++){
        if(customers[i].customerID == customerID){
            customerIndex = i;
            break;
        }
    }
    for(int i = 0; i < dvdCount; i++){
        if(DVDs[i].serialNumber == serialNo){
            dvdIndex = i;
            break;
        }
    }
    if(customerIndex == -1 && dvdIndex == -1){
        std::cout << "Cannot return DVD. Customer with ID " << customerID << " and DVD with serial number " << serialNo << " not found." << std::endl;
        return;
    }
    else if(customerIndex == -1){
        std::cout << "Cannot return DVD. Customer with ID " << customerID << " not found." << std::endl;
        return;
    }
    else if(dvdIndex == -1){
        std::cout << "Cannot return DVD. DVD with serial number " << serialNo << " not found." << std::endl;
        return;
    }
    else if(DVDs[dvdIndex].renterID != customerID){
        std::cout << "Cannot return DVD. DVD with serial number " << serialNo << " not rented by customer with ID " << customerID << "." << std::endl;
        return;
    }
    else{
        DVDs[dvdIndex].available = true;
        DVDs[dvdIndex].renterID = -1;
        customers[customerIndex].rentedDVDCount--;
        std::cout << "DVD with serial number " << serialNo << " successfully returned by customer with ID " << customerID << "." << std::endl;
        if(transactionCount == 0){
            transactions = new Transaction[1];
            transactions[0] = Transaction(serialNo, customerID, "Return");
        }
        else{
            Transaction* temp = new Transaction[transactionCount+1];
            for(int i = 0; i < transactionCount; i++){
                temp[i] = transactions[i];
            }
            delete[] transactions;
            transactions = temp;
            transactions[transactionCount] = Transaction(serialNo, customerID, "Return");
        }
        transactionCount++;
    }
}

void DVDStoreManagementSystem::showAllDVDs() const {
    std::cout << "DVDs in the system:" << std::endl;
    if(dvdCount == 0){
        std::cout << "None" << std::endl;
    }
    else{
        for(int i = 0; i < dvdCount; i++){
            DVD& temp = DVDs[i];
            std::string availability;
            if(temp.available){
                availability = "Available";
            }
            else{
                availability = "Rented";
            }
            std::cout << "DVD: " << temp.serialNumber << ", Title: " << temp.title << ", Director: " << temp.director << ", " << availability << std::endl;
        }
    }
}

void DVDStoreManagementSystem::showAllCustomers() const {
    std::cout << "Customers in the system:" << std::endl;
    if(customerCount == 0){
        std::cout << "None" << std::endl;
    }
    else{
        for(int i = 0; i < customerCount; i++){
            Customer& temp = customers[i];
            std::cout << "Customer: " << temp.customerID << ", Name: " << temp.name << ", DVDs Rented: " << temp.rentedDVDCount << std::endl;
        }
    }

}

void DVDStoreManagementSystem::showDVD(const string serialNo) const {
    int index = -1;
    for(int i = 0; i < dvdCount; i++){
        if(DVDs[i].serialNumber == serialNo){
            index = i;
            break;
        }
    }
    if(index == -1){
        std::cout << "DVD with serial number " << serialNo << " not found." << std::endl;
    }
    else{
        DVD& temp = DVDs[index];
        std::string availability;
        if(temp.available){
            availability = "Available";
        }
        else{
            availability = "Rented";
        }
        std::cout << "DVD: " << temp.serialNumber << ", Title: " << temp.title << ", Director: " << temp.director << ", " << availability << std::endl;
    }
}

void DVDStoreManagementSystem::showCustomer(const int customerID) const {
    int index = -1;
    for(int i = 0; i < customerCount; i++){
        if(customers[i].customerID == customerID){
            index = i;
            break;
        }
    }
    if(index == -1){
        std::cout << "Customer with ID " << customerID << " not found." << std::endl;
    }
    else{
        Customer& temp = customers[index];
        std::cout << "Customer: " << temp.customerID << ", Name: " << temp.name << ", DVDs Rented: " << temp.rentedDVDCount << std::endl;
    }
}

void DVDStoreManagementSystem::showTransactionHistory() const {
    std::cout << "Transactions in the system:" << std::endl;
    if(transactionCount == 0){
        std::cout << "None" << std::endl;
    }
    else{
        for(int i = 0; i < transactionCount; i++){
            std::cout << "Transaction: " << transactions[i].transactionType << ", Customer: " << transactions[i].customerID << ", DVD: " << transactions[i].serialNo << std::endl;
        }
    }
}
