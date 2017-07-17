#include "mex.h"
#include "pushoutc.h"
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *PointPnt,*hand,*bonepoints,  *pind;
    PointPnt = mxGetPr(prhs[0]);
    hand = mxGetPr(prhs[1]);
    bonepoints = mxGetPr(prhs[2]);
    double M[3];
//     plhs[0]=mxCreateDoubleScalar(modulusc(APnt));
    plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL);
//     point2linec(APnt,P1Pnt,P2Pnt,M);
    pind=mxGetPr(plhs[0]);
    int k;
    for (k=0;k<3;k++){
        pind[k]=*(PointPnt+k);
    }
    pushoutc(pind,hand,bonepoints);
}