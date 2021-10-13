%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%
format short;

%obtain singular values for each class
%these set0, set1...set9  were defined in Q1_a
s0 = svd(set0);
s1 = svd(set1);
s2 = svd(set2);
s3 = svd(set3);
s4 = svd(set4);
s5 = svd(set5);
s6 = svd(set6);
s7 = svd(set7);
s8 = svd(set8);
s9 = svd(set9);


%plot singular values of all classes
figure(1)
title("10 singular values")
    subplot(2,5,1);
    plot(s0);
    subplot(2,5,2);
    plot(s1);
    subplot(2,5,3);
    plot(s2);
    subplot(2,5,4);
    plot(s3);
    subplot(2,5,5);
    plot(s4);
    subplot(2,5,6);
    plot(s5)
    subplot(2,5,7);
    plot(s6);
    subplot(2,5,8);
    plot(s7);
    subplot(2,5,9);
    plot(s8);
    subplot(2,5,10);
    plot(s9);


fprintf('as we can see in the graph generated (figure 1)\n')
fprintf('some classes rely heavier on lower singular vectors\n')
fprintf('as a result, these classes will benefit from higher\n')
fprintf('for example, the digit "1" might actually suffer\n ')
fprintf('from using too many basis across the board\n\n')

fprintf('we then examine the accuracty of these 3 methods...\n')
fprintf('...on EACH CLASS INDIVIDUALLY')


