# 📊 Customer Churn Prediction & Analytics System (End-to-End)

This is an end-to-end **Customer Churn Prediction and Analytics project** built using **Python, Machine Learning, PostgreSQL, SQL, Power BI, and Streamlit**.

The project simulates a real-world data science workflow — from raw data ingestion to analytics, machine learning, dashboarding, and live deployment.

---

## 🚀 Live Project Links

- 🔗 **Streamlit App (Churn Prediction)**  
  https://customerchurnprediction-mhraqwcdps8vxb2wk69nqv.streamlit.app/

- 📊 **Power BI Dashboard (Churn Analytics & Storytelling)**  
  https://app.powerbi.com/groups/me/reports/288c3f78-58cb-444a-a999-df270761f1bb/34eec787aaac552a0c03?experience=power-bi

---

## 🧠 Problem Statement

Customer churn is a major challenge in the banking industry. Retaining existing customers is more cost-effective than acquiring new ones.

### Project Goals:
- Predict which customers are likely to churn
- Identify key churn drivers
- Provide actionable insights for retention strategies

---

## 🏗️ End-to-End Architecture

CSV Dataset
--->
PostgreSQL Database
--->
SQL (KPIs & Advanced Analytics)
--->
Python (EDA, Feature Engineering, ML Models)
--->
Power BI (Dashboards & Storytelling)
--->
Streamlit (Live Prediction App)


---

## 🗂️ Dataset Overview

- **Records:** 10,000 customers
- **Target Variable:** `Exited`
  - 1 → Churned
  - 0 → Retained

### Key Features:
- Geography
- Gender
- Age
- Credit Score
- Balance
- Number of Products
- IsActiveMember
- Estimated Salary

---

## 🛠️ Tech Stack

### Programming & ML
- Python
- Pandas, NumPy
- Scikit-learn

### Database & SQL
- PostgreSQL
- pgAdmin
- Advanced SQL (CTEs, Window Functions)

### BI & Visualization
- Power BI

### Deployment
- Streamlit
- GitHub

---

## 🐘 PostgreSQL & SQL Implementation

PostgreSQL was used to simulate a real-world analytics database.

### What was done:
- Created relational tables for churn data
- Loaded CSV data into PostgreSQL
- Performed data validation and sanity checks
- Built SQL KPIs and advanced analytical queries

### SQL Techniques Used:
- Aggregations (`COUNT`, `AVG`)
- Conditional logic (`CASE WHEN`)
- CTEs (`WITH`)
- Window functions (`OVER`, `PARTITION BY`)
- Ranking (`RANK()`)

---

## 🤖 Machine Learning Approach

### Models Trained:
- Logistic Regression
- Balanced Logistic Regression
- Random Forest Classifier

### Final Model:
- Optimized Random Forest
- Selected based on precision–recall trade-offs
- Hyperparameters tuned to reduce model size for deployment

### Key ML Concepts:
- Class imbalance handling
- Feature scaling
- Model evaluation beyond accuracy
- Deployment-aware optimization

---

## 📊 Power BI Dashboard

The Power BI dashboard has two pages:

### Page 1: Churn Overview
- Total Customers
- Churned Customers
- Active Customers
- Churn Rate %
- Churn by Geography, Age Group, Gender, Activity Status

### Page 2: Insights & Business Actions
- Key churn drivers
- High-risk customer segments
- Actionable business recommendations

---

## 🌐 Streamlit Deployment

- Built an interactive Streamlit web application
- Users can enter customer details and predict churn
- Demonstrates end-to-end ownership from data to deployment

---

## ⚠️ Challenges Faced & How They Were Solved

### 1. PostgreSQL CSV Import Errors
- Column mismatch
- Incorrect column order
- Data type conflicts

**Solution:**
- Cleaned CSV file
- Reordered columns to match schema
- Recreated tables with safe data types

---

### 2. Model File Size Issue
- Random Forest model exceeded GitHub’s 25MB limit

**Solution:**
- Reduced model complexity
- Used joblib compression
- Optimized model size without major performance loss

---

### 3. Deployment Serialization Issues
- Mismatch between pickle and joblib

**Solution:**
- Standardized model saving and loading approach

---

## 📈 Results & Business Impact

- Achieved ~85% model accuracy
- Identified key churn drivers:
  - Geography (Germany)
  - Age group (40–49)
  - Inactive customers
  - High-balance customers
- Provided actionable retention strategies

---

## 🧠 Key Learnings

- Real-world projects require debugging and trade-offs
- SQL + BI + ML integration is critical for impact
- Storytelling is as important as modeling

---

## 📌 Conclusion

This project demonstrates end-to-end data science and analytics capabilities, covering data ingestion, SQL analytics, machine learning, business dashboards, and deployment.

---

## 👤 Author

**Ramanji Pokuri**  
Aspiring Data Scientist / Data Analyst  

🔗 LinkedIn: https://www.linkedin.com/in/venkata-ramanajaneyulu-pokuri-4b35b6232/
