prompt = "Enter pitch circle diameter (in mm) : ";
D = input(prompt)/1000;
prompt = "Enter no. of bolts : ";
n = input(prompt);
prompt = "Enter shear strength of material (in MPa) : ";
tau = input(prompt)*1000000;
T = 43.75;
d1 = sqrt((8*T)/(pi*tau*D*n))*1000;
fprintf("Diameter of Pins (in mm) : %f",d1);