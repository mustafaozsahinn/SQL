SELECT *
FROM product.product          

-- 520 product var ama unique mi bakalım

SELECT product_id, COUNT(product_id) num_of_prod
FROM product.product          
GROUP BY product_id

-- HAVING ile kullanalım

SELECT product_id, COUNT(product_id) num_of_prod
FROM product.product          
GROUP BY product_id
HAVING COUNT(product_id) > 1

-- boş geldi, çünkü duplike yok

-- prodcut_name duplike var mı?

SELECT product_name, COUNT(product_name) num_of_prod
FROM product.product          
GROUP BY product_name
HAVING COUNT(product_name) > 1

-- gördük ki 19 ürün duplike olmuş

------ 
SELECT category_id, MAX(list_price) AS max_price, MIN(list_price) AS min_price
FROM product.product
GROUP BY category_id

-- MAX MIN fiyatları getridik, bunlara HAVING ile filtre uygulayacağız

SELECT category_id, MAX(list_price) AS max_price, MIN(list_price) AS min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500   -- alias çalışmaz, çünkü HAVING SELECT ten önce çalışır.

-------
SELECT b.brand_name, AVG(list_price) AS avg_price
FROM product.product p, product.brand b 
WHERE p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY AVG(list_price) DESC;

--- ortalama fiyatı 1000 üzerinde olanlar ı getir.

SELECT b.brand_name, AVG(list_price) AS avg_price
FROM product.product p, product.brand b 
WHERE p.brand_id = b.brand_id
GROUP BY b.brand_name
HAVING AVG(list_price) > 1000
ORDER BY AVG(list_price) DESC;

------

SELECT order_id, SUM(list_price * quantity * (1-discount)) AS net_price
FROM sale.order_item
GROUP BY order_id
HAVING SUM(list_price * quantity * (1-discount)) > 5000;

----

SELECT state, YEAR(order_date) AS years, MONTH(order_date) AS months
FROM sale.customer c, sale.orders o
WHERE c.customer_id = o.customer_id
GROUP BY state, YEAR(order_date), MONTH(order_date)

--- aggregate işlem yapalım

SELECT state, YEAR(order_date) AS years, MONTH(order_date) AS months, COUNT(order_id) AS num_of_orders
FROM sale.customer c, sale.orders o
WHERE c.customer_id = o.customer_id
GROUP BY state, YEAR(order_date), MONTH(order_date)

--- HAVING kullanarak 3ten fazla sipraiş var mı diye bakarız

SELECT state, YEAR(order_date) AS years, MONTH(order_date) AS months, COUNT(order_id) AS num_of_orders
FROM sale.customer c, sale.orders o
WHERE c.customer_id = o.customer_id
GROUP BY state, YEAR(order_date), MONTH(order_date)
HAVING COUNT(order_id) > 3


--- ikinci dersten sonra yoktum
