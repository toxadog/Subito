double dotprodc(double (*P1), double (*P2))
{
    int i,n=3;// number of dimentions
    double dot=0;
    for (i=0;i<n;i++){
        dot = dot + P1[i]*P2[i];
    }
    return(dot);
}
