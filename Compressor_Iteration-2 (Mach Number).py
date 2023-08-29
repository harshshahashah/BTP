import math

pressure_ratio = [1.19]
T0 = [321.6, 342.29]
P0 = [123.046, 146.423]
delta_T0 = 20.69
exp = 0.8/0.286
alpha1 = [0]
alpha2 = [18.42]
alpha3 = [11.644]
beta1 = [44.99]
beta2 = [33.69]
U_by_Ca = 1.008
U = 174.994
Ca = 175
DHr = pow(0.85, 2)

def deg_to_rad(a):
    return (a*math.pi)/180

def rad_to_deg(b):
    return (b*180)/math.pi

for i in range (2, 7):
    
    alpha1.append(alpha3[i-2])
    
    a1 = deg_to_rad(alpha1[i-1])
    tan_b1 = U/Ca - math.tan(a1)
    b1_rad = math.atan(tan_b1)
    b1 = rad_to_deg(b1_rad)
    beta1.append(b1)

    x = pow(tan_b1, 2) + 1
    y = (DHr*x) - 1
    z = math.sqrt(y)
    tan_b2 = z
    b2_rad = math.atan(tan_b2)
    b2 = rad_to_deg(b2_rad)
    beta2.append(b2)

    tan_a2 = U_by_Ca - tan_b2
    a2_rad = math.atan(tan_a2)
    a2 = rad_to_deg(a2_rad)
    alpha2.append(a2)

    DHs = math.cos(a2_rad) + 0.02
    cos_a3 = math.cos(a2_rad)/DHs
    a3_rad = math.acos(cos_a3)
    a3 = rad_to_deg(a3_rad)
    alpha3.append(a3)

    T0.append(T0[i-1]+delta_T0)
    t = T0[i]/T0[i-1]
    pressure_ratio.append(pow(t, exp))
    P0.append(P0[i-1]*pressure_ratio[i-1])                          
    print("=================================== STAGE ",i," ===================================")
    print("\tDelta Tos : ",delta_T0)
    print("\tPressure Ratio : ",pressure_ratio[i-1])
    print("\talpha-1 : ",alpha1[i-1])
    print("\tbeta-1 : ",beta1[i-1])
    print("\talpha-2 : ",alpha2[i-1])
    print("\tbeta-2 : ",beta2[i-1])
    print("\talpha-3 : ",alpha3[i-1])

print("T0 : ",T0)
print("P0 : ",P0)
T = []
P = [101.3]
pho = []
A = []
m = 1.5
W = []
dout = 0.12954
din = []


for x in T0:
    T.append(x - (pow(Ca,2)/2000))
print("T : ",T)

for j in range (1, 7):
    P.append(pow(T[j]/T[j-1],0.8/0.286)*P[j-1])
print("P : ",P)

for k in range (0, 6):
    pho.append((P[k+1]*1000)/(287*T[k+1]))
print("Density : ",pho)

for l in range (0, 6):
    W.append(1.75*math.sqrt(1.4*287*T[l+1]))
print("Relative Speed : ",W)

for n in range (0, 6):
    A.append(m/(pho[n]*W[n]))
print("Area : ",A)


    



    
    
    
    
