//Mustafa Mert Gülhan CS201-01 22201895

#include "DVD.h"

DVD::DVD(){
    this->renterID = -1;
}

DVD::DVD(const std::string &serialNumber, const std::string &title, const std::string &director) {
    this->serialNumber = serialNumber;
    this->director = director;
    this->title = title;
    this->available = true;
    this->renterID = -1;
}

