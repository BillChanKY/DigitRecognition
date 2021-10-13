%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%
%   This is just to print out more accuracy values for different number of
%   basis.
%
%
format short;

for i = [1:10];
    u_40s(:,:,i) = u_s(:,1:40,i);
end

for i = [1:10];
    u_all(:,:,i) = u_s(:,:,i);
end


predict_40 = zeros(1,2007);
predict_all = zeros(1,2007);


for j = [1:2007];
    %go through each digit's norms
    z = testzip(:,j);

    for k = [1:10];
        
      %want (z - U*UT*z), which is 
      temp = z - u_40s(:,:,k)*transpose(u_40s(:,:,k))*z;
      %want norm
      norm_diff(k) = norm(temp);
        %we know the solution to each least squares method is as follows
    end
    min_diff = min(norm_diff);
    predict_40(j) = nums(norm_diff == min_diff);
    
end
for j = [1:2007];
    %go through each digit's norms
    z = testzip(:,j);

    for k = [1:10];
        
      %want (z - U*UT*z), which is 
      temp = z - u_all(:,:,k)*transpose(u_all(:,:,k))*z;
      %want norm
      norm_diff(k) = norm(temp);
        %we know the solution to each least squares method is as follows
    end
    min_diff = min(norm_diff);
    predict_all(j) = nums(norm_diff == min_diff);
end

predictions_for_40_basis = predict_40;
hits40 = predict_40 == dtest;
num_hits40 = sum(hits40);
acc_40 = (num_hits40/2007)*100;

predictions_for_all_basis = predict_all;
hitsall = predict_all == dtest;
num_hitsall = sum(hitsall);
acc_all = (num_hitsall/2007)*100;

accuracy = [5, acc_5;
    10, acc_10;
    20, acc_20;
    40, acc_40;
    256, acc_all];

VarNames = {'# of Basis images', 'Correct (%)' };
General_accuracy = table(accuracy(:,1), accuracy(:,2),   'VariableNames', VarNames)

fprintf('Interestingly, using 40 basis gives a lower result...\n')
fprintf('...and using ALL basis drastically decreases the accuracy of the results\n')
fprintf('Whether or not this is an error in the code I have yet to find out.\n')
fprintf('However, one thing that is certain is that, it takes significally longer to compute.\n')
fprintf('While this was still possible with 2007 16x16 images, it would be infeasible for more advnaced applications\n')


