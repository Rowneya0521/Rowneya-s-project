# 🌪️ Natural Disaster Image Classification using CNNs
A deep learning project addressing UN SDG 13: Climate Action, by applying convolutional neural networks to classify five types of natural disasters from images.

📄 [報告下載（PDF）](./report.pdf)

## 🧭 Introduction
This project applies Convolutional Neural Networks (CNNs) to automatically classify natural disaster images. It aims to assist in disaster response and improve decision-making efficiency by supporting early warning systems and digitizing disaster information.

## 🌍 Background
Due to increasing extreme weather events, the need for fast and accurate disaster response has become critical. This study uses AI-based image classification to identify natural disasters, supporting SDG Goal 13: **Climate Action**.

## 🛠️ Methodology

- **Dataset**: Custom-collected via web scraping, includes 5 classes:
  - Drought
  - Rainfall
  - Tsunami
  - Sandstorm
  - Tornado
- **Data Split**: 80% training / 10% validation / 10% testing
- **Models Compared**:
  - ResNet34
  - VGG16
  - EfficientNetB0
- **Training Framework**: FastAI with transfer learning (fine-tuned `.pkl` models)
- **Evaluation Metrics**:
  - Accuracy, Precision, Recall, F1-score (Macro/Micro)
  - Confusion Matrix
  - ROC Curve / AUC
  - Grad-CAM visualizations

## 📊 Results Summary

| Model         | Accuracy | Macro F1 | AUC  | Notes                                  |
|---------------|----------|----------|------|----------------------------------------|
| **ResNet34**      | 0.75     | 0.75     | 0.98 | Best overall performance, robust       |
| **VGG16**         | ~0.65    | 0.67     | 0.95 | Good precision, weak on "Tsunami"      |
| **EfficientNetB0**| 0.53     | 0.57     | 0.89 | Fast but unstable, confused categories |

## 🔍 Key Findings

- **ResNet34** is the most balanced and stable across categories.
- **Tsunami** is often confused with **Sandstorm** due to visual similarity.
- **Sandstorm** is the most misclassified category across all models.
- Visual features such as fog, dust, and unclear boundaries are the main confusion sources.

## 💡 Improvement Suggestions

- **Data Augmentation**: Simulate lighting, blur, and angles for confused categories.
- **Attention Mechanisms**: Highlight key spatial features like waterlines or dust patterns.
- **Ensemble Learning**: Combine strengths of all three models to cover weaknesses.

## 🖼️ Visualization
ResNet34 Grad-CAM highlights show accurate focus on disaster-specific features such as clouds, waves, and terrain structures.

## 🔗 Reference
- Source Report: 📄 [報告下載（PDF）](./Natural-Disaster-Classification/Disaster_CNN_Classification_Report.pdf)
- Article: [iT邦幫忙 AI 專案分享](https://ithelp.ithome.com.tw/m/articles/10356469)

## 🤖 Tools Used
- Python + FastAI
- Jupyter Notebooks
- Hugging Face (for future deployment)
