# Customer Churn Prediction & Retention Analytics

An end-to-end Machine Learning project that predicts customer churn using historical telecom customer data and provides a foundation for data-driven customer retention analytics.

The project combines **Python, Pandas, Scikit-learn, FastAPI, and Flutter Web** to build a machine learning application with a production-oriented architecture.

---

## Project Overview

Customer churn occurs when customers discontinue a company's services. Identifying customers who are likely to leave helps businesses take proactive steps to improve customer retention.

This project uses the IBM Telco Customer Churn dataset to:

* Explore historical customer churn patterns.
* Perform data preprocessing and feature engineering.
* Train and compare multiple machine learning models.
* Predict the likelihood of customer churn.
* Provide predictions through a REST API.
* Develop an interactive analytics dashboard.

The long-term goal is to build a complete customer churn analytics application that combines predictive modelling with actionable retention insights.

## Current Development Status

**Overall Status: In Development**

| Component                          | Status      |
| ---------------------------------- | ----------- |
| Dataset collection                 | Completed   |
| Exploratory Data Analysis          | Completed   |
| Data preprocessing                 | Completed   |
| ML model comparison                | Completed   |
| Model evaluation                   | Completed   |
| Model serialization using Joblib   | Completed   |
| Reusable prediction module         | Completed   |
| Prediction function verification   | Completed   |
| FastAPI backend                    | Implemented |
| API health endpoint                | Implemented |
| API input validation               | Implemented |
| Flutter Web project initialization | Completed   |
| Dashboard foundation and sidebar   | In Progress |
| Dashboard KPI cards                | Planned     |
| Interactive analytics charts       | Planned     |
| Customer prediction interface      | Planned     |
| Flutter–FastAPI integration        | Planned     |
| Retention insights                 | Planned     |
| Deployment                         | Planned     |
| Complete end-to-end testing        | Planned     |

---

## Technology Stack

### Machine Learning & Data Science

* Python
* NumPy
* Pandas
* Matplotlib
* Seaborn
* Scikit-learn
* Joblib
* Jupyter Notebook

### Backend

* FastAPI
* Uvicorn
* Pydantic
* REST API

### Frontend

* Flutter
* Dart
* Flutter Web

### Development Tools

* Visual Studio Code
* Jupyter Notebook
* Git
* GitHub

---

## Dataset

**Dataset:** IBM Telco Customer Churn

**Source:** IBM Telco Customer Churn Dataset

The dataset contains information about telecommunications customers, including:

* Customer demographics
* Account information
* Services subscribed to
* Contract details
* Monthly and total charges
* Customer tenure
* Churn status

### Dataset Information

| Property                    | Value            |
| --------------------------- | ---------------- |
| Total records               | 7,043            |
| Total columns               | 21               |
| Input features              | 19               |
| Target variable             | Churn            |
| Missing TotalCharges values | 11 blank entries |
| Duplicate records           | 0                |

### Target Distribution

| Customer Category | Records |
| ----------------- | ------: |
| No Churn          |   5,174 |
| Churn             |   1,869 |

The target variable is encoded as:

* No → 0
* Yes → 1

The `customerID` column is excluded from model training because it is an identifier rather than a predictive feature.

---

## Machine Learning Workflow

The machine learning workflow consists of the following stages:

1. Dataset loading and exploration.
2. Exploratory Data Analysis.
3. Handling missing values.
4. Separating numerical and categorical features.
5. Train-test splitting using stratification.
6. Building preprocessing pipelines.
7. Comparing multiple classification algorithms.
8. Selecting the best-performing model.
9. Evaluating the final model.
10. Saving the trained pipeline using Joblib.

### Data Preprocessing

Numerical features:

* Median imputation
* Standard scaling

Categorical features:

* Most-frequent imputation
* One-hot encoding

A Scikit-learn `ColumnTransformer` combines both preprocessing pipelines.

Preprocessing and classification are integrated into a single Scikit-learn Pipeline to ensure consistent transformations during training and prediction.

### Models Evaluated

The following classification algorithms were compared:

1. Logistic Regression
2. Decision Tree
3. Random Forest
4. Support Vector Machine (SVM)

Model comparison was performed using 5-fold stratified cross-validation.

### Model Comparison Results

| Model               | Accuracy | Precision | Recall | F1-Score | ROC-AUC |
| ------------------- | -------: | --------: | -----: | -------: | ------: |
| Logistic Regression |   0.7488 |    0.5174 | 0.8013 |   0.6286 |  0.8460 |
| SVM                 |   0.7504 |    0.5197 | 0.7799 |   0.6236 |  0.8267 |
| Random Forest       |   0.7774 |    0.5712 | 0.6468 |   0.6065 |  0.8237 |
| Decision Tree       |   0.7430 |    0.5159 | 0.5037 |   0.5096 |  0.6668 |

**Selected Model: Logistic Regression**

Logistic Regression was selected based on its F1-score and recall performance.

### Final Model Evaluation

The selected model was evaluated on a separate test dataset.

| Metric    |  Score |
| --------- | -----: |
| Accuracy  | 0.7374 |
| Precision | 0.5034 |
| Recall    | 0.7834 |
| F1-Score  | 0.6130 |
| ROC-AUC   | 0.8414 |

These results represent the current baseline model performance.

The model prioritizes identifying potential churn customers, reflected in its higher churn-class recall.

---

## Project Architecture

The application follows a modular architecture separating data science experimentation, production machine learning logic, backend services, and frontend presentation.

```text
                    CUSTOMER CHURN
                  PREDICTION SYSTEM
                          |
             +------------+------------+
             |                         |
        DATA SCIENCE               APPLICATION
             |                         |
      Jupyter Notebooks           Flutter Web
             |                         |
       Data Analysis             Analytics Dashboard
             |                         |
       Preprocessing             REST API Requests
             |                         |
       Model Training                 FastAPI
             |                         |
       Model Evaluation          Prediction Endpoint
             |                         |
       Joblib Model <------------------+
             |
       Churn Prediction
```

### Application Flow

1. Customer information is entered through the Flutter interface.
2. Flutter sends the customer data to the FastAPI backend.
3. FastAPI validates the incoming request using Pydantic.
4. The saved machine learning pipeline processes the input.
5. The model generates a churn prediction and probability.
6. FastAPI returns the prediction as JSON.
7. Flutter displays the prediction and relevant insights.

Historical analytics and individual customer predictions will be handled separately.

---

## Repository Structure

```text
customer-churn-prediction/
│
├── data/
│   ├── raw/
│   │   └── Telco-Customer-Churn.csv
│   │
│   └── processed/
│
├── notebooks/
│   ├── 01_eda.ipynb
│   ├── 02_preprocessing.ipynb
│   └── 03_modeling.ipynb
│
├── src/
│   ├── __init__.py
│   ├── data_loader.py
│   ├── evaluate.py
│   ├── predict.py
│   ├── preprocessing.py
│   └── train.py
│
├── models/
│   └── churn_pipeline.joblib
│
├── api/
│   ├── __init__.py
│   └── app.py
│
├── frontend/
│   ├── lib/
│   │   └── main.dart
│   ├── web/
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
│
├── tests/
│   ├── __init__.py
│   └── test_prediction.py
│
├── requirements.txt
├── README.md
├── LICENSE
└── .gitignore
```

---

## Backend API

The backend is developed using FastAPI.

### Available Endpoints

| Method | Endpoint   | Description            |
| ------ | ---------- | ---------------------- |
| GET    | `/`        | API welcome message    |
| GET    | `/health`  | API health status      |
| POST   | `/predict` | Predict customer churn |

### Prediction Request

The `/predict` endpoint accepts customer information in JSON format.

Example:

```json
{
  "gender": "Female",
  "SeniorCitizen": 0,
  "Partner": "Yes",
  "Dependents": "No",
  "tenure": 12,
  "PhoneService": "Yes",
  "MultipleLines": "No",
  "InternetService": "DSL",
  "OnlineSecurity": "No",
  "OnlineBackup": "Yes",
  "DeviceProtection": "No",
  "TechSupport": "No",
  "StreamingTV": "No",
  "StreamingMovies": "No",
  "Contract": "Month-to-month",
  "PaperlessBilling": "Yes",
  "PaymentMethod": "Electronic check",
  "MonthlyCharges": 65.5,
  "TotalCharges": 786.0
}
```

`TotalCharges` can also be omitted or provided as `null`.

### Prediction Response

```json
{
  "prediction": "Churn",
  "churn_probability": 0.5462
}
```

The probability represents the model's estimated likelihood of customer churn.

### API Documentation

FastAPI automatically generates interactive API documentation.

Once the backend is running, access:

* Swagger UI: `http://127.0.0.1:8000/docs`
* ReDoc: `http://127.0.0.1:8000/redoc`

---

## Installation and Setup

### Prerequisites

Install the following:

* Python
* Flutter SDK
* Dart SDK (included with Flutter)
* Google Chrome
* Git

### 1. Clone the Repository

```bash
git clone https://github.com/Pranay-Pandurang-Patil/customer-churn-prediction.git

cd customer-churn-prediction
```

### 2. Set Up Python Environment

Create a virtual environment:

```bash
python -m venv .venv
```

Activate it on Windows:

```bash
.venv\Scripts\activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

### 3. Run the FastAPI Backend

From the project root:

```bash
python -m uvicorn api.app:app --reload
```

The backend will run at:

```text
http://127.0.0.1:8000
```

### 4. Run the Flutter Web Frontend

Open another terminal:

```bash
cd frontend
```

Install Flutter dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run -d chrome
```

---

## Future Enhancements

The following features are planned for subsequent development.

### 1. Interactive Analytics Dashboard

* Total customer count.
* Churned and retained customer counts.
* Overall churn rate.
* Model performance indicators.
* Interactive charts and visualizations.

### 2. Customer Churn Prediction

* Customer information input form.
* Individual churn prediction.
* Churn probability visualization.
* Risk classification.

### 3. Retention Insights

* Identify important churn patterns.
* Highlight high-risk customer segments.
* Generate actionable retention recommendations.

### 4. Frontend and Backend Integration

* Connect Flutter Web with FastAPI.
* Display real-time prediction responses.
* Implement loading and error states.

### 5. Deployment

* Deploy the FastAPI backend.
* Deploy the Flutter Web application.
* Configure production API connectivity.

### 6. Final Testing

* Prediction module testing.
* API endpoint testing.
* Input validation testing.
* Frontend testing.
* End-to-end integration testing.

---

## Limitations

* The current model uses historical telecom customer data.
* Model predictions are estimates and not guarantees of customer behavior.
* Current model performance is a baseline and can be improved.
* Retention recommendations are planned and are not yet implemented.
* The application is currently under development and is not deployed.

---

## Author

**Pranay Pandurang Patil**

Computer Science and Engineering Student

GitHub: [Pranay-Pandurang-Patil](https://github.com/Pranay-Pandurang-Patil)

Project Repository: [Customer Churn Prediction & Retention Analytics](https://github.com/Pranay-Pandurang-Patil/customer-churn-prediction)

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
