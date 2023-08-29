import math

pressure_ratio_a = 1.164
for i in range(1,7):
    a_a = pow(pressure_ratio_a,i)
    b_a = pow(a_a,0.286)
    c_a = math.sqrt(b_a - 1)
    d2_a = (782.4608/2701.7697)*c_a
    N2_a = 2701.7697*d2_a
    print("The diameter of ",i," stage is : ",d2_a)
    print("The speed of ",i," stage is : ",N2_a)

pressure_ratio_c = 1.578
a_c = pow(pressure_ratio_c, 0.286)
b_c = math.sqrt(a_c - 1)
d2_c = (782.4608/2701.7697)*b_c
N2_c = 2701.7697*d2_c
print("The diameter of cetrifugal compressor is : ",d2_c)
print("The speed of centrifugal compressor is : ",N2_c)
