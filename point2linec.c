#include "math.h"
#include "modulusc.h"
#include <stdio.h>
void point2linec(double (*A),double (*P1), double (*P2),double (*M))
{
    int n=3;// number of dimentions
    int i;
	double a[3],b[3], t;
    for (i=0;i<n;i++){
        a[i] = P2[i]-P1[i];
//         *(a+i) = *(P2+i)-*(P1+i);
        b[i] = a[i]*(A[i]-P1[i]);
    }
    
t = sum_a(b,n)/(pow(modulusc(a),2));

    for (i=0;i<n;i++)
         M[i] = P1[i]+a[i]*t;
//          *(M+i) = *(P2+i)-*(P1+i);
}
