#include "point2linec.h"
#include "math.h"
void pushoutc(double (*P),double (*hand),double (*bonepoints),double (*pulleys)){
    int n=3;
    double l1=*(hand);
    double l2=*(hand+1);
    double l3=*(hand+2);
    double l4=*(hand+3);
    double r1=*(hand+4);
    double r2=*(hand+5);
    double r3=*(hand+6);
    double r4=*(hand+7);
    double R1=*(hand+8);
    double R2=*(hand+9);
    double R3=*(hand+10);
    double P1[3]={*(bonepoints),*(bonepoints+1),*(bonepoints+2)};
    double P2[3]={*(bonepoints+n),*(bonepoints+1+n),*(bonepoints+2+n)};
    double P3[3]={*(bonepoints+2*n),*(bonepoints+1+2*n),*(bonepoints+2+2*n)};
    double P4[3]={*(bonepoints+3*n),*(bonepoints+1+3*n),*(bonepoints+2+3*n)};
    double P5[3]={*(bonepoints+4*n),*(bonepoints+1+4*n),*(bonepoints+2+4*n)};
    double C1[3]={*(bonepoints+5*n),*(bonepoints+1+5*n),*(bonepoints+2+5*n)};
    double C2[3]={*(bonepoints+6*n),*(bonepoints+1+6*n),*(bonepoints+2+6*n)};
    double C3[3]={*(bonepoints+7*n),*(bonepoints+1+7*n),*(bonepoints+2+7*n)};
    double C4[3]={*(bonepoints+8*n),*(bonepoints+1+8*n),*(bonepoints+2+8*n)};
    double C5[3]={*(bonepoints+9*n),*(bonepoints+1+9*n),*(bonepoints+2+9*n)};
    double C6[3]={*(bonepoints+10*n),*(bonepoints+1+10*n),*(bonepoints+2+10*n)};
    //number of pulleys must be customized 
    double pulleyR=2;
    double pulleyInt[2]={*(pulleys),*(pulleys+1)};
    double pulleyLu[2]={*(pulleys+2),*(pulleys+3)};
    double Pr1[3],Pr2[3],Pr3[3],Pr4[3],PrPul[3];
    point2linec(P,P1,P2,Pr1);
    point2linec(P,P2,P3,Pr2);
    point2linec(P,P3,P4,Pr3);
    point2linec(P,P4,P5,Pr4);
//     PointPnt[0]=dotprodc(P1,P2);
//     PointPnt[1]=dotprodc(P2,P3);
//     PointPnt[2]=dotprodc(P3,P4);

//     double temp1[3] = {P1[0]-Pr1[0],P1[1]-Pr1[1],P1[2]-Pr1[2]};
//     double temp2[3] = {C1[0]-Pr1[0],C1[1]-Pr1[1],C1[2]-Pr1[2]};
//     double temp3[3] = {P[0]-Pr1[0],P[1]-Pr1[1],P[2]-Pr1[2]};
    
    double temp1[3],temp2[3],temp3[3],temp4[3],temp5[3];
    minusc(P1,Pr1,temp1);
    minusc(C1,Pr1,temp2);
    minusc(P,Pr1,temp3);
    if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<r4)){
        P[0]=Pr1[0]+r4*temp3[0]/modulusc(temp3);
        P[1]=Pr1[1]+r4*temp3[1]/modulusc(temp3);
        P[2]=Pr1[2]+r4*temp3[2]/modulusc(temp3);
    }
    else {
        minusc(C1,Pr1,temp1);
        minusc(P2,Pr1,temp2);
        minusc(P,Pr1,temp3);
        minusc(Pr1,P2,temp4);
        minusc(P2,C1,temp5);
        if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<modulusc(temp4)*r4/modulusc(temp5))){
            P[0]=C1[0]+r4*temp3[0]/modulusc(temp3);
            P[1]=C1[1]+r4*temp3[1]/modulusc(temp3);
            P[2]=C1[2]+r4*temp3[2]/modulusc(temp3);  
        }
        else {
            minusc(C2,Pr2,temp1);
            minusc(C3,Pr2,temp2);
            minusc(P,Pr2,temp3);
            if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<r3)){
                P[0]=Pr2[0]+r3*temp3[0]/modulusc(temp3);
                P[1]=Pr2[1]+r3*temp3[1]/modulusc(temp3);
                P[2]=Pr2[2]+r3*temp3[2]/modulusc(temp3);
            }
            else {
                minusc(P2,Pr2,temp1);
                minusc(C2,Pr2,temp2);
                minusc(P,Pr2,temp3);
                minusc(Pr2,P2,temp4);
                minusc(P2,C2,temp5);
                if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<modulusc(temp4)*r3/modulusc(temp5))){
                    P[0]=C2[0]+r3*temp3[0]/modulusc(temp3);
                    P[1]=C2[1]+r3*temp3[1]/modulusc(temp3);
                    P[2]=C2[2]+r3*temp3[2]/modulusc(temp3);
                }
                else {
                    minusc(C3,Pr2,temp1);
                    minusc(P3,Pr2,temp2);
                    minusc(P,Pr2,temp3);
                    minusc(Pr2,P3,temp4);
                    minusc(P3,C3,temp5);
                    if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<modulusc(temp4)*r3/modulusc(temp5))){
                         P[0]=C3[0]+r3*temp3[0]/modulusc(temp3);
                         P[1]=C3[1]+r3*temp3[1]/modulusc(temp3);
                         P[2]=C3[2]+r3*temp3[2]/modulusc(temp3);
                    }
                    else {
                         minusc(C4,Pr3,temp1);
                         minusc(C5,Pr3,temp2);
                         minusc(P,Pr3,temp3);
                        if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<r2)){
                             P[0]=Pr3[0]+r2*temp3[0]/modulusc(temp3);
                             P[1]=Pr3[1]+r2*temp3[1]/modulusc(temp3);
                             P[2]=Pr3[2]+r2*temp3[2]/modulusc(temp3);
                        }
                        else{
                             minusc(P3,Pr3,temp1);
                             minusc(C4,Pr3,temp2);
                             minusc(P,Pr3,temp3);
                             minusc(Pr3,P3,temp4);
                             minusc(P3,C4,temp5);
                             if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<modulusc(temp4)*r2/modulusc(temp5))){
                                  P[0]=C4[0]+r2*temp3[0]/modulusc(temp3);
                                  P[1]=C4[1]+r2*temp3[1]/modulusc(temp3);
                                  P[2]=C4[2]+r2*temp3[2]/modulusc(temp3);
                             }
                             else {
                                 minusc(C5,Pr3,temp1);
                                 minusc(P4,Pr3,temp2);
                                 minusc(P,Pr3,temp3);
                                 minusc(Pr3,P4,temp4);
                                 minusc(P4,C5,temp5);
                                 if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<modulusc(temp4)*r2/modulusc(temp5))){
                                      P[0]=C5[0]+r2*temp3[0]/modulusc(temp3);
                                      P[1]=C5[1]+r2*temp3[1]/modulusc(temp3);
                                      P[2]=C5[2]+r2*temp3[2]/modulusc(temp3);
                                 }
                                 else {
                                     minusc(C6,Pr4,temp1);
                                     minusc(P5,Pr4,temp2);
                                     minusc(P,Pr4,temp3);
                                     if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<r1)){
                                         P[0]=Pr4[0]+r1*temp3[0]/modulusc(temp3);
                                         P[1]=Pr4[1]+r1*temp3[1]/modulusc(temp3);
                                         P[2]=Pr4[2]+r1*temp3[2]/modulusc(temp3);
                                     }
                                     else {
                                         minusc(P4,Pr4,temp1);
                                         minusc(C6,Pr4,temp2);
                                         minusc(P,Pr4,temp3);
                                         minusc(Pr4,P4,temp4);
                                         minusc(P4,C6,temp5);
                                         if ((dotprodc(temp1,temp2)<0)&&(modulusc(temp3)<modulusc(temp4)*r1/modulusc(temp5))){
                                             P[0]=C6[0]+r1*temp3[0]/modulusc(temp3);
                                             P[1]=C6[1]+r1*temp3[1]/modulusc(temp3);
                                             P[2]=C6[2]+r1*temp3[2]/modulusc(temp3);
                                         }
                                         else {
                                             minusc(P,P2,temp1);
                                             if (modulusc(temp1)<R3){
                                                 P[0]=P2[0]+R3*temp1[0]/modulusc(temp1);
                                                 P[1]=P2[1]+R3*temp1[1]/modulusc(temp1);
                                                 P[2]=P2[2]+R3*temp1[2]/modulusc(temp1);
                                             }
                                             else{
                                                 minusc(P,P3,temp1);
                                                 if (modulusc(temp1)<R2){
                                                      P[0]=P3[0]+R2*temp1[0]/modulusc(temp1);
                                                      P[1]=P3[1]+R2*temp1[1]/modulusc(temp1);
                                                      P[2]=P3[2]+R2*temp1[2]/modulusc(temp1);
                                                 }
                                                 else{
                                                     minusc(P,P4,temp1);
                                                     if (modulusc(temp1)<R1){
                                                         P[0]=P4[0]+R1*temp1[0]/modulusc(temp1);
                                                         P[1]=P4[1]+R1*temp1[1]/modulusc(temp1);
                                                         P[2]=P4[2]+R1*temp1[2]/modulusc(temp1);
                                                     }
                                                     else{
                                                         //pulleys
                                                         temp1[0]=0;
                                                         temp1[1]=P[1]-pulleyInt[0];
                                                         temp1[2]=P[2]-pulleyInt[1];
                                                         if (10<pulleyR){
                                                             double Pleft[3]={-100,pulleyInt[0],pulleyInt[1]};
                                                             double Pright[3]={100,pulleyInt[0],pulleyInt[1]};
                                                             point2linec(P,Pleft,Pright,PrPul);
                                                             P[1]=PrPul[1]+pulleyR*temp1[1]/modulusc(temp1);
                                                             P[2]=PrPul[2]+pulleyR*temp1[2]/modulusc(temp1);
                                                         }
                                                         else {
                                                             temp1[0]=0;
                                                             temp1[1]=P[1]-pulleyLu[0];
                                                             temp1[2]=P[2]-pulleyLu[1];
                                                             if (modulusc(temp1)<pulleyR){
                                                                 double Pleft[3]={-100,pulleyLu[0],pulleyLu[1]};
                                                                 double Pright[3]={100,pulleyLu[0],pulleyLu[1]};
                                                                 point2linec(P,Pleft,Pright,PrPul);
                                                                 P[1]=PrPul[1]+pulleyR*temp1[1]/modulusc(temp1);
                                                                 P[2]=PrPul[2]+pulleyR*temp1[2]/modulusc(temp1);
                                                             }
                                                             else
                                                             {
                                                             }
                                                         }                                                         
                                                     }
                                                 }
                                             }
                                         }
                                     }
                                 }
                             }
                        }
                    }
                }
            }
        }
    }
}