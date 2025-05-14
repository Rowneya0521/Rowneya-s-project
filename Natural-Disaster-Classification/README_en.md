# Deep Learning for Natural Disaster Image Classification  
ResNet34 / VGG16 / EfficientNetB0 Models + Grad-CAM Visualization + Hugging Face Deployment

## Project Overview

This project aims to apply deep learning techniques to automatically classify five types of natural disaster images, including: Drought, Rainfall, Tsunami, Sandstorm, and Tornado. The goal aligns with the United Nations Sustainable Development Goal (SDG) 13: "Climate Action".

We used web scraping to collect and clean disaster-related image data from online sources. Then, we applied transfer learning with the FastAI framework to train and compare three convolutional neural network (CNN) models: ResNet34, VGG16, and EfficientNetB0.

## Methodology

### Dataset Source
A custom dataset consisting of five natural disaster categories, collected via web scraping and manually filtered.

### Dataset Split
- Training set: 80%  
- Validation set: 10%  
- Test set: 10%  

### Model Training
We used ImageNet pretrained models for transfer learning.

The models trained include:
- ResNet34 (best performer)
- VGG16
- EfficientNetB0

### Evaluation Metrics
- Accuracy  
- Precision  
- Recall  
- F1 Score (Macro / Micro)  
- AUC (per class)  
- Confusion Matrix  
- ROC Curve  

Grad-CAM was used to visualize model attention and enhance interpretability.

### Tools and Libraries
- FastAI  
- PyTorch  
- OpenCV  
- Matplotlib  
[Chinese version available here → README_zh.md](./README_zh.md)
