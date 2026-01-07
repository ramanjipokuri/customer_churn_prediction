DROP TABLE IF EXISTS customer_churn;

CREATE TABLE customer_churn (
    customer_id BIGINT,
    geography TEXT,
    gender TEXT,
    age INT,
    credit_score INT,
    tenure INT,
    balance NUMERIC,
    num_of_products INT,
    has_cr_card INT,
    is_active_member INT,
    estimated_salary NUMERIC,
    exited INT
);

select count(*) from customer_churn;

select exited, count(*) from customer_churn group by exited;

-- KPI 1: Total Customers -- 

select count(customer_id) as Total_Customers from customer_churn;

-- KPI 2: Churned Customers --

select count(customer_id) as Churned_Customers from customer_churn where exited = 1;

-- KPI 3: Active Customers (Not Churned) -- 

select count(customer_id) as Active_Customers from customer_churn where exited = 0;

-- KPI 4: Churn Rate (%) -- 

select round(count(case when exited = 1 then 1 end) * 100.0 / count(customer_id), 2) as Churn_rate_percentage from customer_churn;

-- KPI 5: Retention Rate (%) --

select round(count(case when exited = 0 then 1 end) * 100.0 / count(customer_id), 2) as Retention_rate_percantage from customer_churn;

-- KPI 6: Churn vs Retained Distribution --

select exited, count(customer_id) as Customer_count from customer_churn group by exited;

-- KPI 7: Churn Rate by Geography (IMPORTANT) -- 

select geography, count(case when exited = 1 then 1 end) as Churned_customers,
		count(customer_id) as Total_customers, 
		round(count(case when exited = 1 then 1 end ) * 100.0 / count(customer_id), 2) 
		as Churned_rate_percentage 
from customer_churn
group by geography
order by Churned_rate_percentage desc;

-- KPI 8: Churn Rate by Gender -- 

select gender, count(case when exited = 1 then 1 end) as Churned_customers,
		count(customer_id) as Total_customers, 
		round(count(case when exited = 1 then 1 end ) * 100.0 / count(customer_id), 2) 
		as Churned_rate_percentage 
from customer_churn
group by gender;


-- KPI 9: Churn Rate by IsActiveMember -- 

select is_active_member, count(case when exited = 1 then 1 end) as Churned_customers,
		count(customer_id) as Total_customers, 
		round(count(case when exited = 1 then 1 end ) * 100.0 / count(customer_id), 2) 
		as Churned_rate_percentage 
from customer_churn
group by is_active_member;

-- I calculated churn KPIs in SQL including total customers, churn rate, retention rate, and churn segmentation by geography, gender, and activity status. --


-- CASE WHEN – CUSTOMER SEGMENTATION --
-- Dividing customers based on age groups --
-- CASE WHEN allows us to create derived columns for analysis.--
select
    customer_id,
    age,
    case
        when age < 30 then 'Under 30'
        when age between 30 and 39 then '30-39'
        when age between 40 and 49 then '40-49'
        else '50+'
    end as age_group,
    exited
from customer_churn
limit 10;

-- CTE (WITH) – CLEAN & READABLE SQL --
-- Churn rate by geography using CTE --
-- CTEs improve query readability and allow step-by-step transformations --

with churn_geo as (
    select
        geography,
        count(*) as total_customers,
        count(case when exited = 1 then 1 end) as churned_customers
    from customer_churn
    group by geography
)
select
    geography,
    total_customers,
    churned_customers,
    ROUND(churned_customers * 100.0 / total_customers, 2) as churn_rate_pct
from churn_geo
order by churn_rate_pct desc;

-- WINDOW FUNCTION – OVER() --
-- Compare each geography’s churn with overall churn --
-- Window functions allow calculations across result sets without collapsing rows --

select
    geography,
    count(case when exited = 1 then 1 end) as churned_customers,
    round(
        count(case when exited = 1 then 1 end) * 100.0 /
        sum(count(case when exited = 1 then 1 end)) over (),
        2
    ) as churn_contribution_pct
from customer_churn
group by geography;

-- RANKING – Top Churn Regions -- 
-- Rank regions by churn rate --
-- RANK() helps identify top churn-prone regions --

WITH churn_geo AS (
    SELECT
        geography,
        COUNT(*) AS total_customers,
        COUNT(CASE WHEN exited = 1 THEN 1 END) AS churned_customers
    FROM customer_churn
    GROUP BY geography
)
SELECT
    geography,
    ROUND(churned_customers * 100.0 / total_customers, 2) AS churn_rate,
    RANK() OVER (
        ORDER BY churned_customers * 1.0 / total_customers DESC
    ) AS churn_rank
FROM churn_geo;

-- WINDOW FUNCTION – PARTITION BY --
-- Churn rate within each gender --
-- PARTITION BY allows group-level calculations without GROUP BY collapse --

SELECT
    gender,
    geography,
    COUNT(CASE WHEN exited = 1 THEN 1 END) AS churned_customers,
    ROUND(
        COUNT(CASE WHEN exited = 1 THEN 1 END) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY gender),
        2
    ) AS churn_pct_within_gender
FROM customer_churn
GROUP BY gender, geography
ORDER BY gender;

-- TOP-N HIGH-RISK CUSTOMERS --
-- Identify top 10 high-balance churned customers --
-- This helps retention teams target high-value churned customers --

SELECT
    customer_id,
    geography,
    age,
    balance
FROM customer_churn
WHERE exited = 1
ORDER BY balance DESC
LIMIT 10;

-- ADVANCED KPI – CHURN RATE BY AGE GROUP -- 
-- CTEs + CASE WHEN simplify complex segmentation logic -- 

WITH age_segments AS (
    SELECT
        CASE
            WHEN age < 30 THEN 'Under 30'
            WHEN age BETWEEN 30 AND 39 THEN '30-39'
            WHEN age BETWEEN 40 AND 49 THEN '40-49'
            ELSE '50+'
        END AS age_group,
        exited
    FROM customer_churn
)
SELECT
    age_group,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN exited = 1 THEN 1 END) AS churned_customers,
    ROUND(
        COUNT(CASE WHEN exited = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM age_segments
GROUP BY age_group
ORDER BY churn_rate_pct DESC;

-- I used advanced SQL techniques such as
-- CTEs, CASE statements, and window functions to analyze customer churn patterns, 
-- rank high-risk segments, and compute churn contributions across regions and demographics