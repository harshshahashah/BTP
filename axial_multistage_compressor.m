%Constant Tip Radius
%Radii are in mm
%Pressure is in bar
%Temperature is in Kelvin



T0 = [288];
P0 = [1.01];
U_tip = 350;
C_a = 150;
prompt = "Enter overall pressure ratio : ";
pr_total = input(prompt);
prompt = "Enter Centrifugal Compressor Ratio : ";
pr_centrifugal = input(prompt);
pr_axial = pr_total/pr_centrifugal;
T = [276.75];
P = [0.879];
prompt = "Enter rotational speed : ";
N = input(prompt);
r_tip = 1000*3342.253805/N;
pho = [1.107];
mf = 1.5;
Area = [9028.404472];
pr = [];

%Inlet dimensions 
r_root = [36.35];
r_mean = [50.56];
U_mean = [];

%For outlet dimensions
P_02 = 1.01*pr_axial;
T_02 = 288*(pr_axial^0.286);
T_2 = T_02 - (C_a^2/2000);
P_2 = P_02*((T_2/T_02)^3.5);
pho_2 = (100*P_02)/(0.287*T_2);
Area_2 = mf/(pho_2*150);
r_root_2 = sqrt((r_tip^2)-((Area_2*1000000)/(pi)));
fprintf("Outlet root radius : %f\n",r_root_2);
delta_temp = T_02-276.75;
delta_T_stage = delta_temp/6;
R = 0.5; %Rate of reaction is assumed to be 0.5 in all stages
alpha1 = [];
beta1 = [];
alpha2 = [];
beta2 = [];

for i = 1:6
    pr(i) = (1+(delta_T_stage/T0(i)))^3.5;
    P0(i+1) = P0(i)*pr(i);
    T0(i+1) = T0(i)+delta_T_stage;
    T(i+1) = T0(i+1)-(C_a^2/2000);
    P(i+1) = P0(i+1)*((T(i+1)/T0(i+1))^3.5);
    pho(i+1) = (100*P(i+1))/(0.287*T(i+1));
    Area(i+1) = (mf/(pho(i+1)*C_a))*1000000;
    r_root(i+1) = sqrt((r_tip^2)-(Area(i+1)/pi));
    r_mean(i+1) = (r_tip+r_root(i+1))/2;
    U_mean(i) = ((pi*2*r_mean(i+1)*N)/60)/1000;
    if i<4
        wf = 0.98-(i*0.05);
    else
        wf = 0.83;
    end
    sub = (delta_T_stage*1000)/(wf*U_mean(i)*C_a);
    add = (R*2*U_mean(i))/C_a;
    tan_beta1 = (add+sub)/2;
    tan_beta2 = tan_beta1-sub;
    beta1_rad = atan(tan_beta1);
    beta1(i) = rad2deg(beta1_rad);
    alpha2(i) = beta1(i);
    beta2_rad = atan(tan_beta2);
    beta2(i) = rad2deg(beta2_rad);
    alpha1(i) = beta2(i);
    fprintf("========================================================================== STAGE %d ==========================================================================\n",i)
    fprintf("Pressure Ratio : %f\n",pr(i));
    fprintf("Inlet Temperature : %f\n",T0(i));
    fprintf("Inlet Pressure : %f\n",P0(i));
    fprintf("Outlet Temperature : %f\n",T0(i+1));
    fprintf("Outlet Pressure : %f\n",P0(i+1));
    fprintf("Root Radius : %f\n",r_root(i+1));
    fprintf("Mean Radius : %f\n",r_mean(i+1));
    fprintf("Tip Radius : %f\n",r_tip);
    fprintf("Mean Speed : %f\n",U_mean(i));
    fprintf("Alpha-1 : %f\n",alpha1(i));
    fprintf("Beta-1 : %f\n",beta1(i));
    fprintf("Alpha-2 : %f\n",alpha2(i));
    fprintf("Beta-2 : %f\n",beta2(i));
end


