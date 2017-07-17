void minusc(double (*P1), double (*P2), double (*P3))
{
    int i,n=3;// number of dimentions
    double dot=0;
    for (i=0;i<n;i++){
        P3[i] = P1[i]-P2[i];
    }
}
