--1. Total Revenue for the Current Year
SELECT year, SUM(net_revenue) AS total_revenue
FROM casestudy
GROUP BY year;

--2. New Customer Revenue
SELECT t1.year, SUM(t1.net_revenue) AS new_customer_revenue
FROM casestudy t1
LEFT JOIN casestudy t2 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t2.customer_email IS NULL AND t1.year > 2015
GROUP BY t1.year;

--3. Existing Customer Growth (Revenue growth from existing customers)
SELECT t1.year, SUM(t1.net_revenue) - SUM(t2.net_revenue) AS
existing_customer_growth
FROM casestudy t1
JOIN casestudy t2 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t1.year > 2015
GROUP BY t1.year;

--4. Revenue Lost from Attrition
SELECT t2.year + 1 AS year, SUM(t2.net_revenue) AS lost_revenue
FROM casestudy t2
LEFT JOIN casestudy t1 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t1.customer_email IS NULL
AND t2.year IN (2015, 2016)
GROUP BY t2.year + 1
HAVING year IN (2016, 2017);

--5. Existing Customer Revenue for the Current Year
SELECT t1.year, SUM(t1.net_revenue) AS
existing_customer_revenue_current_year
FROM casestudy t1
JOIN casestudy t2 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t1.year IN (2016, 2017)
GROUP BY t1.year;

--6. Existing Customer Revenue for the Prior Year
SELECT t1.year AS year, SUM(t2.net_revenue) AS
existing_customer_revenue_prior_year
FROM casestudy t1
JOIN casestudy t2 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t1.year IN (2016, 2017)
GROUP BY t1.year;

--7. Total Customers for the Current Year
SELECT year, COUNT(DISTINCT customer_email) AS
total_customers_current_year
FROM casestudy
GROUP BY year;

--8. Total Customers for the Previous Year
SELECT t1.year AS year, COUNT(DISTINCT t2.customer_email) AS
total_customers_previous_year
FROM casestudy t1
LEFT JOIN casestudy t2 ON t1.year = t2.year + 1
WHERE t1.year IN (2016, 2017)
GROUP BY t1.year;

--9. New Customers
SELECT t1.year, COUNT(DISTINCT t1.customer_email) AS new_customers
FROM casestudy t1
LEFT JOIN casestudy t2 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t2.customer_email IS NULL AND t1.year > 2015
GROUP BY t1.year;

--10. Lost Customers
SELECT t2.year + 1 AS year, COUNT(DISTINCT t2.customer_email) AS
lost_customers
FROM casestudy t2
LEFT JOIN casestudy t1 ON t1.customer_email = t2.customer_email AND t1.year =
t2.year + 1
WHERE t1.customer_email IS NULL
AND t2.year IN (2015, 2016)
GROUP BY t2.year + 1
HAVING year IN (2016, 2017);
