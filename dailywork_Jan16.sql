SELECT a.product_id, a.product_name, a.category_id, b.category_name
FROM product.product a                          -- AS kullanmıyoruz, genelde tek harf 
INNER JOIN product.category b
    ON a.category_id = b.category_id;

-- or 

SELECT a.product_id, a.product_name, a.category_id, b.category_name
FROM product.product a, product.category b
WHERE a.category_id = b.category_id             --inner join bu şekilde de kullanılabilir

-- list employees of stores and store name

SELECT a.first_name, a.last_name, b.store_name
FROM sale.staff a
INNER JOIN sale.store b
    ON a.store_id = b.store_id;

-- or 2nd method

SELECT a.first_name, a.last_name, b.store_name
FROM sale.staff a, sale.store b
WHERE a.store_id = b.store_id;

-- kaç çalışan var mağazada

SELECT b.store_name, COUNT(b.store_name) AS num_of_emp
FROM sale.staff a, sale.store b
WHERE a.store_id = b.store_id
GROUP BY b.store_name;

----LEFT JOIN-----

--no order 

SELECT p.product_id, p.product_name, o.order_id
FROM product.product p
LEFT JOIN sale.order_item o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

SELECT a.staff_id, ISNULL(SUM(c.quantity), 0) sum_quantity     --coalesce ile de yapılabilirdi.
FROM sale.staff a
LEFT JOIN sale.orders b
    ON a.staff_id = b.staff_id
LEFT JOIN sale.order_item c
    ON b.order_id = c.order_id
GROUP BY a.staff_id
ORDER BY a.staff_id;


-- INNER JOIN olunca NULL değerler gelmeyecek, o yüzden LEFT JOIN kullanıyoruz.

SELECT a.staff_id, ISNULL(SUM(c.quantity), 0) sum_quantity     --coalesce ile de yapılabilirdi.
FROM sale.staff a
INNER JOIN sale.orders b
    ON a.staff_id = b.staff_id
INNER JOIN sale.order_item c
    ON b.order_id = c.order_id
GROUP BY a.staff_id
ORDER BY a.staff_id;


--- RIGHT JOIN ---

SELECT p.product_id, p.product_name, o.order_id
FROM product.product p
RIGHT JOIN sale.order_item o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
 -- bu boş gelir çünkü ilki satılan ürünler tablosuydu

-- order is matter
SELECT p.product_id, p.product_name, o.order_id
FROM sale.order_item o
RIGHT JOIN product.product p
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

---FULL JOIN---

SELECT p.product_id, SUM(s.quantity) stock_quantity
FROM product.product p
FULL OUTER JOIN product.stock s
    ON p.product_id = s.product_id
GROUP BY p.product_id
ORDER BY p.product_id;

---CROSS JOIN---

--kartezyen çarpım gibi

SELECT product_id FROM product.stock

SELECT s.store_id, p.product_id, 0 as quantity
FROM product.product p
CROSS JOIN sale.store s
WHERE p.product_id NOT IN (SELECT product_id FROM product.stock);   --burda subquery yaptık.

--- SELF JOIN---

SELECT * FROM sale.staff

SELECT a.staff_id, a.first_name + ' ' + a.last_name as staff_name, b.first_name + ' ' + b.last_name as manager_name
FROM sale.staff a
LEFT JOIN sale.staff b ON a.manager_id = b.staff_id;

-- aynını inner join ile yapsaydık ne olurdu
SELECT a.staff_id, a.first_name + ' ' + a.last_name as staff_name, b.first_name + ' ' + b.last_name as manager_name
FROM sale.staff a
INNER JOIN sale.staff b ON a.manager_id = b.staff_id;
-- eşleşmeyen satırları getirmeyecek

---VIEWS---

--müşterilerin siparişlerini gösteren bir tablo view yapalım

SELECT a.customer_id, a.first_name, a.last_name, b.order_id, c.product_id, c.quantity
FROM sale.customer a
LEFT JOIN sale.orders b ON a.customer_id = b.customer_id
LEFT JOIN sale.order_item c ON b.order_id = c.order_id;

--yukarıdaki sorguyu hep kullanacaksak
CREATE OR ALTER VIEW vw_customer_product AS          --- OR ALTER deme sebebimiz zaten varsa update eder.
SELECT a.customer_id, a.first_name, a.last_name, b.order_id, c.product_id, c.quantity
FROM sale.customer a
LEFT JOIN sale.orders b ON a.customer_id = b.customer_id
LEFT JOIN sale.order_item c ON b.order_id = c.order_id;

--sorguyu tekrar kullanmak istersek
SELECT customer_id FROM vw_customer_product;

--view nasıl düşüreceğiz -- drop ile
DROP VIEW vw_customer_product

--değişiklik yapmak istersek, koda ulaşabiliriz
EXEC sp_helptext vw_customer_product;