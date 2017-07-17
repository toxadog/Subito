#include "mex.h"
#include "math.h"
#include "pushoutc.h"
#include "modulusc.h"
#include <stdio.h>
void gradc(double (*PointsPnt), int(*N), double(*L),double(*F),double (*k),double(*hand),double(*bonepoints), int m,int n)
{
    int i,j,counter,MaxIter;
    MaxIter=10000;
    double dp=0.01;
    double P1[3],P2[3],Pen1,Pen2,shift1[3],shift2[3];
    double alpha=1;
    for (counter=0;counter<MaxIter;counter++){ //number of iterations
        for (i=4;i<m;i++){//a loop for all points exept the fixed points
            int NNeig=0;
            for (j=0;j<15;j++){
//             printf("%d", *(N+i+j*m));
                if (*(N+i+j*m)!=0){
                    NNeig=j+1;
                }
            }
            if (NNeig!=0)   {//if a point has at least one neighbour
                double Neighbours[15][3];
			    double D1[15];//an array of distances from the current point and its neighbours
			    double D2[15];//an array of distances from the current point and its neighbours
			    double Pdepl1[3][3]={0,0,0};//a current point deplaced in positive directio along all axes
                double Pdepl2[3][3]={0,0,0};//a current point deplaced in positive directio along all axes
                int counter1,counter2,counter3;
                for (counter1=0;counter1<NNeig;counter1++)
                    for (counter2=0;counter2<n;counter2++)
                        Neighbours[counter1][counter2]=*(PointsPnt+*(N+i+counter1*m)-1+counter2*m);//fill the neighbours
                for (counter1=0;counter1<n;counter1++){//for all coordiantes
                    for (counter2=0;counter2<n;counter2++) {
                        Pdepl1[counter1][counter2]=*(PointsPnt+i+counter2*m);
                        
                        Pdepl2[counter1][counter2]=*(PointsPnt+i+counter2*m);
                        if (counter1==counter2){
                            Pdepl1[counter1][counter2]=Pdepl1[counter1][counter2]+dp;
                            Pdepl2[counter1][counter2]=Pdepl2[counter1][counter2]-dp;
                        }
//                         printf("%f", Pdepl1[counter1][counter2]);
                    }
//                     printf("\n");
                    double E1=0;
                    double E2=0;
//                     printf("%d \n", NNeig);
                    for (counter2=0;counter2<NNeig;counter2++) {
                        D1[counter2] = sqrt((pow(Neighbours[counter2][0]- Pdepl1[counter1][0],2.0))+(pow(Neighbours[counter2][1]- Pdepl1[counter1][1],2.0))+(pow(Neighbours[counter2][2]- Pdepl1[counter1][2],2.0)))-*(L+i+counter2*m);
//                         printf("%f ", D1[counter2]);
                        if (D1[counter2]<0)
                            D1[counter2]=0;
                        D2[counter2] = sqrt((pow(Neighbours[counter2][0]- Pdepl2[counter1][0],2.0))+(pow(Neighbours[counter2][1]- Pdepl2[counter1][1],2.0))+(pow(Neighbours[counter2][2]- Pdepl2[counter1][2],2.0)))-*(L+i+counter2*m);
                        if (D2[counter2]<0)
                            D2[counter2]=0;
//                          E1=E1+ pow(D1[counter2]/1000,2.0)*(*k)/2-*(F+i+counter1*m)*dp/1000;
//                         E2=E2+ pow(D2[counter2]/1000,2.0)*(*k)/2+*(F+i+counter1*m)*dp/1000;
                        for (counter3=0;counter3<n;counter3++){
                             *(P1+counter3)=Pdepl1[counter1][counter3];
                             *(P2+counter3)=Pdepl2[counter1][counter3];
                        }
                        pushoutc(P1,hand,bonepoints);
                        pushoutc(P2,hand,bonepoints);
                        for (counter3=0;counter3<n;counter3++){
                             *(shift1+counter3)=*(P1+counter3)-Pdepl1[counter1][counter3];
                             *(shift2+counter3)=*(P2+counter3)-Pdepl2[counter1][counter3];
//                              
                        }
                        Pen1=modulusc(shift1);
                        Pen2=modulusc(shift2);
//                         printf("%f \n",Pen1);
                        E1=E1+ pow(D1[counter2]/1000,2.0)*(*k)/2-*(F+i+counter1*m)*dp/1000+pow(Pen1/1000,2.0)*(*k)/2;
                        E2=E2+ pow(D2[counter2]/1000,2.0)*(*k)/2+*(F+i+counter1*m)*dp/1000+pow(Pen2/1000,2.0)*(*k)/2;
                    }
//                    
                    *(PointsPnt+i+counter1*m)=*(PointsPnt+i+counter1*m)-alpha*(E1-E2)/(2*dp);
                }                
            }
        }
    }
}





void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *PointsPnt,*L,*F,*k1, *pind, *hand,*bonepoints;
    int* N;
    PointsPnt = mxGetPr(prhs[0]);
    //N must in int32 format
    N=(int*) mxGetData(prhs[1]);
    L = mxGetPr(prhs[2]);
    F = mxGetPr(prhs[3]);
    k1 = mxGetPr(prhs[4]);
    hand = mxGetPr(prhs[5]);
    bonepoints = mxGetPr(prhs[6]);
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
    gradc(pind,N,L,F,k1,hand,bonepoints,m,n);
}