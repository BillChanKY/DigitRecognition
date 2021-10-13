%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%
format short;

fprintf('The relative accuracy of these 3 methods are :\n')
%Compare predictions to actual First get index of boolean values
hits5 = predict_5 == dtest;
hits10 = predict_10 == dtest;
hits20 = predict_20 == dtest;

%sum over boolean array to count num of hits
num_hits5 = sum(hits5);
num_hits10 = sum(hits10);
num_hits20 = sum(hits20);


%determine percentage of accuracy
acc_5 = (num_hits5/2007)*100;
acc_10 = (num_hits10/2007)*100;
acc_20 = (num_hits20/2007)*100;

accuracy = [5, acc_5;
    10, acc_10;
    20, acc_20];

%print results into table
VarNames = {'# of Basis images', 'Correct (%)' };
General_accuracy = table(accuracy(:,1), accuracy(:,2),   'VariableNames', VarNames)