-- Sales Trends Over Time, spread by Country and Product type
-- Analyze annual sales profits to identify growth patterns or areas for improvement
WITH Annual_Sales AS (
  SELECT 
    EXTRACT(YEAR FROM ds.Sales_Date) AS year, 
    SUM(ds.Unit_sale_price * ds.Quantity) AS total_sales
  FROM 
    `gooutisde05122024.Daily_Sales` ds
  GROUP BY 
    year
),

-- Identify brands and product types that generate the most sales
Sales_Drivers AS (
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
    total_sales DESC
),

-- Total sales by products, countries, and date categories
Total_Sales AS (
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
    p.Product_type
)

-- Combine all data for export to Google Sheets
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
  Total_Sales ts
LEFT JOIN 
  Annual_Sales a ON EXTRACT(YEAR FROM ts.Sales_Date) = a.year
LEFT JOIN 
  Sales_Drivers sd ON ts.Product_type = sd.Product_type
ORDER BY 
  ts.Sales_Date, 
  ts.Country, 
  ts.Product;