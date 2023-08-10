USE [learning ]


-- Top 5 companies
SELECT TOP 5*
FROM top_companies;


--Rounding up
UPDATE top_companies
SET 
  Sales_billion = ROUND(Sales_billion, 2),
  Profits_billion = ROUND(Profits_billion, 2),
  Assets_billion = ROUND(Assets_billion, 2),
  Market_value_billion = ROUND(Market_value_billion, 2)


--Dropping columns
ALTER TABLE top_companies
DROP COLUMN latitude;

ALTER TABLE top_companies  
DROP COLUMN longitude;


-- Top 10 companies by sales
SELECT TOP 10 Company, Sales_billion  
FROM top_companies
ORDER BY Sales_billion DESC;


--The number of companies in the top 100 for each continent
SELECT Continent, COUNT_BIG(*) AS num_top_companies
FROM top_companies
WHERE Global_rank <= 100
GROUP BY Continent;


-- The country with the highest average company market value
SELECT 
  Country,
  ROUND(AVG(Market_value_billion), 2) AS [avg_market_value]
FROM top_companies
GROUP BY Country
ORDER BY [avg_market_value] DESC;


--Which companies have the highest profit margins
SELECT Company, Profits_billion / NULLIF(Sales_billion, 0) AS profit_margin
FROM top_companies
ORDER BY profit_margin DESC;


--The total assets by continent
SELECT
  Continent,
  ROUND(SUM(Assets_billion), 2) AS total_assets
FROM top_companies  
GROUP BY Continent
ORDER BY total_assets desc;


--Companies whose profits exceeded 5% of sales:
SELECT
  Company,
  CASE WHEN Profits_billion > 0.05*Sales_billion THEN 'High Profit Margin' END AS profit_flag
FROM top_companies
WHERE Profits_billion IS NOT NULL;
