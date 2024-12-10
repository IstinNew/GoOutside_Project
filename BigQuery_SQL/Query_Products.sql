SELECT * FROM `gooutisde05122024.Products`;

-- List products with their total sales
SELECT p.Product, SUM(ds.Unit_sale_price) AS total_sales
FROM `gooutisde05122024.Products` p
JOIN `gooutisde05122024.Daily_Sales` ds ON p.Product_number = ds.Product_number
GROUP BY p.Product
ORDER BY total_sales DESC;