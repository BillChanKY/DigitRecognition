%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%
format short;

figure(3)
title("Bad Zeros")
for i = 1:25;
    subplot(5,5,i);
    ima2(mispredicted(:,i));
    axis image; axis off;
end
print bad_predictions.jpg

fprintf('as we can see from figure (3)...\n')
fprintf('most mis-predicted digits are, objectively, quite poorly written\n')
fprintf('to consider the question: whether more basis gives better accuracy,\n')
fprintf('I decided to compute the accuracy for 40 basis and for all 256 basis.\n')
fprintf('What ended up happening was quite interesting. Take a look at the table below :\n')
fprintf('\n')