SELECT * FROM `gooutisde05122024.Retailers`;

-- Find top retailers by sales
SELECT r.Retailer_name, SUM(ds.Unit_sale_price) AS total_sales
FROM `gooutisde05122024.Retailers` r
JOIN `gooutisde05122024.Daily_Sales` ds ON r.Retailer_code = ds.Retailer_code
GROUP BY r.Retailer_name
ORDER BY total_sales DESC;
