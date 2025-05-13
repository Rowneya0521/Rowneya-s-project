clear; % 清除變數
clc;   % 清除command window
close all; % 關閉開啟的視窗

% 設定參數
WS = 100;  % 滑窗大小（每個窗口包含的資料點數量）
SP = 50;   % 滑窗步長（窗口滑動時的偏移量）
dataPath = 'C:\Users\Rowneya\Desktop\matlab\PAMAP2-Protocol-20241206T053820Z-001\PAMAP2-Protocol\';
% 初始化矩陣
data_traintest_matrix = []; %用來儲存從數據檔案中讀取的數據矩陣 (特徵 + 標籤)。
data_traintest_matrix_L = []; %用來存放數據的類別標籤。
FT_GT = [];

%處理9個受試者的數據
for i = 1:9

    % 檢查文件是否存在
    filename = [dataPath 'subject10' num2str(i) '.dat'];
    if ~exist(filename, 'file')
        error('數據文件未找到: %s', filename);
    end
    % 載入受試者數據
    load(filename); 
    % 提取加速度計和陀螺儀數據
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,1:3) = subject10', num2str(i), '(:,5:7);']);
    % 計算合成加速度(三軸加速度的平方和的平方根）
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,4) = sqrt(subject10', num2str(i), '(:,5).^2 + subject10', num2str(i), '(:,6).^2 + subject10', num2str(i), '(:,7).^2);']);
   
    % 提取其他傳感器數據
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,5:7) = subject10', num2str(i), '(:,11:13);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,8) = sqrt(subject10', num2str(i), '(:,11).^2 + subject10', num2str(i), '(:,12).^2 + subject10', num2str(i), '(:,13).^2);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,9:11) = subject10', num2str(i), '(:,22:24);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,12) = sqrt(subject10', num2str(i), '(:,22).^2 + subject10', num2str(i), '(:,23).^2 + subject10', num2str(i), '(:,24).^2);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,13:15) = subject10', num2str(i), '(:,28:30);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,16) = sqrt(subject10', num2str(i), '(:,28).^2 + subject10', num2str(i), '(:,29).^2 + subject10', num2str(i), '(:,30).^2);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,17:19) = subject10', num2str(i), '(:,39:41);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,20) = sqrt(subject10', num2str(i), '(:,39).^2 + subject10', num2str(i), '(:,40).^2 + subject10', num2str(i), '(:,41).^2);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,21:23) = subject10', num2str(i), '(:,45:47);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,24) = sqrt(subject10', num2str(i), '(:,45).^2 + subject10', num2str(i), '(:,46).^2 + subject10', num2str(i), '(:,47).^2);']);
    eval(['subject10', num2str(i), '_HandChestAnkle_AccGyro(:,25) = subject10', num2str(i), '(:,2);']); % GT
    
    %  計算每個滑動窗口內的特徵 計算window動了幾次，幾個視窗(每個視窗是 WS 長度，並以 SP 為步長移動)
    eval(['NumofWindow = fix(((length(subject10', num2str(i), ')-WS)/SP)+1);']);
    % 對每個窗口進行特徵提取
    for k = 1:NumofWindow
        interval = 1+(k-1)*SP:WS+(k-1)*SP;% 定義當前窗口的數據範圍
        for m = 1:24  % 對每個傳感器通道提取特徵

            % 計算統計特徵(均值、標準差、最大值、最小值、範圍、方差、峰度、偏度)
            eval(['FT_subject10', num2str(i), '(k,1+(m-1)*8) = mean(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,2+(m-1)*8) = std(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,3+(m-1)*8) = max(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,4+(m-1)*8) = min(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,5+(m-1)*8) = range(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,6+(m-1)*8) = var(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,7+(m-1)*8) = kurtosis(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
            eval(['FT_subject10', num2str(i), '(k,8+(m-1)*8) = skewness(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,m));']);
        end
        % 計算Ground Truth % 提取當前窗口的主要活動類型（眾數）
        eval(['GT_subject10', num2str(i), '(k,1) = mode(subject10', num2str(i), '_HandChestAnkle_AccGyro(interval,25));']);
    end
    eval(['FT_GT_subject10', num2str(i), ' = [FT_subject10', num2str(i), ', GT_subject10', num2str(i), '];']);% 合併所有受試者的數據
    eval(['L', num2str(i), ' = size(FT_GT_subject10', num2str(i), ');']);% 添加標籤
    eval(['data_traintest_matrix_L', num2str(i), '(1:L', num2str(i), ',1) = i;']);
    eval(['data_traintest_matrix = [data_traintest_matrix; data_traintest_matrix_L', num2str(i), '];']); % 合併數據
    eval(['FT_GT = [FT_GT; FT_GT_subject10', num2str(i), '];']);
end
% 初始化結果矩陣
treeMatrix = zeros(9, 3);%抓取9*3矩陣
KnnMatrix = zeros(9, 3);
nbMatrix = zeros(9, 3);
% 訓練和測試模型
for i = 1:9
    % 準備訓練和測試數據
    test = (data_traintest_matrix == i);% 當前受試者的數據作為測試集
    train = ~test; % 其他受試者的數據作為訓練集
    FT_GT_test = FT_GT(test,:);
    FT_GT_train = FT_GT(train,:);
    % 決策樹模型
    try %如果發生錯誤，進入catch區塊繼續執行，避免崩潰
        model = fitctree(FT_GT_train(:,1:192), FT_GT_train(:,193));
        predictmodel = predict(model, FT_GT_test(:,1:192));
        predictpoint = zeros(length(eval(['subject10', num2str(i)])), 1);  % 預測結果處理
        for j = 1:length(predictmodel)
            predictpoint(1+(j-1)*SP:WS+(j-1)*SP) = predictmodel(j);
        end 
        if length(predictpoint) < length(eval(['subject10', num2str(i)])) % 補齊預測結果長度
            predictpoint(end+1:length(eval(['subject10', num2str(i)]))) = predictmodel(end);
        end
        
        eval(['confusionmatrix_', num2str(i), ' = confusionmat(subject10', num2str(i), '_HandChestAnkle_AccGyro(:,25), predictpoint);']);% 計算混淆矩陣
        
        eval(['Acc = sum(diag(confusionmatrix_', num2str(i), '))/sum(sum(confusionmatrix_', num2str(i), '));']);% 計算性能指標
        % 計算敏感度和精確度
        Sen = zeros(2,1);
        Pre = zeros(2,1);
        for n = 1:2
            eval(['Sen(n,1) = confusionmatrix_', num2str(i), '(n,n)/sum(confusionmatrix_', num2str(i), '(n,:));']);
            eval(['Pre(n,1) = confusionmatrix_', num2str(i), '(n,n)/sum(confusionmatrix_', num2str(i), '(:,n));']);
        end
        % 存儲結果
        treeMatrix(i,:) = [Acc, mean(Sen), mean(Pre)];
    catch 
        warning('treeerror: %s', ME.message);
        treeMatrix(i,:) = [NaN, NaN, NaN];
    end
    
    % KNN模型
    try
        modelkNN = fitcknn(FT_GT_train(:,1:192), FT_GT_train(:,193), 'Distance', 'euclidean', 'NumNeighbors', 3);
        predictmodel = predict(modelkNN, FT_GT_test(:,1:192));
        
        % 計算混淆矩陣
        eval(['confusionmatrix_', num2str(i), ' = confusionmat(FT_GT_test(:,193), predictmodel);']);
        eval(['Acc = sum(diag(confusionmatrix_', num2str(i), '))/sum(sum(confusionmatrix_', num2str(i), '));']);
        
        % 計算性能指標
        Sen = zeros(2,1);
        Pre = zeros(2,1);
        for n = 1:2
            eval(['Sen(n,1) = confusionmatrix_', num2str(i), '(n,n)/sum(confusionmatrix_', num2str(i), '(n,:));']);
            eval(['Pre(n,1) = confusionmatrix_', num2str(i), '(n,n)/sum(confusionmatrix_', num2str(i), '(:,n));']);
        end
        
        KnnMatrix(i,:) = [Acc, mean(Sen), mean(Pre)];
    catch 
        warning('KNNerror: %s', E.message);
        KnnMatrix(i,:) = [NaN, NaN, NaN];
    end
    
    % nb模
    try
        modelnb = fitcnb(FT_GT_train(:,1:192), FT_GT_train(:,193));
        predictmodel = predict(modelnb, FT_GT_test(:,1:192));
        
        % 計算混淆矩陣
        eval(['confusionmatrix_', num2str(i), ' = confusionmat(FT_GT_test(:,193), predictmodel);']);
        eval(['Acc = sum(diag(confusionmatrix_', num2str(i), '))/sum(sum(confusionmatrix_', num2str(i), '));']);
        
        % 計算性能指標
        Sen = zeros(2,1);
        Pre = zeros(2,1);
        for n = 1:2
            eval(['Sen(n,1) = confusionmatrix_', num2str(i), '(n,n)/sum(confusionmatrix_', num2str(i), '(n,:));']);
            eval(['Pre(n,1) = confusionmatrix_', num2str(i), '(n,n)/sum(confusionmatrix_', num2str(i), '(:,n));']);
        end
        nbMatrix(i,:) = [Acc, mean(Sen), mean(Pre)];
    catch 
        warning('nberror: %s', E.message);
        nbMatrix(i,:) = [NaN, NaN, NaN];
    end
end

% 顯示結果
disp('tree (ACC,sen,pre):');
disp(treeMatrix);
disp('KNN (ACC,sen,pre):');
disp(KnnMatrix);
disp('nb (ACC,sen,pre):');
disp(nbMatrix);
