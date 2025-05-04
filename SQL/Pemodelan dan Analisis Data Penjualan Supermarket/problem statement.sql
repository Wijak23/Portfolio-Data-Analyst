select * from supermarket_sales.sales;

--Total revenue
select 
	sum (quantity_sold_k*unit_selling_price) as total_revenue
from supermarket_sales.sales;

-- average order value
SELECT   
    SUM (quantity_sold_k*unit_selling_price) / COUNT(DISTINCT date || '' ||time) AS average_order_value  
FROM supermarket_sales.sales;

-- total quantity sold
select 
	 sum (quantity_sold_k) as total_quantity_sold
FROM supermarket_sales.sales;	

--total order
select 
	count (distinct date ||''|| time) as total_order
FROM supermarket_sales.sales;

--average items per order
SELECT   
    AVG(item_count) AS average_items_per_order_estimate  
FROM (  
    SELECT   
        date || ' ' || time AS estimated_order_id,   
        COUNT(DISTINCT item_code) AS item_count  
    FROM supermarket_sales.sales  
    GROUP BY estimated_order_id  
) AS subquery;

-- daily trend for total order
SELECT   
    date,  
    COUNT(DISTINCT date || '' ||time) AS total_orders  
FROM supermarket_sales.sales  
GROUP BY date  
ORDER BY date;

--monthly trend for total order
SELECT   
    DATE_TRUNC('month', date) AS month,  
    SUM(quantity_sold_k * unit_selling_price) AS total_revenue  
FROM supermarket_sales.sales  
GROUP BY month  
ORDER BY month;

--percentage of sales per category
SELECT   
    category_name,  
    SUM(quantity_sold_k * unit_selling_price) AS revenue_by_category  
FROM supermarket_sales.sales  
GROUP BY category_name  
ORDER BY revenue_by_category DESC;

-- percentage of sales by item
SELECT   
    item_name,  
    SUM(quantity_sold_k * unit_selling_price) AS revenue_by_item  
FROM supermarket_sales.sales  
GROUP BY item_name  
ORDER BY revenue_by_item DESC;

--total quantity sold by category
SELECT   
    category_name,  
    SUM(quantity_sold_k) AS quantity_sold_by_category  
FROM supermarket_sales.sales  
GROUP BY category_name  
ORDER BY quantity_sold_by_category DESC;

-- top 7 best sellers by revenue and quantity
SELECT   
    item_name,  
    SUM(quantity_sold_k * unit_selling_price) AS total_revenue,  
    SUM(quantity_sold_k) AS total_quantity  
FROM supermarket_sales.sales  
GROUP BY item_name  
ORDER BY total_revenue DESC  
LIMIT 7;

-- bottom 5 worst sellers by revenue and quantity
SELECT   
    item_name,  
    SUM(quantity_sold_k * unit_selling_price) AS total_revenue,  
    SUM(quantity_sold_k) AS total_quantity  
FROM supermarket_sales.sales  
GROUP BY item_name  
ORDER BY total_revenue asc 
LIMIT 5;