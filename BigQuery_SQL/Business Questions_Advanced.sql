-- Create Annual Sales Table
CREATE TABLE `gooutisde05122024.Annual_Sales` AS
SELECT 
  EXTRACT(YEAR FROM Sales_Date) AS year, 
  SUM(Unit_sale_price * Quantity) AS total_sales
FROM 
  `gooutisde05122024.Daily_Sales`
GROUP BY 
  year
ORDER BY 
  year;

-- Create Sales Drivers Table
CREATE TABLE `gooutisde05122024.Sales_Drivers` AS
SELECT 
  p.Product_brand, 
  p.Product_type, 
  SUM(ds.Unit_sale_price * ds.Quantity) AS total_sales
FROM 
  `gooutisde05122024.Daily_Sales` ds
JOIN 
  `gooutisde05122024.Products` p ON ds.Product_number = p.Product_number
GROUP BY 
  p.Product_brand, 
  p.Product_type
ORDER BY 
  total_sales DESC;

-- Create Total Sales Table
CREATE TABLE `gooutisde05122024.Total_Sales` AS
SELECT 
  ds.Sales_Date, 
  r.Country, 
  p.Product, 
  p.Product_type,
  SUM(ds.Unit_sale_price * ds.Quantity) AS total_sales
FROM 
  `gooutisde05122024.Daily_Sales` ds
JOIN 
  `gooutisde05122024.Products` p ON ds.Product_number = p.Product_number
JOIN 
  `gooutisde05122024.Retailers` r ON ds.Retailer_code = r.Retailer_code
GROUP BY 
  ds.Sales_Date, 
  r.Country, 
  p.Product, 
  p.Product_type;

-- Create Combined Sales Data Table
CREATE TABLE `gooutisde05122024.Combined_Sales_Data` AS
SELECT 
  ts.Sales_Date, 
  ts.Country, 
  ts.Product, 
  ts.Product_type, 
  ts.total_sales,
  a.year,
  a.total_sales AS annual_total_sales,
  sd.Product_brand,
  sd.total_sales AS brand_total_sales
FROM 
  `gooutisde05122024.Total_Sales` ts
LEFT JOIN 
  `gooutisde05122024.Annual_Sales` a ON EXTRACT(YEAR FROM ts.Sales_Date) = a.year
LEFT JOIN 
  `gooutisde05122024.Sales_Drivers` sd ON ts.Product_type = sd.Product_type
ORDER BY 
  ts.Sales_Date, 
  ts.Country, 
  ts.Product;