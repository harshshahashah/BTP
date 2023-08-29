
xs = [];
ys = [];
xp = [];
yp = [];
xc = [];
yc = []; 
beta1 = 0; 
beta2 = 0; 
beta3 = 0; 
beta4 = 0; 
beta5 = 0; 
x1 = 0; 
x2 = 0; 
x3 = 0; 
x4 = 0; 
x5 = 0; 
x6 = 0; 
x7 = 0; 
x8 = 0; 
x9 = 0; 
y1 = 0; 
y2 = 0; 
y3 = 0; 
y4 = 0; 
y5 = 0; 
y6 = 0; 
y7 = 0; 
y8 = 0; 
y9 = 0; 
R0 = 0; 
yy2 = 0; 
temp = 0; 
dxp = 0; 
dxs = 0; 
As = 0; 
Bs = 0; 
Cs = 0; 
Ds = 0; 
Ap = 0; 
Bp = 0; 
Cp = 0; 
Dp = 0;
Iter = false;
fprintf("ENTER LENGTHS IN MM AND ANGLES IN DEGREES\n")
prompt = "Enter number of airfoils to be generated : ";
N = input(prompt);
prompt = "Enter number of blades : ";
Nb = input(prompt);
for i = 1:N
    Iter = false;
    prompt = "Enter Radius of airfoil design cylinder : ";
    R = input(prompt);
    prompt = "Enter axial chord length : ";
    Cx = input(prompt);
    prompt = "Enter tangential chord length : ";
    Ct = input(prompt);
    prompt = "Enter throat : ";
    throat = input(prompt);
    prompt = "Enter unguided turning  : ";
    UGT = input(prompt);
    prompt = "Enter inlet blade angle : ";
    beta_in = input(prompt);
    prompt = "Enter inlet wedge angle : ";
    wedge_in = input(prompt);
    prompt = "Enter radius of leading edge : ";
    RLE = input(prompt);
    prompt = "Enter outlet blade angle : ";
    beta_out = input(prompt);
    prompt = "Enter radius of trailing edge : ";
    RTE = input(prompt);
    prompt = "Enter scaling factor : ";
    fact = input(prompt);

    ! Default Values 
    if RLE >= 2
        RLE = (RLE/100)*2*pi*(R/Nb)*cos(beta_in*pi/180)/2;
    end
    if RTE >= 2
        RTE = (RTE/100)*2*pi*(R/Nb)*cos(beta_out*pi/180)/2;
    end
    if Cx < 0
        Cx = 4*pi*(R/Nb)*sin((beta_in-beta_out)*pi/180)*cos(beta_out*pi/180)/cos(beta_in*pi/180);
    end
    if throat <= 0
        throat = (2*pi*(R/Nb)*cos(beta_out*pi/180)) - (2*RTE);
    end
    if UGT < 0
        UGT = 0.0001;
    end
    wedge_out = UGT/2;
    if Ct < 20
        if Ct >= 4
            Iter = true;
            TTC = Ct/100;
            Ct = 0;
        end
    end
    Ct = Cx*tan(Ct*pi/180);

    ! key points of interest along the blade 
    beta1 = beta_out - wedge_out;
    x1 = (Cx) - (RTE*(1+(sin(beta1*pi/180))));
    y1 = RTE*cos(beta1*pi/180);
    beta2 = beta_out - wedge_out + UGT;
    x2 = Cx - RTE + (throat+RTE)*sin(beta2*pi/180);
    y2 = (2*pi*(R/Nb)) - ((throat+RTE)*cos(beta2*pi/180));
    beta3 = beta_in + wedge_in;
    x3 = RLE*(1-sin(beta3*pi/180));
    if Ct == 0
        Ct = (y2) + ((180/pi)*((x2-x3)/(beta2-beta3))*log(cos(beta2*pi/180)/cos(beta3*pi/180))) - (RLE*cos(beta3*pi/180));
    end
    y3 = Ct + (RLE*cos(beta3*pi/180));
    beta4 = beta_in - wedge_in;
    x4 = RLE*(sin(beta4*pi/180)+1);
    y4 = Ct - (RLE*cos(beta4*pi/180));
    beta5 = beta_out + wedge_out;
    x5 = Cx - (RTE*(1-sin(beta5*pi/180)));
    y5 = -RTE*cos(beta5*pi/180);
    x6 = Cx;
    y6 = 0;
    x7 = Cx - RTE;
    y7 = 0;
    x8 = 0;
    y8 = Ct;
    x9 = RLE;
    y9 = Ct;
    Area = 0;

    ! Uncovered Turn Circle 
    x0 = ((y1-y2)*tan(beta1*pi/180)*tan(beta2*pi/180)+(x1*tan(beta2*pi/180))-(x2*tan(beta1*pi/180)))/(tan(beta2*pi/180)-tan(beta1*pi/180));
    y0 = y1 - ((x0-x1)/tan(beta1*pi/180));
    R0 = sqrt(power(x1-x0,2)+power(y1-y0,2));
    
    !Iteration on exit wedge angle to remove throat discontinuity
    yy2 = y0 + sqrt(power(R0,2)-power(x2-x0,2));
    if abs(y2-yy2)<0.00001
        ! using third order polynomial
        Ds = ((tan(beta2*pi/180)+tan(beta3*pi/180))/power(x2-x3,2)) - 2*((y2-y3)/power(x2-x3,2));
        Cs = ((y2-y3)/power(x2-x3,2)) - (tan(beta3*pi/180)/(x2-x3)) - Ds*(x2+(2*x3));
        Bs = tan(beta3*pi/180) - (2*Cs*x3) - (3*Ds*power(x3,2));
        As = y3 - (Bs*x3) - (Cs*power(x3,2)) - (Ds*power(x3,3));
        
        Dp = ((tan(beta4*pi/180)+tan(beta5*pi/180))/power(x4-x5,2)) - 2*((y4-y5)/power(x4-x5,2));
        Cp = ((y4-y5)/power(x4-x5,2)) - (tan(beta5*pi/180)/(x4-x5)) - Dp*(x4+(2*x5));
        Bp = tan(beta5*pi/180) - (2*Cp*x5) - (3*Dp*power(x5,2));
        Ap = y5 - (Bp*x5) - (Cp*power(x5,2)) - (Dp*power(x5,3));
    end
    temp = wedge_out;
    wedge_out = wedge_out*power(y2/yy2,4);
    if wedge_out>0.001
        wedge_out = temp;
        beta1 = beta_out - wedge_out;
        x1 = (Cx) - (RTE*(1+(sin(beta1*pi/180))));
        y1 = RTE*cos(beta1*pi/180);
        beta2 = beta_out - wedge_out + UGT;
        x2 = Cx - RTE + (throat+RTE)*sin(beta2*pi/180);
        y2 = (2*pi*(R/Nb)) - ((throat+RTE)*cos(beta2*pi/180));
        beta3 = beta_in + wedge_in;
        x3 = RLE*(1-sin(beta3*pi/180));
        if Ct == 0
            Ct = (y2) + ((180/pi)*((x2-x3)/(beta2-beta3))*log(cos(beta2*pi/180)/cos(beta3*pi/180))) - (RLE*cos(beta3*pi/180));
        end
        y3 = Ct + (RLE*cos(beta3*pi/180));
        beta4 = beta_in - wedge_in;
        x4 = RLE*(sin(beta4*pi/180)+1);
        y4 = Ct - (RLE*cos(beta4*pi/180));
        beta5 = beta_out + wedge_out;
        x5 = Cx - (RTE*(1-sin(beta5*pi/180)));
        y5 = -RTE*cos(beta5*pi/180);
        x6 = Cx;
        y6 = 0;
        x7 = Cx - RTE;
        y7 = 0;
        x8 = 0;
        y8 = Ct;
        x9 = RLE;
        y9 = Ct;
        Area = 0;
        fprintf("Exit wedge angle iteration failed, the exit wedge angle wants to go negative. Reduce the exit blade angle or decrease the throat");
    end
    
    ! Suction and Pressure Surface Definition (50 points per side)
    xs(1) = x8;
    ys(1) = y8;
    xp(1) = x8;
    yp(1) = y8;
    dxp = (x4-x8)/9;
    dxs = (x3-x8)/9;
    for j = 2:10
        xp(j) = xp(j-1)+dxp;
        yp(j) = y9 - sqrt(power(RLE,2)-power(xp(j)-x9,2));
        xs(j) = xs(j-1)+dxs;
        ys(j) = y9 + sqrt(power(RLE,2)-power(xs(j)-x9,2));
    end
    dxp = (x5-x4)/30;
    dxs = (x2-x3)/20;
    for k = 11:30
        xp(k) = xp(k-1)+dxp;
        yp(k) = Ap+(xp(k)*(Bp+(xp(k)*(Cp+(xp(k)*Dp)))));
        xs(k) = xs(k-1)+dxs;
        ys(k) = As+(xs(k)*(Bs+(xs(k)*(Cs+(xs(k)*Ds)))));
    end
    dxs = (x1-x2)/10;
    for l = 31:40
        xp(l) = xp(l-1)+dxp;
        yp(l) = Ap+(xp(l)*(Bp+(xp(l)*(Cp+(xp(l)*Dp)))));
        xs(l) = xs(l-1)+dxs;
        ys(l) = y0 + sqrt(power(R0,2)-power(xs(l)-x0,2));
    end
    dxp = (x6-x5)/10;
    dxs = (x6-x1)/10;
    for m = 41:50
        xp(m) = xp(m-1)+dxp;
        if xp(m)>Cx
            xp(m) = Cx;
        end
        yp(m) = y7 - sqrt(power(RTE,2)-power(xp(m)-x7,2));
        xs(m) = xs(m-1)+dxs;
        if xs(m)>Cx
            xs(m) = Cx;
        end
        ys(m) = y7 + sqrt(power(RTE,2)-power(xs(m)-x7,2));
    end
    xs(51) = 0;
    ys(51) = 0;
    xs(52) = 1/fact;
    ys(52) = 1/fact;
    xp(51) = 0;
    yp(51) = 0;
    xp(52) = 1/fact;
    yp(52) = 1/fact;
    x1
    y1
    x2
    y2
    x3
    y3
    x4
    y4
    x5
    y5
    
end






    
    






        



