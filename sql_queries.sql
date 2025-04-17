-- Table structure for table `transactions`
-- Table structure for table `products`
-- Table structure for table `markets`
-- Table structure for table `date`
-- Table structure for table `customers`
select transactions.*,date.*
from transactions 
INNER JOIN date on transactions.order_date = date.date
where date.year = 2020;

select SUM(transactions.Sales_amount) as Revenuein2020
from transactions 
INNER JOIN date on transactions.order_date = date.date
where date.year = 2020;

select COUNT(*)
from transactions
where currency = 'USD\r' or currency = 'USD';
---------

-- 1. Total Sales Amount and Quantity by Zone
SELECT
  m.zone                                   AS zone,
  SUM(t.sales_amount)                      AS total_sales_amount,
  SUM(t.sales_qty)                         AS total_sales_quantity
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY m.zone
ORDER BY total_sales_amount DESC;

-- 2. Monthly Sales Trend (Year–Month)
SELECT
  TO_CHAR(d."date", 'YYYY‑MM')             AS year_month,
  SUM(t.sales_amount)                      AS monthly_sales_amount,
  SUM(t.sales_qty)                         AS monthly_sales_qty
FROM transactions t
JOIN date d ON t.order_date = d."date"
GROUP BY year_month
ORDER BY year_month;

-- 4. Sales Breakdown by Customer Type
SELECT
  c.customer_type                          AS customer_type,
  COUNT(DISTINCT t.customer_code)          AS unique_customers,
  SUM(t.sales_amount)                      AS total_sales
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.customer_type


-- 6. Average Order Value by Region
SELECT
  m.zone                                   AS zone,
  ROUND(SUM(t.sales_amount)::NUMERIC / NULLIF(COUNT(*)::NUMERIC,0),2) 
                                           AS avg_order_value
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY m.zone
ORDER BY avg_order_value DESC;


