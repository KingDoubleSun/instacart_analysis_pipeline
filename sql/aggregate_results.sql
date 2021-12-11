-- Since the node limitation for this cluster, this cluster can not fecth all records to Tableau,
-- So SQL queries is used in Taleau to fetch aggregated results


-- Total amount of top 10 sellers sold over weekdays
SELECT count(*) as amount, p.product_id, p.product_name, order_dow
FROM prod.order_products op INNER JOIN prod.products p ON op.product_id = p.product_id
WHERE p.product_id in (SELECT product_id
					   FROM prod.order_products
					   GROUP BY product_id
					   ORDER BY count(*) DESC
					   LIMIT 10)
GROUP BY p.product_id, p.product_name, order_dow;


-- Total amount of top 10 sellers sold over hour of day
SELECT 
	count(*) as amount, p.product_id, p.product_name, order_hour_of_day
FROM 
	prod.order_products op INNER JOIN prod.products p 
    ON op.product_id = p.product_id
WHERE p.product_id in (SELECT product_id
					   FROM prod.order_products
					   GROUP BY product_id
					   ORDER BY count(*) DESC
					   LIMIT 10)
GROUP BY p.product_id, p.product_name, order_hour_of_day;


-- Total products sold by each department
SELECT count(*) as a, department
FROM prod.order_products op JOIN prod.departments p ON p.department_id = op.department_id
GROUP BY p.department_id, department;


-- Top 10 products which are put into the cart first
SELECT count(*) as total, product_name
FROM prod.order_products op JOIN prod.products p ON op.product_id = p.product_id
WHERE add_to_cart_order = 1
GROUP BY p.product_id, product_name
ORDER BY total DESC
LIMIT 10;
