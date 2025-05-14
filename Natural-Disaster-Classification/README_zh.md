# 深度學習應用於自然災害影像分類  
ResNet34 / VGG16 / EfficientNetB0 模型 + Grad-CAM 可視化 + Hugging Face 即時部署

## 專案簡介

本專案旨在應用深度學習技術，自動辨識五種類型的自然災害影像，包括：乾旱、降雨、海嘯、沙塵暴、龍捲風，以支援聯合國永續發展目標 SDG 13：「氣候行動」。

我們利用爬蟲技術從網路蒐集與清洗災害圖片資料，並使用 FastAI 架構進行遷移學習，訓練三種卷積神經網路（CNN）模型：ResNet34、VGG16、EfficientNetB0，並比較其在影像分類任務中的表現。

## 方法說明

### 資料集來源
自製的五類自然災害影像資料集，透過網路爬蟲取得並人工篩選。

### 資料分割比例
- 訓練集：80%  
- 驗證集：10%  
- 測試集：10%  

### 模型訓練流程
採用 ImageNet 預訓練模型進行 Transfer Learning。

訓練模型包括：
- ResNet34（表現最佳）
- VGG16
- EfficientNetB0

### 評估指標
- 準確率（Accuracy）  
- 精確率（Precision）  
- 召回率（Recall）  
- F1 分數（Macro / Micro）  
- AUC（每類別）  
- 混淆矩陣（Confusion Matrix）  
- ROC 曲線  

使用 Grad-CAM 可視化模型關注區域，提升模型可解釋性。

### 使用工具與套件
- FastAI  
- PyTorch  
- OpenCV  
- Matplotlib  
[English version available here → README_en.md](./README_en.md)
