#include "mex.h"
#include "math.h"
#include <stdio.h>
void constrc(double (*PointsPnt), int(*N), double(*L),int m,int n)
{
    int i,j,counter,MaxIter;
    MaxIter=10000;
    for (counter=0;counter<MaxIter;counter++){
    for (i=4;i<m;i++){
        int NNeig=0;
        for (j=0;j<15;j++){
//             printf("%d", *(N+i+j*m));
            if (*(N+i+j*m)!=0)		{
// 					printf("%d", *(N+i+j*m));
                NNeig=j+1;
            }   
        }
//         printf("%d", NNeig);
        if (NNeig!=0)   {
            double Neighbours[15][3];
			double D1[15][3];
			double D2[15];
			double D3[15];
			double Pdepl[3]={0,0,0};
            int counter1,counter2;
            for (counter1=0;counter1<NNeig;counter1++)
                for (counter2=0;counter2<n;counter2++)
                    Neighbours[counter1][counter2]=*(PointsPnt+*(N+i+counter1*m)-1+counter2*m);
            int NPos=0;
            for (counter1=0;counter1<NNeig;counter1++){
                for (counter2=0;counter2<n;counter2++)
                    D1[counter1][counter2]=Neighbours[counter1][counter2]-*(PointsPnt+i+counter2*m);      
                D2[counter1]=sqrt((pow(D1[counter1][0],2.0))+(pow(D1[counter1][1],2.0))+(pow(D1[counter1][2],2.0)));
                D3[counter1]=(D2[counter1]-*(L+i+counter1*m))/D2[counter1];
                if (D3[counter1]>0){
                    NPos++;
                    for (counter2=0;counter2<n;counter2++)
                    Pdepl[counter2]=Pdepl[counter2]+D1[counter1][counter2]*D3[counter1]*0.5;
                    
                    }
            }
            if (NPos!=0)
            for (counter2=0;counter2<n;counter2++)
                *(PointsPnt+i+counter2*m)=*(PointsPnt+i+counter2*m)+Pdepl[counter2]/NPos;
//             printf("%d", NPos);

        }
    }
}
    
    
// 			{
//         printf("%d", NNeig);

}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *PointsPnt,*L, *pind;
    int* N;
    PointsPnt = mxGetPr(prhs[0]);
    //N must in int32 format
    N=(int*) mxGetData(prhs[1]);
    L = mxGetPr(prhs[2]);
    //Number of dimentions
    int n = mxGetN(prhs[0]);
    //Number of points
    int m = mxGetM(prhs[0]);
//     printf("%d", m);
//     input2 = mxGetPr(prhs[1]);
    plhs[0] = mxCreateDoubleMatrix(m, n, mxREAL);
    pind=mxGetPr(plhs[0]);
    int k;
    for (k=0;k<m*n;k++){
        pind[k]=*(PointsPnt+k);
    }
    constrc(pind,N,L,m,n);
}

// double constest(double Points[10][3],int N[10][15],double L[10][15])
// {
// 	int nel=10;
// 	for (int i=4;i<nel;i++)
// 	{
// 		int NNeig=0;
// 			for (int j=0;j<14;j++)
// 			{
// 				if (N[i][j]!=0)
// 				{
// 					NNeig=j+1;
// 				}
// 			}
// 			if (NNeig!=0)
// 			{
// 				double Neighbours[15][3];
// 				double D1[15][3];
// 				double D2[15];
// 				double D3[15];
// 				double Pdepl[3]={0,0,0};
// 				for (int counter1=0;counter1<NNeig-1;counter1++)
// 				for (int counter2=0;counter2<2;counter2++)
// 					Neighbours[counter1][counter2]=Points[N[i][counter1]][counter2];
// 				int NPos=0;
// 				for (int counter1=0;counter1<NNeig-1;counter1++)
// 				{
// 					for (int counter2=0;counter2<2;counter2++)
// 						D1[counter1][counter2]=Neighbours[counter1][counter2]-Points[i][counter2];
// 					D2[counter1]=sqrt((pow(D1[counter1][1],2.0))+(pow(D1[counter1][2],2.0))+(pow(D1[counter1][3],2.0)));
// 					D3[counter1]=(D2[counter1]-L[i][counter1])/D2[counter1];
// 					
// 					if (D3[counter1]>0)
// 						for (int counter2=0;counter2<2;counter2++)
// 						{
// 							Pdepl[counter2]=Pdepl[counter2]+D1[counter1][counter2]*D3[counter1]*0.5;
// 							NPos=NPos+1;
// 						}
// 				}
// 				for (int counter2=0;counter2<2;counter2++)
// 				{
// 					Points[i][counter2]=Points[i][counter2]+Pdepl[counter2];
// 				}
// 
// 
// 
// 			}
// 	}
// 	return 0;
// }