CREATE VIEW sales_info AS
SELECT c.customer_id, c.first_name, c.last_name, c.city, c.[state], o.order_id, oi.list_price, p.product_name
FROM sale.customer c
JOIN sale.orders o ON c.customer_id = o.customer_id
JOIN sale.order_item oi ON oi.order_id = o.order_id
JOIN product.product p ON p.product_id = oi.product_id

SELECT *
FROM sales_info

ALTER VIEW sales_info2 AS
SELECT c.customer_id, c.first_name, c.last_name, c.city, c.[state], o.order_id, oi.list_price, p.product_name
FROM sale.customer c
FULL JOIN sale.orders o ON c.customer_id = o.customer_id
FULL JOIN sale.order_item oi ON oi.order_id = o.order_id
FULL JOIN product.product p ON p.product_id = oi.product_id

SELECT *
FROM sales_info2

---
select p.product_name
from sale.customer c
inner join sale.orders o on c.customer_id = o.customer_id 
inner join sale.order_item oi on o.order_id = oi.order_id
inner join product.product p on oi.product_id = p.product_id
where c.city = 'Charlotte'
UNION
select p.product_name
from sale.customer c
inner join sale.orders o on c.customer_id = o.customer_id 
inner join sale.order_item oi on o.order_id = oi.order_id
inner join product.product p on oi.product_id = p.product_id
where c.city = 'Aurora' 

--- union -- in ile olsa boyle olurdu.
SELECT DISTINCT P.product_name
FROM sale.customer C
INNER JOIN sale.orders O ON C.customer_id = O.customer_id
INNER JOIN sale.order_item OI ON O.order_id = OI.order_id
INNER JOIN product.product P ON OI.product_id = P.product_id
WHERE C.city IN ('Aurora', 'Charlotte')


-- UNION / UNION ALL
-- NOT sutunlarin icerigi farkli da olsa veritipinin ayni olmasi yeterlidir.

select * 
from product.brand
UNION
select *
from product.category

----
select 1
union
select 5

--- her iki sorguda da ayni 
select 
from product.brand
UNION
select category_id
from product.category

-- write a query that returns all customers whose first or last name is Thomes. don't use 'or'


--- UNION


SELECT *
FROM product.brand
UNION
SELECT *
FROM product.category


-- Ad veya soyadından Thomas olanları Union ile getir.

SELECT first_name, last_name
FROM sale.customer
WHERE first_name = 'Thomas'
UNION ALL
SELECT first_name, last_name
FROM sale.customer
WHERE last_name = 'Thomas'

--- hem 2018 hem 2020 modeli olan markaları getir

SELECT brand_name
FROM product.brand
WHERE brand_id IN(
    SELECT brand_id
    FROM product.product
    WHERE model_year = 2018
    INTERSECT
    SELECT brand_id
    FROM product.product
    WHERE model_year = 2020
)

--- solution with CTE

WITH t1 AS(
    SELECT brand_id
    FROM product.product
    WHERE model_year = 2018
    INTERSECT
    SELECT brand_id
    FROM product.product
    WHERE model_year = 2020
)
SELECT b.brand_name
FROM product.brand b
INNER JOIN t1 ON b.brand_id = t1.brand_id

--- 2018 2019 ve 2020 için

SELECT first_name, last_name
FROM sale.customer
WHERE customer_id IN(
    SELECT customer_id
    FROM sale.orders
    WHERE YEAR(order_date) = 2018
    INTERSECT
    SELECT customer_id
    FROM sale.orders
    WHERE YEAR(order_date) = 2019
    INTERSECT
    SELECT customer_id
    FROM sale.orders
    WHERE YEAR(order_date) = 2020
)


--- other solution
WITH CTE AS (
    SELECT customer_id
    FROM sale.orders
    WHERE YEAR(order_date) = 2018
    INTERSECT
    SELECT customer_id
    FROM sale.orders
    WHERE YEAR(order_date) = 2019
    INTERSECT
    SELECT customer_id
    FROM sale.orders
    WHERE YEAR(order_date) = 2020
)
SELECT first_name, last_name
FROM sale.customer A
JOIN CTE B ON  A.customer_id = B.customer_id

--- 2018 olan 2019 olmayanlar

SELECT brand_id, brand_name
FROM product.brand
WHERE brand_id IN(
    SELECT brand_id
    FROM product.product
    WHERE model_year = 2018
    EXCEPT
    SELECT brand_id
    FROM product.product
    WHERE model_year = 2019
)

--- sadece 2019 sipariş edilen

SELECT oi.product_id
FROM sale.orders o
JOIN sale.order_item oi ON o.order_id = oi.order_id
WHERE year(order_date) = 2019       ---2019 olanlar
EXCEPT
SELECT oi.product_id
FROM sale.orders o
JOIN sale.order_item oi ON o.order_id = oi.order_id
WHERE year(order_date) <> 2019      ---2019da olmayanlar ı except ederiz.

--- bize product_id ve product_name lazım. diğer tablodan getirelim.

SELECT product_id, product_name
FROM product.product
WHERE product_id IN (
    SELECT oi.product_id
    FROM sale.orders o
    JOIN sale.order_item oi ON o.order_id = oi.order_id
    WHERE year(order_date) = 2019       ---2019 olanlar
    EXCEPT
    SELECT oi.product_id
    FROM sale.orders o
    JOIN sale.order_item oi ON o.order_id = oi.order_id
    WHERE year(order_date) <> 2019
)

---

