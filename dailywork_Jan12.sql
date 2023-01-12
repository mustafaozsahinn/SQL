-- COUNT 

SELECT *
FROM product.product;

SELECT COUNT (product_id) AS number_of_product
FROM product.product;     

SELECT COUNT (*)
FROM product.product; 

SELECT COUNT (1)
FROM product.product;       -- burdaki belirleyici olan tablodaki satır sayısıdır

SELECT product_name, 1
FROM product.product;       -- hepsinin yanında 1 getirdi

SELECT *
FROM sale.customer;

SELECT COUNT(*)
FROM sale.customer;

SELECT COUNT(phone)
FROM sale.customer;       -- 1892 tane getirdi. 2000di normalde. 108 i null demek ki

-- 108 tane null değeri nasıl saydırırız?

SELECT COUNT(*)
FROM sale.customer
WHERE phone IS NULL;

SELECT COUNT(phone)
FROM sale.customer
WHERE phone IS NULL;  -- burda null 0 geldi, tezze oğluma soruyum ???

-- how many customers are located in NY state?

SELECT COUNT(customer_id) AS num_of_customers
FROM sale.customer
WHERE state = 'NY';

-----

-- COUNT DISTINCT

SELECT COUNT(city) AS num_of_cities
FROM sale.customer;

-- kaç tane unique city var?

SELECT COUNT(DISTINCT city)
FROM sale.customer;

-- MIN MAX

-- null değeri ignore edip, ilgili sütundaki en küçük/büyük değeri getirir.
-- str veya date de olabilir.

SELECT *
FROM product.product;

SELECT MIN(model_year), MAX(model_year)   -- yan yana getirebiliriz
FROM product.product;

-- category id 5 olanın min max fiyatları?

SELECT MIN(list_price), MAX(list_price)
FROM product.product
WHERE category_id = 5;

SELECT *
FROM product.category

-- category id 5 olanın n üst fiyatı?

SELECT TOP 1 list_price
FROM product.product
WHERE category_id = 5
ORDER BY list_price DESC;

-- SUM

-- total list price category 6?

SELECT SUM(list_price)
FROM product.product
WHERE category_id = 6;

-- how many product sold in order_id 45?

SELECT SUM(quantity) AS sum_quantity
FROM sale.order_item
WHERE order_id = 45;

-- AVG

-- avg list price 2020 model porducts?

SELECT AVG(list_price)
FROM product.product
WHERE model_year = 2020;

-- average order quantity for product 130?

SELECT AVG(quantity)           -- AVG sonucu int verir
FROM sale.order_item
WHERE product_id = 130;

SELECT AVG(quantity * 1.0)     -- float yapmak için 1.0 ile çarparız
FROM sale.order_item
WHERE product_id = 130;

-- GROUP BY

SELECT *
FROM product.product;

-- bu ikisi aynı

SELECT DISTINCT model_year
FROM product.product;

SELECT model_year
FROM product.product
GROUP BY model_year;

-- COUNT

-- how many products are in each model year?

SELECT model_year, COUNT(product_id) 
FROM product.product
GROUP BY model_year;

-- number of porducts over 1000 USD by brand?

SELECT brand_id, COUNT(product_id) AS luxury_products 
FROM product.product
WHERE list_price > 1000
GROUP BY brand_id
ORDER BY COUNT(product_id) DESC;    -- order by select ten sonra çalışır

-- COUNT DISTINCT

SELECT brand_id, COUNT(DISTINCT category_id)
FROM product.product
GROUP BY brand_id;

-- tek tek hangi kategorilerde olduğunu görelim

SELECT brand_id, category_id
FROM product.product
GROUP BY brand_id, category_id;

-- unique categorilerin toplamını brand_id ye göre group larız.

SELECT brand_id, COUNT(DISTINCT category_id)
FROM product.product
GROUP BY brand_id;

SELECT order_id, product_id, MAX(list_price) AS max_price
FROM sale.order_item
GROUP BY order_id, product_id
ORDER BY order_id;    -- 4722 satır geldi, çünkü unique tüm satırları getirdi, max_price ın bi önemi kalmadı zaten

-- MIN / MAX

-- fist and last puchase date for each customer

SELECT customer_id, MIN(order_date) AS first_order, MAX(order_date) AS last_order
FROM sale.orders
GROUP BY customer_id;

-- find min and max product prices of each brand.

SELECT brand_id, MIN(list_price) AS min_price, MAX(list_price) AS max_price
FROM product.product
GROUP BY brand_id;

-- SUM / AVG 

--- find total discount amount of each order

SELECT order_id, SUM(quantity * list_price * discount) AS total_amount
FROM sale.order_item
GROUP BY order_id;

-- burda da bi şeyler yaptık ama çok da önemli değildi

SELECT order_id, list_price*2,
    SUM(quantity * list_price * (1-discount)) total_amount,
    SUM(quantity * list_price * discount) total_amount
FROM sale.order_item
WHERE order_id = 1 AND product_id = 8
GROUP BY order_id, list_price;

-- what is the average list price 

SELECT model_year, AVG(list_price) AS avg_price
FROM product.product
GROUP BY model_year;

-- most frequent name

SELECT TOP 1 first_name, COUNT(first_name) AS quantity
FROM sale.customer
GROUP BY first_name
ORDER BY quantity DESC;

SELECT state, COUNT(state) AS num
FROM sale.customer
WHERE email LIKE '%yandex%'
GROUP BY state
ORDER BY num DESC;