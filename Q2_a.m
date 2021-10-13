%%%%%%%%%%%%%%%%
%   NAME : BILL CHAN
%   SID : 915373822
%%%%%%%%%%%%%%%%
%
%All concepts are discussed in comments
%
format long;

raw = importdata("wdbc.data");
data = raw.data;
y = raw.textdata;
%convert y into string, so we can compare to retrieve boolean values
str_y = string(y);

train_x = raw.data(1:500, 1:30);
train_y = [];
test_y = [];


%since str_y now consist of strings, comparison is now possible
for i = [1:500];
    if str_y(i,2) == 'B';
        train_y(i,1) = 1;
    elseif str_y(i,2) == 'M';
        train_y(i,1) = -1;
    end
end

test_x = raw.data(501:569, 1:30);

for i = [501:569];
    if str_y(i,2) == 'B';
        test_y(i-500,1) = 1;
    elseif str_y(i,2) == 'M';
        test_y(i-500,1) = -1;
    end
end

%now that we have train_x train_y test_x test_y...
%we want to form A and b matrices...
%...such that we can solve for Ax <=b


%we're trying to solve min f'*x, s.t. A 
%set up needed vectors and matrices presented in lecture
D = eye(500);  %initialize D

for i = [1:500];
    D(i,i) = train_y(i);
end


%from the notes in lecture and extensive manipulation, we have...
...f as a matrix with zeros followed by ones%
%we also have that the constraint is...
%...-D(Aw + eb) + t <= -e

%which, according to professor Puckett, we can rearrange and AUGMENt...
%...to form 1 singular, huge, A matrix for linprog.
%rearranging gives us the negative signs, and AUGMENTING gives us that...
%... A = [-D*train_x, -train_y, -I], where I is identity matrix
%...now...to set up

I = eye(500);                   %identity matrix of the correct dimension
AA = [-D*train_x, -train_y, -I];
b1 = -(ones(500,1));

%and...we had that f is something like (1/m)*transpose(e)*t
%...but, since lamnda is 0, meaning we don'r have another term
%...we can effectively ignore(1/m), and since t, in this case, will be 0
%for the first 31 instances (the initial 30 + the -train_y we augmented
%onto the matrix
%we can rewrite f as...
f(1:31) = 0;
f(32:531) = 1;

%now, we f, A, and b1 figured out, we can input linprog...

%combined_answers = linprog(f,A,b1);
    %oh oops...we should bound it
    %we will input arbitrary low lower bound for first 31 element
lower = [-1000*(ones(31,1));zeros(500,1)];
    %...and have other inputs as
    %empty values as they don't matter...
    %so...it'll be something like

x1 = linprog(f,AA,b1,[],[],lower,[]);
%then the training results will be...
fprintf('After linprog, we have the following :\n')
trained_w = x1(1:30)
trained_b = x1(31)

fprintf('To use this to predict the 69 test cases, we do (transpose(trained_w)*transpose(test_x))+trained_b :\n')
fprintf('and then we transform anything less than -1 into -1, and anything greater than 1 into 1\n')
fprintf('we then compare it to the set test_y to check our accuracy, creating a confusing matrix\n')
initial_predictions = (transpose(trained_w)*transpose(test_x))+trained_b;

for i = [1:69];
    if initial_predictions(i)<=-1;
        predictions(i) = -1;
    elseif initial_predictions(i) >= 1;
        predictions(i) = 1;
    end
end

predictions = transpose(predictions);

fprintf('After running the algorithm through the test set...\n')
fprintf('...we predict the number of benigns and malignants are :\n')
predicted_num_B = sum(predictions == 1)
predicted_num_M = sum(predictions == -1)
fprintf('and according to test_y, the actual distribution is :\n')
actual_num_B = sum(test_y == 1)
actual_num_M = sum(test_y == -1)
fprintf('so if we were to construct a confusion matrix, where...\n')
fprintf('...correct predictions for B and M go on (1,1) and (2,2)\n')
fprintf('actual B that were missed in (1,2) and actual M that were missed in (2,1)\n')
fprintf('we would have...\n')

confuse = zeros(2);
for i = [1:69];
    if predictions(i) == test_y(i);
        if test_y(i) == 1;
            confuse(1,1) = confuse(1,1)+1;
        else
            confuse(2,2) = confuse(2,2) + 1;
        end
    else
        if test_y(i) == 1;
            confuse(1,2) = confuse(1,2) + 1;
        else
            confuse(2,1) = confuse(2,1) + 1;
        end
    end
end

% display confuse matrix
confuse

fprintf('It seems that we have a relatively good accuracy. However, one data point failed to be classified. \n')
fprintf('In the following, we will attempt to create another algorithm, this time using quadprog\n')
fprintf('\n')
fprintf('We see that quadprog requires a new input, namely H\n')
fprintf('What we notices from the lectrures is that...since lambda is 0...\n')
fprintf('... as long as we have H as big as possible for the first 30 elements on the diagonal of the augmented matrix,\n')
fprintf('our results will be consistant\n')
fprintf('lets take the "as big as possible" to be 10^7\n')
fprintf('so...we have that...:\n')
H = zeros(531);
for i = [1:30];
    %H(i,i) = 10^10;
    %oops...that was too small, let's try something bigger
    %H(ii) = 10^20;
    %??? it's still too small
    H(i,i) = 10^50;     %finally..that's good enough, as long as first 30 results of quadprog is 0
end
fprintf('now we can do...\n') 
fprintf('...quadprog(H,f,AA,b1, [],[], lower, [])\n')
fprintf('where lower is still the same lower bound...so now we run the function :\n')
%execute quadprog to get solution

x2 = quadprog(H,f,AA,b1,[],[],lower,[])

fprintf('\n')


            
            
            
            
            
            
            
            