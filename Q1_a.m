%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%

format short;

load dzip;
load azip;
load dtest;
load testzip;

set0 = [];
set1 = [];
set2 = [];
set3 = [];
set4 = [];
set5 = [];
set6 = [];
set7 = [];
set8 = [];
set9 = [];

for i = [1:1707];
    if dzip(i) == 0;
        set0 = [set0, azip(:,i)];
    elseif dzip(i) == 1;
        set1 = [set1, azip(:,i)];
    elseif dzip(i) == 2;
        set2 = [set2, azip(:,i)];
    elseif dzip(i) == 3;
        set3 = [set3, azip(:,i)];
    elseif dzip(i) == 4;
        set4 = [set4, azip(:,i)];
    elseif dzip(i) == 5;
        set5 = [set5, azip(:,i)];
    elseif dzip(i) == 6;
        set6 = [set6, azip(:,i)];
    elseif dzip(i) == 7;
        set7 = [set7, azip(:,i)];
    elseif dzip(i) == 8;
        set8 = [set8, azip(:,i)];
    elseif dzip(i) == 9;
        set9 = [set9, azip(:,i)];
    end
end

%generating SVD:
[u0,s,y] = svd(set0);
[u1,s,y] = svd(set1);
[u2,s,y] = svd(set2);
[u3,s,y] = svd(set3);
[u4,s,y] = svd(set4);
[u5,s,y] = svd(set5);
[u6,s,y] = svd(set6);
[u7,s,y] = svd(set7);
[u8,s,y] = svd(set8);
[u9,s,y] = svd(set9);

%compile all U's into a 3D matrix for easy iterations through for loops
u_s = zeros(256,256,10);
u_s(:,:,1) = u0;
u_s(:,:,2) = u1;
u_s(:,:,3) = u2;
u_s(:,:,4) = u3;
u_s(:,:,5) = u4;
u_s(:,:,6) = u5;
u_s(:,:,7) = u6;
u_s(:,:,8) = u7;
u_s(:,:,9) = u8;
u_s(:,:,10)= u9;

%taking first 5 u's, put them into a 3d matrix
    %initialize 3 d matrix of the right dimensions :

for i = [1:10];
    u_5s(:,:,i) = u_s(:,1:5,i);
end
for i = [1:10];
    u_10s(:,:,i) = u_s(:,1:10,i);
end
for i = [1:10];
    u_20s(:,:,i) = u_s(:,1:20,i);
end


%load test data
load testzip

%initialize 2007 preditions
predict_5  = zeros(1,2007);
predict_10 = zeros(1,2007);
predict_20 = zeros(1,2007);
%initialize digits for easy retrieval for predictions
nums = [0,1,2,3,4,5,6,7,8,9];

%for loop of predict_5%
%go through each z%
for j = [1:2007];
    %go through each digit's norms
    z = testzip(:,j);

    for k = [1:10];
        
      %want (z - U*UT*z), which is 
      temp = z - u_5s(:,:,k)*transpose(u_5s(:,:,k))*z;
      %want norm
      norm_diff(k) = norm(temp);
        %we know the solution to each least squares method is as follows
    end
    min_diff = min(norm_diff);
    predict_5(j) = nums(norm_diff == min_diff);
    
end
for j = [1:2007];
    %go through each digit's norms
    z = testzip(:,j);

    for k = [1:10];
        
      %want (z - U*UT*z), which is 
      temp = z - u_10s(:,:,k)*transpose(u_10s(:,:,k))*z;
      %want norm
      norm_diff(k) = norm(temp);
        %we know the solution to each least squares method is as follows
    end
    min_diff = min(norm_diff);
    predict_10(j) = nums(norm_diff == min_diff);
    
end
for j = [1:2007];
    %go through each digit's norms
    z = testzip(:,j);

    for k = [1:10];
        
      %want (z - U*UT*z), which is 
      temp = z - u_20s(:,:,k)*transpose(u_20s(:,:,k))*z;
      %want norm
      norm_diff(k) = norm(temp);
        %we know the solution to each least squares method is as follows
    end
    min_diff = min(norm_diff);
    predict_20(j) = nums(norm_diff == min_diff);
    
end
fprintf('The first 20 predictions for all 2007 test values, with 5, 10, and 20 basis vectors :\n')
with_5_basis  = predict_5(1:20)
with_10_basis = predict_10(1:20)
with_20_basis = predict_20(1:20)
fprintf('To view all predictions, predict_5, predict_10, predict_20\n')
fprintf('store all the predictions with 5, 10, 20 basis respectively\n')
predictions_for_5_basis = predict_5;
predictions_for_10_basis = predict_10;
predictions_for_20_basis = predict_20;



hits5 = predict_5 == dtest;
hits10 = predict_10 == dtest;
hits20 = predict_20 == dtest;

num_hits5 = sum(hits5);
num_hits10 = sum(hits10);
num_hits20 = sum(hits20);



    
    
    