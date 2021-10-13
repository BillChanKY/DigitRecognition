%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%
format short;

load dtest;
load testzip;

testset0 = [];
testset1 = [];
testset2 = [];
testset3 = [];
testset4 = [];
testset5 = [];
testset6 = [];
testset7 = [];
testset8 = [];
testset9 = [];
%classify digits from test.zip

% we bring in the 3 sets of basis for our predictions
u_5s;
u_10s;
u_20s;


%%%dedicate for loops for each testsets

%%let's do 


%we will be plotting 3 lines, representing 5, 10 , 20. 
%y will be accuracy (%)
%x will be class

%initialize acc_5, acc_10, and acc_20

%load in all predictions%
predict_5;
predict_10;
predict_20;

%load correct answer
load dtest;

%let's start with digit 0
for i = [1:10];
    tots_5(i) = sum(dtest == (i-1));
    pres_5(i) = sum(predict_5(dtest==(i-1))==(i-1));
    acc_5s(i) = pres_5(i)/tots_5(i);
end
for i = [1:10];
    tots_10(i) = sum(dtest == (i-1));
    pres_10(i) = sum(predict_10(dtest==(i-1))==(i-1));
    acc_10s(i) = pres_10(i)/tots_10(i);
end
for i = [1:10];
    tots_20(i) = sum(dtest == (i-1));
    pres_20(i) = sum(predict_20(dtest==(i-1))==(i-1));
    acc_20s(i) = pres_20(i)/tots_20(i);
end

acc_5s = acc_5s*100;
acc_10s = acc_10s*100;
acc_20s = acc_20s*100;
class = [0;1;2;3;4;5;6;7;8;9];

%tot_0 = sum(dtest == 0);
%pre_0 = sum(predict_5(dtest==0)==0);
%acc_5(1) = pre_0/tot_0

VarNames = {'classes', 'accuracy_5(%)', 'accuracy_10(%)','accuracy_20(%)'};
accuracy_by_class = table(class,transpose(acc_5s),transpose(acc_10s), transpose(acc_20s), 'VariableNames', VarNames)

figure(2)
plot(acc_10s,'DisplayName','acc_10s');hold on;plot(acc_20s,'DisplayName','acc_20s');plot(acc_5s,'DisplayName','acc_5s');hold off;


fprintf('if we look at figure (2) and the above table,\n')
fprintf('we will first see that, for class/digit 1... \n')
fprintf('...using 10 basis is actually more accurate than 20\n')
fprintf('\n')
fprintf('another thing worth mentioning is the difficulty of prediction\n')
fprintf('from the graph, it seems that classes/digits 6 and 9 have the\n')
fprintf('worst accuracy for 5 basis..\n')
fprintf('Whereas for 10 and 20 basis, classes/digits 4,6,9 have poor accuracy as well.\n')
fprintf('\n')
fprintf('If we want look at some of the test samples that were mispredicted...\n')
fprintf("we can look at some mispredicted digits, in basis 20, since it's most accurate\n")


mispredicted = testzip(:,predict_20~=dtest);







