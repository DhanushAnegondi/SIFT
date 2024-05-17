# Forgery Detection by Adaptive Oversegmentation and Keypoint Matching

This repository contains the implementation of an image forgery detection system using adaptive oversegmentation and keypoint matching techniques. The system aims to identify copy-move forgeries in digital images by analyzing image blocks and keypoints.

## Table of Contents
- [Introduction](#introduction)
- [Dataset](#dataset)
- [Models Implemented](#models-implemented)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Results](#results)
- [Discussion](#discussion)
- [Conclusion](#conclusion)
- [Future Scope](#future-scope)
- [References](#references)

## Introduction

With advancements in digital image processing and editing software, image forgery has become increasingly easy to perform. Detecting such forgeries is crucial for various applications, including journalism, forensic investigations, and legal evidence. This project leverages adaptive oversegmentation and keypoint matching techniques to detect copy-move forgeries in digital images.

## Dataset

The dataset used for this project includes various digital images with known forgeries. The images are used to train and test the forgery detection algorithms. Specific datasets or sources were not mentioned in the document.

## Models Implemented

The project implements several models and techniques for forgery detection:

### 1. Block-Based Methods

**Discrete Cosine Transform (DCT)**
- DCT is used to transform image blocks into frequency domain coefficients, making it easier to identify duplicated regions.

**Discrete Wavelet Transform (DWT)**
- DWT decomposes an image into subbands, helping in identifying similarities in different frequency components of the image.

**Principal Component Analysis (PCA)**
- PCA reduces the dimensionality of image blocks while preserving essential features, aiding in the detection of copy-move forgeries.

**Singular Value Decomposition (SVD)**
- SVD is used to decompose image blocks into singular values, which are then compared to detect duplicated regions.


### Keypoint-Based Methods

**1. Scale-Invariant Feature Transform (SIFT)**

**Description:**
- SIFT detects and describes local features in images, which are invariant to scale, rotation, and illumination changes.
- Keypoints are extracted from the image, and feature descriptors are computed. These descriptors are then matched to identify duplicated regions.

**Advantages:**
- Robust to various transformations and noise.
- Provides highly distinctive feature descriptors.

**2. Speeded-Up Robust Features (SURF)**

**Description:**
- SURF is a faster alternative to SIFT, used for feature detection and description.
- It is based on integral images and the Hessian matrix, providing robust feature detection.

**Advantages:**
- Faster than SIFT while maintaining similar robustness.
- Effective in real-time applications.

**3. Oriented FAST and Rotated BRIEF (ORB)**

**Description:**
- ORB combines the FAST keypoint detector and the BRIEF descriptor. It provides efficient and robust feature detection and description.
- Keypoints are detected using the FAST algorithm, and binary descriptors are computed using BRIEF. These descriptors are then matched to detect forgeries.

**Advantages:**
- Fast and efficient, suitable for real-time applications.
- Provides good performance in terms of accuracy and robustness.

### Combined Approach

**Adaptive Oversegmentation and Keypoint Matching**

**Description:**
- The proposed method combines both block-based and keypoint-based techniques for improved forgery detection.
- Adaptive oversegmentation is used to divide the image into non-overlapping, irregular blocks. This is achieved using algorithms like Simple Linear Iterative Clustering (SLIC).
- Keypoints are extracted from each block and matched to identify potential forgery regions.
- A final step involves morphological operations to refine the detected regions and reduce false positives.

**Advantages:**
- Combines the strengths of both block-based and keypoint-based methods.
- Provides higher accuracy and robustness in detecting forgeries.
- Adaptively segments the image, reducing computational complexity and improving detection efficiency.

## Detailed Architecture

### Adaptive Oversegmentation

**1. Simple Linear Iterative Clustering (SLIC)**
- SLIC is used to segment the image into superpixels, which are more uniform and smaller than traditional blocks.
- This adaptive segmentation helps in better localizing and detecting duplicated regions.

**2. Discrete Wavelet Transform (DWT)**
- DWT is applied to the segmented blocks to extract frequency components, which are then used for feature extraction and matching.

### Feature Extraction and Matching

**1. Scale-Invariant Feature Transform (SIFT)**
- SIFT keypoints are extracted from each segmented block.
- Feature descriptors are computed and matched to identify duplicated regions.

**2. Block Feature Extraction and Matching**
- Features such as texture, color, and edge information are extracted from each block.
- These features are compared to detect similarities and identify forgeries.

### Post-Processing

**1. Forgery Region Extraction**
- Identified keypoints and blocks are processed to refine the detected regions.
- Superpixels are merged based on local color features to form coherent forgery regions.

**2. Morphological Operations**
- Morphological operations such as dilation and erosion are applied to clean up the detected regions.
- This helps in reducing false positives and improving the accuracy of the detection.


## Technologies Used

- **Programming Language**: MATLAB
- **Libraries and Frameworks**:
  - Image Processing Toolbox
  - Computer Vision Toolbox
- **Tools**: MATLAB's help browser for extensive documentation and examples.

## Installation

To set up the project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/forgery-detection.git
    ```

2. Navigate to the project directory:
    ```bash
    cd forgery-detection
    ```

3. Open the project in MATLAB and ensure you have the Image Processing Toolbox and Computer Vision Toolbox installed.

## Usage

1. **Running the Forgery Detection Algorithm**: 
    - Open the `forgery_detection.m` script in MATLAB.
    - Load the image to be analyzed.
    - Run the script to detect forgery in the image.

2. **Analyzing Results**: 
    - The results will be displayed, showing the regions identified as forgeries.

## Results

The implemented models and techniques can accurately identify copy-move forgeries in digital images. Detailed performance metrics and sample output images are included in the `results` directory.

## Discussion

The combination of block-based and keypoint-based methods provides a robust approach to forgery detection. The adaptive oversegmentation technique improves the accuracy of detecting forged regions by dynamically adjusting the segmentation of the image.

## Conclusion

This project demonstrates the effectiveness of adaptive oversegmentation and keypoint matching techniques in detecting copy-move forgeries in digital images. The implemented methods provide high accuracy and robustness to various image transformations.

## Future Scope

Future enhancements could include:
- Improving the computational efficiency of the algorithms.
- Extending the detection methods to other types of image forgeries.
- Developing a real-time forgery detection system.

## References

- Sunil Kumar Jagannath Desai, "Forgery Detection by DCT"
- Mehdi GhorbaniMohammad F., "Forgery Detection by DWT"
- Navneet Kaur and Nitish Mahajan, "Fabrication Detection by PCA"
- Mohammad V. Malakooti Ahmad, "Forgery Detection by SVD"
- Rajeev Rajkumar Kh. Manglem, "Forgery Detection by SIFT"
- Ramesh Chand Pandey Rishabh Agrawal, "Forgery Detection by SURF"
- And other references included in the document.

