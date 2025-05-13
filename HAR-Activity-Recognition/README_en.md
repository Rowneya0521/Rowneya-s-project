# Human Activity Recognition (HAR) Based on the PAMAP2 Dataset

This project implements a MATLAB-based Human Activity Recognition (HAR) system using the PAMAP2 dataset. It covers data preprocessing, feature extraction, activity labeling, and classification using traditional machine learning models.

---

## Project Overview

- Dataset: PAMAP2 Physical Activity Monitoring Dataset (provided by UCI)
- Subjects: 9 participants, each providing complete time-series sensor data
- Sensor Types: 8-axis accelerometer and gyroscope data, including computed magnitude (synthetic acceleration)

---

## Preprocessing and Feature Extraction

- Clean the MATLAB environment (clear variables, close figures, clear command window)
- Set sliding window parameters:
  - Window Size (WS): number of samples per window
  - Step Size (SP): number of samples the window shifts each step
- For each subject:
  - Load the corresponding `.dat` file (with error handling if missing)
  - Extract statistical features from each window (e.g., mean, standard deviation, max, min)
  - Use the `mode()` function to determine the ground truth label based on the most frequent label in the window
- Final output: feature matrix + ground truth label for each window

---

## Classification Models and Validation

- Models used:
  - Decision Tree
  - k-Nearest Neighbors (KNN)
  - Naive Bayes

- Cross-validation approach:
  - Leave-One-Subject-Out (LOSO)
  - Train on 8 subjects, test on the remaining one

- Training details:
  - `try-catch` structures used for robust error handling during model training
  - Accuracy results recorded in a structured accuracy matrix

---

## Data Note

The PAMAP2 raw dataset used in this project was provided by the course instructor and cannot be shared publicly.
[Chinese version available here → README_zh.md](./README_zh.md)
