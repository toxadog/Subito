#include "math.h"
double modulusc(double (*X)){
    double modulus;
    modulus = sqrt((pow(X[0],2.0))+(pow(X[1],2.0))+(pow(X[2],2.0)));
    return modulus;
}