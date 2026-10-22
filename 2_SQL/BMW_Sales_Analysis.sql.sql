-- =========================
-- 1.
-- =============
--  DATA SETUP
-- =============
-- =========================
use project;

SHOW TABLES;
 
-- =======================================
-- 2.
-- ================
--  DATA OVERVIEW
-- ================
-- =======================================

DESCRIBE project.`bmw sales data (2010-2024)`;

 -- ============================
 -- 1. FIRST 10 RECORDS
 -- ============================
select * from project.`bmw sales data (2010-2024)`
limit 100;


-- =============================
-- 2. TOTAL ROWS
-- =============================
select Count(*) as Total_Records 
from project.`bmw sales data (2010-2024)`;


-- ==============================
-- 3. Basic Data Profile
-- ==============================
Select 
count(*) as total_Records,
count(distinct Model) as Total_Models,
count(distinct Region) as Toatal_Regions,
count(distinct Color) as Total_Colors,
count(Distinct Fuel_type) as Total_Fuel_types,
count(Distinct Transmission) as Total_Transmissions,
count(Distinct Sales_Classification) as Total_Classification,
Min(Year) as First_year,
Max(year) as Last_year
from project.`bmw sales data (2010-2024)`;

-- ====================================
-- 3.
-- =======================
--  DATA QUALITY AUDIT
-- =======================
-- ====================================


-- ================================
-- 1. NULL VALUE CHECK
-- ================================
Select count(*) as Total_Rows,
count(Model) as Model_Count,
count(Region) as Region_Count,
count(Color) as Color_count,
count(Fuel_Type) as Fuel_type_Count,
count(Transmission) as Transmission_count,
count(Engine_size_L) as Engine_size_L_Count,
count(Mileage_KM) as Mileage_KM_Count,
count(Price_USd) as Price_USd_Count,
count(Sales_Volume) as Sales_Volume_Count,
Count(Sales_Classification) as Sales_Classification_Count
from project.`bmw sales data (2010-2024)`;


-- ===================================
-- 2. DUPLICATE CHECK
-- ===================================

SELECT
    COUNT(*) AS Duplicate_Rows
FROM (
    SELECT
        Model,
        Year,
        Region,
        Color,
        Fuel_Type,
        Transmission,
        Engine_Size_L,
        Mileage_KM,
        Price_USD,
        Sales_Volume,
        Sales_Classification,
        COUNT(*) AS Row_Count
    FROM project.`bmw sales data (2010-2024)`
    GROUP BY
        Model,
        Year,
        Region,
        Color,
        Fuel_Type,
        Transmission,
        Engine_Size_L,
        Mileage_KM,
        Price_USD,
        Sales_Volume,
        Sales_Classification
    HAVING COUNT(*) > 1
) AS Duplicate_Data;


-- =================================
-- 3. RANGE & VALIDATION CHECK 
-- =================================
Select
      Min(Year) as Min_Year,
      Max(Year) as MAx_Year,
      Min(Price_USd) as Min_Price,
      Max(Price_USD) as Max_Price,
       MIN(Mileage_KM) AS Min_Mileage,
    MAX(Mileage_KM) AS Max_Mileage,
    MIN(Sales_Volume) AS Min_Sales,
    MAX(Sales_Volume) AS Max_Sales
FROM project.`bmw sales data (2010-2024)`;

      
-- ============================
-- 4. INVALID CHECK TABLE
-- ============================
Select * 
from project.`bmw sales data (2010-2024)`
where price_usd <= 0
or Mileage_KM < 0
or Sales_Volume < 0
or Engine_Size_L < 0;

-- ===============================================
-- 4.
-- =======================================
-- KPI & BUSSINESS PERFORMANCE ANALYSES
-- =======================================
-- ===============================================

-- =============================
-- 5. OVERALL BUSSINESS KPI
-- =============================
Select
      Count(*) As Total_Records,
      Sum(Sales_Volume) As Total_sales_volume,
      sum(Price_usd * Sales_Volume) as Total_Revenue,
      Avg(Price_Usd) as Average_Price,
      Avg(Mileage_KM) as Average_Mileage,
      Avg(Sales_Volume) as Average_Sales_Volume_Per_Record
From project.`bmw sales data (2010-2024)`;


-- ========================================
-- 6. YEAR-WISE SALES PERFORMANCE
-- ========================================
Select
      year,
      Sum(Sales_volume) as Total_sales,
      Sum(Price_usd * Sales_Volume) as Total_Revenue,
      Avg(Price_USD) as Average_Price
From project.`bmw sales data (2010-2024)`
group by year
order by year;

-- ==========================================
-- 7. Region Wise Sales Performance
-- ==========================================
select
    Region,
    SUM(Sales_Volume) AS Total_Sales,
    SUM(Price_USD * Sales_Volume) AS Total_Revenue,
    AVG(Price_USD) AS Average_Price
FROM project.`bmw sales data (2010-2024)`
GROUP BY Region
ORDER BY Total_Sales DESC;

-- ==========================================
-- 8. MODEL- WISE SALES PERFORMANCE
-- ==========================================
Select 
      Model,
      Sum(Sales_Volume) as Total_Sales,
      Sum(Price_USD * Sales_Volume) as Total_Revenue,
      Avg(Price_USD) as Average_Price,
      count(*) as Total
from project.`bmw sales data (2010-2024)`
group by Model
order by Total_sales Desc;

-- =========================================
-- 4. 
-- =======================
-- PRODUCT & MARKET DEEP ANALYSIS
-- =======================
-- =========================================

-- ==============================
-- 9. FUEL TYPE PERFORMANCE
-- ==============================
SELECT 
	  FUEL_TYPE,
      SUM(SALES_VOLUME) AS TOTAL_SALES,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE,
      AVG(PRICE_USD) AS AVERAGE_PRICE,
      AVG(Mileage_KM) AS AVERAGE_MILEAGE
FROM project.`bmw sales data (2010-2024)`
group by Fuel_Type
order by TOTAL_SALES DESC;


-- ==================================
-- 10. TRANSMISSION PERFORMANCE
-- ==================================
SELECT
      TRANSMISSION,
      SUM(SALES_VOLUME) AS TOTAL_SALES,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE,
      AVG(PRICE_USD) AS AVERAGE_PRICE,
      AVG(MILEAGE_KM) AS AVERAGE_MILEAGE
FROM project.`bmw sales data (2010-2024)`
group by Transmission
order by TOTAL_SALES desc;


-- =====================================
-- 11. SALES PERFORMANCE ANALYSIS
-- =====================================
SELECT
    Sales_Classification,
    COUNT(*) AS Total_Records,
    SUM(Sales_Volume) AS Total_Sales,
    SUM(Price_USD * Sales_Volume) AS Total_Revenue,
    AVG(Price_USD) AS Average_Price
FROM project.`bmw sales data (2010-2024)`
group by Sales_Classification
order by Total_Sales DESC;


-- ============================================
-- 12. COLOR-WISE SALES PERFORMANCE
-- ============================================
SELECT
      COLOR,
      SUM(SALES_VOLUME) AS TOTAL_SALES,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE,
      AVG(PRICE_USD) AS AVERAGE_PRICE
FROM project.`bmw sales data (2010-2024)`
group by Color
order by TOTAL_SALES DESC;

-- =======================================
-- 5. 
-- =========================
-- ADVANCE SALES ANALYSIS
-- =========================
-- =======================================

-- ===================================
-- 13. TOP 10 BEST-SELLING BMW MODEL
-- ===================================
SELECT
      MODEL,
      SUM(SALES_VOLUME) AS TOTAL_SALES,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE,
      AVG(PRICE_USD) AS AVERAGE_USD
FROM project.`bmw sales data (2010-2024)`
group by Model
order by TOTAL_SALES DESC
LIMIT 10;

-- ===================================
-- 14. LOWEST-SELLING BMW MODELS
-- ===================================
SELECT
      MODEL,
      SUM(SALES_VOLUME) AS TOTAL_SALES,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE,
      AVG(PRICE_USD) AS AVERAGE_USD
FROM project.`bmw sales data (2010-2024)`
group by Model
order by TOTAL_SALES ASC
LIMIT 10;


-- ===================================================
-- 15. ABOVE-AVERAGE SELLING MODELS SUBQUERY
-- ===================================================
SELECT
      MODEL,
      SUM(SALES_VOLUME) AS TOTAL_SALES
FROM project.`bmw sales data (2010-2024)`
group by MODEL
HAVING SUM(Sales_Volume) > (
SELECT AVG(MODEL_SALES) 
FROM ( 
select SUM(Sales_VOLUME) AS MODEL_SALES
FROM project.`bmw sales data (2010-2024)`
group by MODEL
) AS MODEL_AVERAGE)
ORDER BY TOTAL_SALES DESC;


-- ======================================
-- 16. ABOVE AVERAGE PRICE MODELS
-- ======================================
SELECT
	 MODEL,
     AVG(PRICE_USD) AS AVERAGE_PRICE
FROM project.`bmw sales data (2010-2024)`
group by MODEL
having avg(Price_USD) > (
SELECT AVG(Price_USD) 
FROM project.`bmw sales data (2010-2024)`
) order by AVERAGE_PRICE DESC;


-- =================================================
-- 17. REGION WITH ABOVE-AVERAGE SALES
-- =================================================
SELECT
      REGION,
      SUM(SALES_VOLUME) AS TOTAL_SALES
FROM project.`bmw sales data (2010-2024)`
group by Region
having sum(SALES_VOLUME) > (
SELECT AVG(REGION_SALES) 
FROM (
SELECT SUM(SALES_VOLUME) AS REGION_SALES
FROM project.`bmw sales data (2010-2024)`
) AS SOMETHING
) order by TOTAL_SALES DESC;

-- =====================================================
-- 6. 
-- =============================================
-- ADVANCED SQL: REGION × MODEL ANALYSIS
-- =============================================
-- ======================================================


-- =========================================
-- 18. MODEL PERFORMANCE BY REGION 
-- =========================================
SELECT
      REGION,
      MODEL,
      SUM(SALES_VOLUME) AS TOTAL_SALES,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE,
      AVG(PRICE_USD) AS AVERAGE_PRICE
FROM project.`bmw sales data (2010-2024)`
group by Region,Model
order by Region, TOTAL_SALES DESC;


-- ===========================================
-- 19. TOP-SELLING MODEL IN EACH REGION
-- ===========================================
WITH MODEL_REGION_SALES AS (
SELECT REGION,
	   MODEL,
       SUM(SALES_VOLUME) AS TOTAL_SALES
FROM project.`bmw sales data (2010-2024)`
group by Region,Model),
RANKED_MODELS AS (
       SELECT 
       REGION,
       MODEL,
       TOTAL_SALES,
       RANK() OVER(
       PARTITION BY REGION 
	   ORDER by TOTAL_SALES DESC)
       AS  MODEL_RANK
       FROM MODEL_REGION_SALES)
SELECT
     REGION,
     MODEL,
     TOTAL_SALES,
     MODEL_RANK
FROM RANKED_MODELS
WHERE MODEL_RANK = 1
ORDER BY REGION;

-- ========================================
-- 20. REGION REVENUE CONTRIBUTION
-- ========================================
WITH REGION_REVENUE AS (
      SELECT 
      REGION,
      SUM(PRICE_USD * SALES_VOLUME) AS TOTAL_REVENUE
      FROM project.`bmw sales data (2010-2024)`
      group by REGION
)
SELECT 
      REGION,
      TOTAL_REVENUE,
      ROUND(100 * TOTAL_REVENUE /
      SUM(TOTAL_REVENUE) OVER (),
      2
      ) AS REVENUE_CONTRIBUTION_PCT
FROM REGION_REVENUE
order by REVENUE_CONTRIBUTION_PCT DESC;


-- =========================================
-- 21. MODEL REVENUE CONTRIBUTION
-- =========================================
WITH Model_Revenue AS (
    SELECT
	Model,
	SUM(Price_USD * Sales_Volume) AS Total_Revenue
    FROM project.`bmw sales data (2010-2024)`
    GROUP BY Model
)
SELECT
    Model,
    Total_Revenue,
    ROUND(
	100 * Total_Revenue /
	SUM(Total_Revenue) OVER (),
	2
    ) AS Revenue_Contribution_Pct
FROM Model_Revenue
ORDER BY Revenue_Contribution_Pct DESC;


-- ===========================================
-- 22. REGIONAL SALES RANKING
-- ===========================================
WITH REGION_SALES AS (
      SELECT 
      REGION,
      SUM(SALES_VOLUME) AS TOTAL_SALES
      FROM project.`bmw sales data (2010-2024)`
      group by REGION
)
SELECT
     REGION,
     TOTAL_SALES,
     RANK() OVER (
     ORDER BY TOTAL_SALES DESC
     ) AS SALES_RANK
FROM REGION_SALES
ORDER BY SALES_RANK;


-- ========================================
-- 23. YEAR-OVER-YEAR SALES GROWTH
-- ========================================
WITH Yearly_Sales AS (
    SELECT
	Year,
	SUM(Sales_Volume) AS Total_Sales
    FROM project.`bmw sales data (2010-2024)`
    GROUP BY Year
),
Sales_With_Previous_Year AS (
    SELECT
        Year,
        Total_Sales,
        LAG(Total_Sales) OVER (
		ORDER BY Year
        ) AS Previous_Year_Sales
    FROM Yearly_Sales
)
SELECT
    Year,
    Total_Sales,
    Previous_Year_Sales,
    ROUND(
	100 * (Total_Sales - Previous_Year_Sales)
	/ NULLIF(Previous_Year_Sales, 0),
	2
    ) AS YoY_Growth_Pct
FROM Sales_With_Previous_Year
ORDER BY Year;


-- =============================================
-- 24. CUMULATIVE SALES - RUNNING TOTAL
-- =============================================
WITH YEARLY_SALES AS (
       SELECT
	   YEAR ,
       SUM(SALES_VOLUME) AS TOTAL_SALES
	   FROM project.`bmw sales data (2010-2024)`
       GROUP BY YEAR 
)
SELECT 
      YEAR,
      TOTAL_SALES,
      SUM(TOTAL_SALES) OVER (
      ORDER BY YEAR 
      ROWS BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW 
      ) AS CUMULATIVE_SALES
FROM YEARLY_SALES
ORDER BY YEAR;