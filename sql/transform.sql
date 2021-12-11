INSERT INTO prod.aisles
SELECT *
FROM raw_data.aisles;

INSERT INTO prod.departments
SELECT *
FROM raw_data.departments;

INSERT INTO prod.orders
SELECT order_id, user_id, order_num, days_since_prior_order
FROM raw_data.orders;

INSERT INTO prod.products
SELECT product_id, product_name
FROM raw_data.products;

INSERT INTO prod.order_products
SELECT o.order_id, 
	   p.product_id, 
       a.aisle_id, 
       d.department_id, 
       op.add_to_cart_order, 
       op.reordered, 
       o.order_dow, 
       o.order_hour_of_day
FROM raw_data.orders o INNER JOIN raw_data.order_products op ON o.order_id = op.order_id
INNER JOIN raw_data.products p ON op.product_id = p.product_id
INNER JOIN raw_data.aisles a ON p.aisle_id = a.aisle_id
INNER JOIN raw_data.departments d ON d.department_id = p.department_id;