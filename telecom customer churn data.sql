create schema teleco_customer_churn;
rename table `wa_fn-usec_-telco-customer-churn (1)` to customers;       -- not in standard name convention
select count(*) from customers;                                         -- having 7032 rows data
describe customers;                                                     -- customerID datatype text

select MAX(CHAR_LENGTH(customerID)) as max_length from customers;     
alter table customers modify customerID varchar(15) not null;

SELECT 
    SUM(CASE WHEN customerID IS NULL THEN 1 ELSE 0 END) AS null_customerID,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN SeniorCitizen IS NULL THEN 1 ELSE 0 END) AS null_SeniorCitizen,
    SUM(CASE WHEN Partner IS NULL THEN 1 ELSE 0 END) AS null_Partner,
    SUM(CASE WHEN Dependents IS NULL THEN 1 ELSE 0 END) AS null_Dependents,
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS null_tenure,
    SUM(CASE WHEN PhoneService IS NULL THEN 1 ELSE 0 END) AS null_PhoneService,
    SUM(CASE WHEN MultipleLines IS NULL THEN 1 ELSE 0 END) AS null_MultipleLines,
    SUM(CASE WHEN InternetService IS NULL THEN 1 ELSE 0 END) AS null_InternetService,
    SUM(CASE WHEN OnlineSecurity IS NULL THEN 1 ELSE 0 END) AS null_OnlineSecurity,
    SUM(CASE WHEN OnlineBackup IS NULL THEN 1 ELSE 0 END) AS null_OnlineBackup,
    SUM(CASE WHEN DeviceProtection IS NULL THEN 1 ELSE 0 END) AS null_DeviceProtection,
    SUM(CASE WHEN TechSupport IS NULL THEN 1 ELSE 0 END) AS null_TechSupport,
    SUM(CASE WHEN StreamingTV IS NULL THEN 1 ELSE 0 END) AS null_StreamingTV,
    SUM(CASE WHEN StreamingMovies IS NULL THEN 1 ELSE 0 END) AS null_StreamingMovies,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS null_Contract,
    SUM(CASE WHEN PaperlessBilling IS NULL THEN 1 ELSE 0 END) AS null_PaperlessBilling,
    SUM(CASE WHEN PaymentMethod IS NULL THEN 1 ELSE 0 END) AS null_PaymentMethod,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS null_MonthlyCharges,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_TotalCharges,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS null_Churn
FROM customers;                                                               -- not null values

select customerID, COUNT(*) AS cnt          
from customers
GROUP BY customerID
HAVING cnt > 1;                                                               -- no duplicates

-- checking outlier
  -- for categorial columns
select distinct gender from customers;
select distinct partner from customers;
select distinct SeniorCitizen from customers;
select distinct dependents from customers;
select distinct PhoneService from customers;
select distinct MultipleLines from customers;
select distinct InternetService from customers;
select distinct OnlineSecurity from customers;
select distinct OnlineBackup from customers;
select distinct DeviceProtection from customers;
select distinct TechSupport from customers;
select distinct StreamingTV from customers;
select distinct StreamingMovies from customers;
select distinct Contract from customers;
select distinct PaperlessBilling from customers;
select distinct PaymentMethod from customers;
select distinct Churn from customers;


-- for numeric columns
select min(MonthlyCharges), max(MonthlyCharges) from customers;
select min(tenure), max(tenure) from customers;
select min(TotalCharges), max(TotalCharges) from customers;         -- no outlier


-- Basic Customer Count & Churn Rate
select count(*) as total_cust from customers;

select churn, count(*) as count, ROUND(count(*) * 100 / (select COUNT(*) from customers), 2) as percentage
from customers
group by churn;


-- Churn by Gender
select gender, churn, count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by gender, churn;


-- churn by service
select InternetService, churn , count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by InternetService, churn;


-- churn by tenure
select case 
         when tenure <= 12 then 'one-year'
         when tenure <=24 then 'two-years'
         when tenure <=36 then 'three-years'
         else 'more than 3 years'
	   end as tenure_group,
churn, count(*) as count, round(count(*)*100/(select count(*) from customers),2) as percentage
from customers
group by tenure_group, churn
order by tenure_group;        


-- churn by service (convert each individual charges into bin)
SELECT 
    CASE
        WHEN MonthlyCharges <= 90 THEN '0-90'
        WHEN MonthlyCharges <= 100 THEN '91-100'
        WHEN MonthlyCharges <= 110 THEN '101-110'
        ELSE '110+'
    END AS MonthlyCharges_range, 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churn_count,
    ROUND(
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS churn_percentage
FROM customers
GROUP BY 
    CASE
        WHEN MonthlyCharges <= 90 THEN '0-90'
        WHEN MonthlyCharges <= 100 THEN '91-100'
        WHEN MonthlyCharges <= 110 THEN '101-110'
        ELSE '110+'
    END
ORDER BY MonthlyCharges_range;


-- Churn by seniorcitizen
select SeniorCitizen, churn, count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by SeniorCitizen, churn;


-- Churn by partner
select Partner, churn, count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by Partner, churn;


-- Churn by dependents
select Dependents, churn, count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by Dependents, churn;


-- Churn by phoneservice
select PhoneService, churn, count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by PhoneService, churn;


-- Churn by multiplelines
select MultipleLines, churn, count(*) as count, round(count(*) * 100/(select count(*) from customers),2) as percentage
from customers
group by SeniorCitizen, churn;

select * from customers;
  
-- identify risk factor
SELECT customerID,
       (CASE WHEN Contract = 'Month-to-month' THEN 1 ELSE 0 END +
        CASE WHEN InternetService = 'Fiber optic' THEN 1 ELSE 0 END +
        CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END +
        CASE WHEN MonthlyCharges > 70 THEN 1 ELSE 0 END +
        CASE WHEN tenure <= 12 THEN 1 ELSE 0 END) AS RiskScore
FROM customers
ORDER BY RiskScore DESC
LIMIT 10;






  

