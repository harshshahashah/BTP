import math

Ca = 150
pho = []
r_t = 64.77
m = 1.5
Area = []
pressure_ratio = [1.185, 1.176, 1.168, 1.16, 1.15, 1.151]
P0 = [1.01, 1.197, 1.408, 1.644, 1.907, 2.19, 2.52]
P = []
T0 = [288, 302.365, 316.73, 331.095, 345.46, 359.825, 374.575]
T = []
h = []
r_root = []
r_mean = []
U_mean = []

print("Stagnation Temperature values : ",T0)
print("Stagnation Pressure values : ",P0)

#Calculating Temperature
for i in range (0,7):
    T.append(T0[i]-(pow(Ca,2)/2000))
print("Temperature values : ",T)

#Calculating Pressure
for j in range (0,7):
    P.append(P0[j]*(pow(T[j]/T0[j],3.5)))
print("Pressure values : ",P)

#Calculating Density
for k in range (0,7):
    pho.append((100*P[k])/(0.287*T[k]))
print("Density values : ",pho)

#Calculating Area
for l in range (0,7):
    Area.append((m/(pho[l]*Ca))*1000000)
print("Area (in sq.mm) : ",Area)

#Calculating Root Radius
for n in range (0,7):
    z = m/(pho[n]*math.pi*Ca)
    z1 = pow(r_t/1000,2)-z
    r_root.append(math.sqrt(z1)*1000)
print("Root Radius (in mm) : ",r_root)

#Calculating Mean Radius
for p in range (0,7):
    r_mean.append((r_t+r_root[p])/2)
print("Mean Radius (in mm) : ",r_mean)

#Calculating Mean Speed
for q in range (0,7):
    U_mean.append((2*math.pi*r_mean[q]*51600)/(60000))
print("Mean Speed : ",U_mean)


