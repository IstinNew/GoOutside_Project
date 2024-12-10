-- Temporal Scope
-- Determine the timeframe of the data
SELECT MIN(Sales_Date) AS start_date, MAX(Sales_Date) AS end_date
FROM `gooutisde05122024.Daily_Sales`;

-- Retailer Landscape
-- Count the number of retailers and their geographic spread
SELECT COUNT(DISTINCT Retailer_code) AS total_retailers, COUNT(DISTINCT Country) AS total_countries
FROM `gooutisde05122024.Retailers`;

-- List retailers by country
SELECT Country, COUNT(*) AS num_retailers
FROM `gooutisde05122024.Retailers`
GROUP BY Country
ORDER BY num_retailers DESC
LIMIT 10;

-- Product Popularity 
-- Analyze regional or country-specific trends in product preference
SELECT r.Country, p.Product, SUM(ds.Quantity) AS total_sales
FROM `gooutisde05122024.Daily_Sales` ds
JOIN `gooutisde05122024.Products` p ON ds.Product_number = p.Product_number
JOIN `gooutisde05122024.Retailers` r ON ds.Retailer_code = r.Retailer_code
GROUP BY r.Country, p.Product
ORDER BY total_sales DESC;

-- Sales Performance
-- Analyze annual sales profits to identify growth patterns or areas for improvement
SELECT EXTRACT(YEAR FROM Sales_Date) AS year, SUM(Unit_sale_price * Quantity) AS total_sales
FROM `gooutisde05122024.Daily_Sales`
GROUP BY year
ORDER BY year;

-- Sales Channels
-- Identify the most active sales methods
SELECT m.Order_method_type, COUNT(ds.Order_method_code) AS method_count, SUM(ds.Unit_sale_price * ds.Quantity) AS total_sales
FROM `gooutisde05122024.Daily_Sales` ds
JOIN `gooutisde05122024.Methods` m ON ds.Order_method_code = m.Order_method_code
GROUP BY m.Order_method_type
ORDER BY total_sales DESC;

-- Consider phasing out underperforming methods
SELECT m.Order_method_type, COUNT(ds.Order_method_code) AS method_count, SUM(ds.Unit_sale_price * ds.Quantity) AS total_sales
FROM `gooutisde05122024.Daily_Sales` ds
JOIN `gooutisde05122024.Methods` m ON ds.Order_method_code = m.Order_method_code
GROUP BY m.Order_method_type
HAVING total_sales < 500 -- Define threshold
ORDER BY total_sales ASC;

-- Sales Drivers
-- Identify brands and product types that generate the most sales
SELECT p.Product_brand, p.Product_type, SUM(ds.Unit_sale_price * ds.Quantity) AS total_sales
FROM `gooutisde05122024.Daily_Sales` ds
JOIN `gooutisde05122024.Products` p ON ds.Product_number = p.Product_number
GROUP BY p.Product_brand, p.Product_type
ORDER BY total_sales DESC;
