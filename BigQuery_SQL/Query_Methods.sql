SELECT * FROM `gooutisde05122024.Methods`;

-- Count the number of methods used
SELECT Order_method_type, COUNT(*) AS method_count
FROM `gooutisde05122024.Methods`
GROUP BY Order_method_type
ORDER BY method_count DESC;
