data = readmatrix('C:\Users\ajay singh\Desktop\Aj code\Matlab\data_pvap.xlsx');
% Separate data for CH3OH and H2O
Pvap_CH3OH=readmatrix("C:\Users\ajay singh\Desktop\Aj code\Matlab\data_pvap.xlsx",'sheet','CH3OH');
Pvap_H2O=readmatrix("C:\Users\ajay singh\Desktop\Aj code\Matlab\data_pvap.xlsx",'sheet','H2O');
%Divide data into training and test sets
rng(123);
n = size(data, 1);
train_ratio = 0.7;
train_indices = randperm(n, round(train_ratio * n));
test_indices = setdiff(1:n, train_indices);
train_data = data(train_indices, :);
test_data = data(test_indices, :);
%Separate data for CH3OH and H2O
T_CH3OH = Pvap_CH3OH(:, 1);
ln_pvap_CH3OH = log(Pvap_CH3OH(:,2));
T_H2O = Pvap_H2O(:, 1);
ln_pvap_H2O = log(Pvap_H2O(:, 2));
%Use linear regression to estimate A and B for CH3OH and H2O
model_CH3OH = fitlm(1./T_CH3OH, ln_pvap_CH3OH);
model_H2O = fitlm(1./T_H2O, ln_pvap_H2O);
A_CH3OH = model_CH3OH.Coefficients.Estimate(2);
B_CH3OH = model_CH3OH.Coefficients.Estimate(1);
A_H2O = model_H2O.Coefficients.Estimate(2);
B_H2O = model_H2O.Coefficients.Estimate(1);
%Estimate pvap for the testing set
T_test_CH3OH =T_CH3OH (:, 1);
T_test_H2O = T_H2O (:, 1);
ln_pvap_test_CH3OH = A_CH3OH - B_CH3OH ./ T_test_CH3OH;
ln_pvap_test_H2O = A_H2O - B_H2O ./ T_test_H2O;
% Step 5: Calculate RMSE for training and test datasets
RMSE_train_CH3OH = sqrt(mean((ln_pvap_CH3OH - (A_CH3OH - B_CH3OH ./ T_CH3OH)).^2));
RMSE_test_CH3OH = sqrt(mean((log(Pvap_CH3OH(:, 2)) - ln_pvap_test_CH3OH).^2));
RMSE_train_H2O = sqrt(mean((ln_pvap_H2O - (A_H2O - B_H2O ./ T_H2O)).^2));
RMSE_test_H2O = sqrt(mean((log(Pvap_H2O(:, 2)) - ln_pvap_test_H2O).^2));
fprintf('CH3OH - Training RMSE: %.4f\n', RMSE_train_CH3OH);
fprintf('CH3OH - Test RMSE: %.4f\n', RMSE_test_CH3OH);
fprintf('H2O - Training RMSE: %.4f\n', RMSE_train_H2O);
fprintf('H2O - Test RMSEr-: %.4f\n', RMSE_test_H2O);
%Create plots for CH3OH and H2O
figure;
subplot(2, 1, 1);
plot(T_CH3OH, ln_pvap_CH3OH, 'bo', T_CH3OH, ln_pvap_CH3OH, 'r-');
xlabel('Temperature (T)');
ylabel('ln(pvap)');
title('CH3OH - Actual vs. Predicted ln(pvap)');
legend('Actual', 'Predicted');
 
subplot(2, 1, 2);
plot(T_H2O, ln_pvap_H2O, 'bo', T_H2O, ln_pvap_H2O, 'r-');
xlabel('Temperature (T)');
ylabel('ln(pvap)');
title('H2O - Actual vs. Predicted ln(pvap)');
legend('Actual', 'Predicted');