A. Overall Churn Metrics

-- 1. What is the overall churn rate?
SELECT 
     ROUND(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)*100 / COUNT(*),2) AS Churn_rate 
FROM customer_churn_new;


-- 2. What is the number of churned customers?
SELECT COUNT(*)
FROM customer_churn_new
WHERE Exited = 1;


-- 3. What is the total number of customers?
SELECT COUNT(*)
FROM customer_churn_new;



B. Customer Segmentation
  
-- 4. What is the churn rate by age group?
SELECT 
      CASE
         WHEN Age BETWEEN 18 AND 30 THEN 'Young 18-30'
         WHEN Age BETWEEN 31 AND 60 THEN 'Middle_Age 31-60'
         WHEN Age BETWEEN 61 AND 92 THEN 'Senior 61-92'
	  END AS Age_group, 
      COUNT(*) AS Customer_Count,
      SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customer_churn,
      ROUND(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)*100 / COUNT(*),2) AS Churn_rate 
FROM customer_churn_new
GROUP BY Age_group
ORDER BY Churn_rate;





C. Financial drivers of churn

--5. Are low balance customers likely to churn?

SELECT 
      CASE
         WHEN Balance BETWEEN 0 AND 50000 THEN 'Low_balance 0-50k'
         WHEN Balance BETWEEN 50001 AND 150000 THEN 'Medium_balance >50k-150k'
         ELSE 'High_balance >150k+'
	  END AS BalanceBracket,
      ROUND(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS Churn_rate
FROM customer_churn_new
GROUP BY BalanceBracket
ORDER BY Churn_rate DESC;

--6. Does credit score influence churn?

SELECT 
      CASE
         WHEN CreditScore BETWEEN 0 AND 450 THEN 'Low 0-450'
         WHEN CreditScore BETWEEN 451 AND 700 THEN 'Medium 451-700'
         ELSE 'High 701+'
	  END AS CreditScoreBracket,
      ROUND(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)*100.0 / COUNT(*),2)  AS Churn_rate
FROM customer_churn_new
GROUP BY CreditScoreBracket
ORDER BY Churn_rate DESC;






