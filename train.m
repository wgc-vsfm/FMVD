load smad_label.mat
load vsfm_feature.mat
SVMModel = fitcsvm(vsfm_feature_train,train_label, 'BoxConstraint',10,'KernelFunction','rbf','KernelScale',2^0.5*2); %训练分类器
CVSVMModel = crossval(SVMModel);   %分类器的交叉验证
classLoss = kfoldLoss(CVSVMModel)%  样本内错误率
[predict_label,score] = predict(SVMModel,vsfm_feature_test);%; %样本外的数据进行分类预测
%[label,scorePred] = kfoldPredict(CVSVMModel); %样本外的数据进行分类预测结果，
real_label = test_label;
% 预测类别
% predict_label = label;
% 利用“confusionmat”可以直接产生混淆矩阵，不过-1在前，1在后
[A,~] = confusionmat(real_label,predict_label);
% 计算-1类的评价值
c1_precise = A(1,1)/(A(1,1) + A(2,1));
c1_recall = A(1,1)/(A(1,1) + A(1,2));
c1_F1 = 2 * c1_precise * c1_recall/(c1_precise + c1_recall);
% 计算1类的评价值
c2_precise = A(2,2)/(A(1,2) + A(2,2));
c2_recall = A(2,2)/(A(2,1) + A(2,2));
c2_F1 = 2 * c2_precise * c2_recall/(c2_precise + c2_recall);
%准确率
Accary=(A(1,1)+A(2,2))/(A(1,1)+A(1,2)+A(2,1)+A(2,2));
% plotroc(real_label, b)
APCER = A(2,1)/(A(2,2) + A(2,1));
BPCER = A(1,2)/(A(1,2) + A(1,1));
ACER  = (APCER + BPCER)/2;
plotroc(real_label',score(:,2)');