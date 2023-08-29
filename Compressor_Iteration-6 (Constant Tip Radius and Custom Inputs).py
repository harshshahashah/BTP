#Constant Tip Radius
#Radii are in mm
#Pressure is in bar
#Temperature is in Kelvin

import math

T0 = [288]
P0 = [1.01]
U_tip = 350
C_a = 150
pr_total = float(input("Enter overall pressure ratio : "))
pr_centrifugal = float(input("Enter Centrifugal Compressor Ratio : "))
pr_axial = pr_total/pr_centrifugal
T = [276.75]
P = [0.879]
N = float(input("Enter rotational speed : "))
r_tip = (3342.253805/N)*1000
pho = [1.107]
mf = 1.5
Area = [9028.404472]
pr = []

#Inlet dimensions 
r_root = [36.35]
r_mean = [50.56]
U_mean = []

#For outlet dimensions
P_02 = 1.01*pr_axial
T_02 = 288*(pow(pr_axial,0.286))
T_2 = T_02 - (pow(C_a,2)/2000)
P_2 = P_02*(pow(T_2/T_02,3.5))
pho_2 = (100*P_02)/(0.287*T_2)
Area_2 = mf/(pho_2*150)
r_root_2 = math.sqrt(pow(r_tip,2)-((Area_2*1000000)/(math.pi)))
print("Outlet root radius : ",r_root_2)
delta_temp = T_02 - 276.75
delta_T_stage = delta_temp/6
R = 0.5 #Rate of reaction is assumed to be 0.5 in all stages
alpha1 = []
beta1 = []
alpha2 = []
beta2 = []
def deg_to_rad(a):
    return (a*math.pi)/180

def rad_to_deg(b):
    return (b*180)/math.pi



for i in range (0,6):
    pr.append(pow(1+(delta_T_stage/T0[i]),3.5))
    P0.append(P0[i]*pr[i])
    T0.append(T0[i]+delta_T_stage)
    T.append(T0[i+1]-(pow(C_a,2)/2000))
    P.append(P0[i+1]*pow(T[i+1]/T0[i+1],3.5))
    pho.append((100*P[i+1])/(0.287*T[i+1]))
    Area.append((mf/(pho[i+1]*C_a))*1000000)
    r_root.append(math.sqrt(pow(r_tip,2)-(Area[i+1]/math.pi)))
    r_mean.append((r_tip+r_root[i+1])/2)
    U_mean.append(((math.pi*2*r_mean[i+1]*N)/60)/1000)
    if(i<4):
        wf = 0.98-(i*0.05)
    else:
        wf = 0.83
    sub = (delta_T_stage*1000)/(wf*U_mean[i]*C_a)
    add = (R*2*U_mean[i])/C_a
    tan_beta1 = (add+sub)/2
    tan_beta2 = tan_beta1-sub
    beta1_rad = math.atan(tan_beta1)
    beta1.append(rad_to_deg(beta1_rad))
    alpha2.append(beta1[i])
    beta2_rad = math.atan(tan_beta2)
    beta2.append(rad_to_deg(beta2_rad))
    alpha1.append(beta2[i])
    print("========================================================================== STAGE ",i+1," ==========================================================================")
    print("Pressure Ratio : ",pr[i])
    print("Inlet Temperature : ",T0[i])
    print("Inlet Pressure : ",P0[i])
    print("Outlet Temperature : ",T0[i+1])
    print("Outlet Pressure : ",P0[i+1])
    print("Root Radius : ",r_root[i+1])
    print("Mean Radius : ",r_mean[i+1])
    print("Tip Radius : ",r_tip)
    print("Mean Speed : ",U_mean[i])
    print("Alpha-1 : ",alpha1[i])
    print("Beta-1 : ",beta1[i])
    print("Alpha-2 : ",alpha2[i])
    print("Beta-2 : ",beta2[i])
print("Density : ",pho)

