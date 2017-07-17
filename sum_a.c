double sum_a(double (*N), int n)
{
	int i;
    double sum = 0;
    for (i = 0; i<n;  i++){
        sum = sum + N[i];
    }
    return(sum);
}