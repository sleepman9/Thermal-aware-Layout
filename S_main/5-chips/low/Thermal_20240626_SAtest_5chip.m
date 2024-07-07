function [T1,T2,T3,T4,T5] = Thermal_20240626_SAtest_5chip(X1,Y1,X2,Y2,X3,Y3,X4,Y4,X5,Y5,pcbL,pcbW,pcbH,...
                                                    L1,W1,H1,L2,W2,H2,L3,W3,H3,L4,W4,H4,L5,W5,H5,level)

model = mphopen('CHIP5-20240606-SAtest.mph');

model.param.set('CHIPX1', num2str(X1));
model.param.set('CHIPY1', num2str(Y1));
model.param.set('CHIPX2', num2str(X2));
model.param.set('CHIPY2', num2str(Y2));
model.param.set('CHIPX3', num2str(X3));
model.param.set('CHIPY3', num2str(Y3));
model.param.set('CHIPX4', num2str(X4));
model.param.set('CHIPY4', num2str(Y4));
model.param.set('CHIPX5', num2str(X5));
model.param.set('CHIPY5', num2str(Y5));


PCBL= pcbL;
PCBW =pcbW;
PCBH = pcbH;
CHIP1L1 = L1;
CHIP1W1 = W1;
CHIP1H1 = H1;

CHIP1L2 = L2;
CHIP1W2 = W2;
CHIP1H2 = H2;

CHIP1L3 = L3;
CHIP1W3 = W3;
CHIP1H3 = H3;

CHIP1L4 = L4;
CHIP1W4 = W4;
CHIP1H5 = H4;

CHIP1L5 = L5;
CHIP1W5 = W5;
CHIP1H5 = H5;



% CHIP1L7 = L7;
% CHIP1W7 = W7;
% CHIP1H7 = H7;


model.component('comp1').mesh('mesh1').feature('size').set('hauto', num2str(level));
model.component('comp1').mesh('mesh1').run;

model.sol('sol1').runAll;

model.result('pg1').run;

tabl = mphtable(model,'tbl1');
T1= tabl.data(1);
T2= tabl.data(2);
T3= tabl.data(3);
T4= tabl.data(4);
T5= tabl.data(5);

% disp(T1);
% disp(T2);
% disp(T3);
% disp(T4);
% disp(T5);
% disp(T6);

%mphsave('test01')


end

