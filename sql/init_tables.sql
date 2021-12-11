DROP SCHEMA IF EXISTS raw_data CASCADE;
DROP SCHEMA IF EXISTS prod CASCADE;

-- raw_data schema for raw data from S3 loading into
-- prod schema for production purpose and it is where raw data transfrom into
CREATE SCHEMA raw_data;
CREATE SCHEMA prod;



-- raw tables for schama raw_data loaded from s3 buckets

CREATE TABLE raw_data.aisles (
  aisle_id int NOT NULL PRIMARY KEY,
  aisle varchar(100) NOT NULL
);

CREATE TABLE raw_data.departments (
  department_id smallint NOT NULL PRIMARY KEY,
  department varchar(50) NOT NULL
);

CREATE TABLE raw_data.orders (
  order_id int NOT NULL PRIMARY KEY,
  user_id int NOT NULL,
  eval_set varchar(10),
  order_num smallint,
  order_dow smallint,
  order_hour_of_day smallint,
  days_since_prior_order decimal(4, 1)
);

CREATE TABLE raw_data.products (
  product_id int NOT NULL PRIMARY KEY,
  product_name varchar(255) NOT NULL,
  aisle_id int NOT NULL,
  department_id int NOT NULL,
  FOREIGN KEY (aisle_id) REFERENCES raw_data.aisles(aisle_id),
  FOREIGN KEY (department_id) REFERENCES raw_data.departments(department_id)
);

CREATE TABLE raw_data.order_products (
  order_id int NOT NULL,
  product_id int NOT NULL,
  add_to_cart_order int,
  reordered bool,
  FOREIGN KEY (order_id) REFERENCES raw_data.orders(order_id),
  FOREIGN KEY (product_id) REFERENCES raw_data.products(product_id)
);




-- production tables for schema prod --

CREATE TABLE prod.orders (
  order_id int NOT NULL PRIMARY KEY,
  user_id int NOT NULL,
  order_num smallint,
  days_since_prior_order decimal(4, 1)
);


CREATE TABLE prod.departments (
  department_id smallint NOT NULL PRIMARY KEY,
  department varchar(50) NOT NULL
);

CREATE TABLE prod.products (
  product_id int NOT NULL PRIMARY KEY,
  product_name varchar(255) NOT NULL
);

CREATE TABLE prod.aisles (
  aisle_id int NOT NULL PRIMARY KEY,
  aisle varchar(100) NOT NULL
);

CREATE TABLE prod.order_products (
  order_id int NOT NULL,
  product_id int NOT NULL,
  aisle_id int NOT NULL,
  department_id int NOT NULL,
  add_to_cart_order int,
  reordered bool,
  order_dow smallint,
  order_hour_of_day smallint,
  FOREIGN KEY (order_id) REFERENCES prod.orders(order_id),
  FOREIGN KEY (product_id) REFERENCES prod.products(product_id),
  FOREIGN KEY (aisle_id) REFERENCES prod.aisles(aisle_id),
  FOREIGN KEY (department_id) REFERENCES prod.departments(department_id)
);