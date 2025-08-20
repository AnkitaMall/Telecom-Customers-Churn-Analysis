📊 Telecom Customer Churn Analysis
📌 Project Overview

Customer churn is a major challenge in the telecom industry, as retaining existing customers is often more cost-effective than acquiring new ones. This project focuses on analyzing telecom customer data to identify the factors that contribute to churn and predicting which customers are at high risk of leaving.

The analysis combines EDA, feature engineering, risk profiling, and churn prediction modeling to provide actionable business insights.

🎯 Objectives

Analyze customer behavior and demographics to understand churn drivers.

Perform Exploratory Data Analysis (EDA) to uncover patterns.

Engineer features like tenure groups and monthly charge bins for deeper insights.

Develop a High-Risk Scoring system to segment customers by churn probability.

Provide business recommendations to reduce churn.

📂 Dataset

The dataset contains customer-level information from a telecom company, including:

📞 Customer demographics (gender, senior citizen, partner, dependents)

📶 Services (phone, multiple lines, internet, online security, streaming, etc.)

💳 Account information (tenure, contract type, payment method, charges)

🎯 Churn (Yes/No — target variable)

🔍 Exploratory Data Analysis (EDA)

Key insights from data analysis:

Churn Rate: ~26% of customers have churned.

Tenure: Customers in the first 12 months are the most likely to churn.

Monthly Charges: Higher charges are strongly correlated with churn.

Contract Type: Month-to-month contracts show the highest churn, while 2-year contracts are the most stable.

Payment Method: Customers using electronic checks churn the most.

Internet Service: Fiber optic users churn more than DSL users.

🛠 Feature Engineering & Risk Factors

Tenure Groups: Segmented into bins (0–12 months, 13–24 months, etc.).

Monthly Charge Bins: Customers categorized into low, medium, and high spenders.

Risk Factors: High churn risk associated with:

Low tenure (0–12 months)

High monthly charges

Month-to-month contracts

Electronic check payment

Fiber optic internet service

📊 High-Risk Customer Profile
Factor	High-Risk Category	Low-Risk Category
Tenure	0–12 months	24+ months
Monthly Charges	High charges	Low charges
Contract Type	Month-to-month	2-year contract
Payment Method	Electronic check	Auto-pay (credit/bank)
Internet Service	Fiber optic	DSL / No Internet
⚙️ Tech Stack

Python 🐍

Pandas, NumPy → Data manipulation

Matplotlib, Seaborn → Visualization

Scikit-learn → Machine learning models (Logistic Regression, Decision Trees, etc.)

Tableau / Power BI → Dashboard for interactive insights

📈 Model Performance

Built predictive models to classify churn.

Achieved accuracy of X% and ROC-AUC score of Y% (replace with your actual metrics).

Logistic Regression and Decision Tree provided interpretable insights for business users.

💡 Business Recommendations

Retention Offers: Provide discounts for customers with high monthly charges.

Contract Migration: Encourage month-to-month users to switch to yearly contracts with incentives.

Payment Optimization: Promote auto-pay options to reduce churn risk.

Fiber Optic Plans: Improve pricing/quality to reduce churn among fiber optic users.

Onboarding Support: Focus retention efforts on customers in their first 12 months.

📌 Dashboard

Created an interactive dashboard (Tableau) showing:

Churn rate overview

Key factors contributing to churn
