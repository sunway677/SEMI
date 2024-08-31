Incomplete Multi-View Clustering via Structure Exploration and Missing-view Inference (SEMI)
This repository contains the official MATLAB implementation of the paper "Incomplete Multi-View Clustering via Structure Exploration and Missing-view Inference" by Ziyu Wang, Lusi Li, Xin Ning, Wenkai Tan, Yongxin Liu, and Houbing Song.

Overview
Incomplete Multi-View Clustering (IMVC) aims to enhance clustering performance by capturing complementary information from incomplete multi-views, where some data samples in one or more views are missing. This method introduces Structure Exploration and Missing-view Inference (SEMI), a novel approach that explores global, local, consistent, and inconsistent structures of data while guiding the inference of missing views.

Key Features
Global Structure Exploration: Utilizes self-expression subspace learning to explore the relationships among all data samples across views.
Local Structure Learning: Ensures genuine relationship information among non-missing samples by integrating graph learning.
Consistent and Inconsistent Structure Learning: Decomposes the unified coefficient matrix to handle noise, errors, and biases effectively.
Missing-view Inference: Iteratively imputes missing samples under the guidance of the explored structures, reinforcing clustering performance.
Requirements
MATLAB R2023a or later
Installation
Clone the repository to your local machine:

bash
Copy code
git clone https://github.com/yourusername/SEMI.git
cd SEMI
Ensure that all necessary toolboxes (such as Statistics and Machine Learning Toolbox) are installed in your MATLAB environment.

Usage
Data Preparation
Prepare your dataset in the required format. The dataset should contain multiple views with some missing data points. You can refer to the sample data files provided in the /data directory for guidance on the format.

Running the Code
To run the SEMI model on your data, execute the following script in MATLAB:

matlab
Copy code
main('data_path', './data/your_dataset', 'missing_ratio', 0.1, 'num_clusters', 5);
Replace your_dataset with the path to your dataset. Adjust missing_ratio and num_clusters based on your requirements.

Parameters
data_path: Path to the dataset directory.
missing_ratio: Ratio of missing data in the views (default: 0.1).
num_clusters: Number of clusters for clustering (default: 5).
Results
The results of the clustering process, including Accuracy (ACC), Normalized Mutual Information (NMI), and Purity, will be displayed in the MATLAB console. Example output:

makefile
Copy code
ACC: 0.803
NMI: 0.720
Purity: 0.893
Citation
If you find this work useful in your research, please consider citing:

sql
Copy code
@article{wang2024semi,
  title={Incomplete Multi-View Clustering via Structure Exploration and Missing-view Inference},
  author={Wang, Ziyu and Li, Lusi and Ning, Xin and Tan, Wenkai and Liu, Yongxin and Song, Houbing},
  journal={Journal of Information Fusion},
  year={2024}
}
License
This project is licensed under the MIT License. See the LICENSE file for more details.

Acknowledgments
This work was supported by the National Science Foundation under Grant 2245918.
