SELECT * FROM `gooutisde05122024.Daily_Sales`

-- ALTER TABLE `gooutisde05122024.GoOutside_daily_sales`
  -- RENAME COLUMN old_name TO new_name;

-- Calculate total sales per day
SELECT Sales_Date, SUM(Unit_sale_price) AS total_sales
FROM `gooutisde05122024.Daily_Sales`
GROUP BY Sales_Date
ORDER BY Sales_Date;