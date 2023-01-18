--- SUBQUERIES ---

-- Davis Thomas ın mağaza arkadaşlarını getir

SELECT * 
FROM sale.staff
WHERE store_id = (
    SELECT store_id
    FROM sale.staff
    WHERE first_name = 'Davis' AND last_name = 'Thomas')

-- Charles Cussona'nın birinci derece yöneticisi olduğu personeli getir.

SELECT * 
FROM sale.staff
WHERE manager_id = (
    SELECT staff_id
    FROM sale.staff
    WHERE first_name = 'Charles' AND last_name = 'Cussona')

-- Pro Series 49 dan daha pahalı ürünleri getir.

SELECT product_id, product_name, model_year, list_price 
FROM product.product
WHERE list_price > (
    SELECT list_price
    FROM product.product
    WHERE product_name LIKE 'Pro-Series 49%')

-- Laurel Goldammer ile aynı günlerde alışveriş yapanların bilgilerini getir.


SELECT a.first_name, a.last_name, b.order_date
FROM sale.customer a, sale.orders b
WHERE a.customer_id=b.customer_id
AND b.order_date IN (
		SELECT order_date
		FROM sale.customer c, sale.orders o
		WHERE c.customer_id=o.customer_id
			AND first_name='Laurel'
			AND last_name='Goldammer')


-- alternatif çözüm

SELECT a.first_name, a.last_name, b.order_date
FROM sale.customer a
INNER JOIN sale.orders b
    ON a.customer_id = b.customer_id
WHERE b.order_date IN(
    SELECT o.order_date
    FROM sale.customer c
    INNER JOIN sale.orders o
    ON c.customer_id = o.customer_id
    WHERE c.first_name = 'Laurel' AND c.last_name = 'Goldammer')

-- Buffalo şehrindeki son 10 sipariş ürünlerini getir.

SELECT TOP 10 c.city, o.order_date
FROM sale.customer c
INNER JOIN sale.orders o
    ON c.customer_id = o.customer_id
WHERE c.city = 'Buffalo'
ORDER BY o.order_date DESC;

-- çözüme devam

SELECT DISTINCT p.product_name
FROM product.product p, sale.order_item oi
WHERE p.product_id = oi.product_id
AND oi.order_id IN (
    SELECT TOP 10 o.order_id
    FROM sale.customer c
    INNER JOIN sale.orders o
        ON c.customer_id = o.customer_id
    WHERE c.city = 'Buffalo'
    ORDER BY o.order_date DESC);

--- CORRELATED SUBQUERIES ---

--yeni soru

SELECT product_id, product_name, category_id, list_price, 
        (SELECT AVG(list_price) FROM product.product) AS avg_all
FROM product.product


SELECT product_id, product_name, category_id, list_price, 
        (SELECT AVG(list_price) FROM product.product WHERE category_id = p.category_id)
        AS avg_category --aynı kategoriden olanları ayrı ayrı
FROM product.product p

--category ortalamasından ucuzları getirelim
SELECT product_id, product_name, category_id, list_price, 
        (SELECT AVG(list_price) FROM product.product WHERE category_id = p.category_id)
        AS avg_category --aynı kategoriden olanları ayrı ayrı
FROM product.product p
WHERE list_price < (SELECT AVG(list_price) FROM product.product WHERE category_id = p.category_id)

--- EXISTS / NOT EXISTS ---

SELECT *      -- 4 tobloyu bağladık
FROM product.product p, sale.order_item oi, sale.orders o, sale.customer c
WHERE p.product_id = oi.product_id
    AND oi.order_id = o.order_id
    AND o.customer_id = c.customer_id

-- gereken sütunları alalım
SELECT p.product_name, oi.order_id, c.[state]
FROM product.product p, sale.order_item oi, sale.orders o, sale.customer c
WHERE p.product_id = oi.product_id
    AND oi.order_id = o.order_id
    AND o.customer_id = c.customer_id


-- sadece o ürün için bakalım
SELECT p.product_name, oi.order_id, c.[state]
FROM product.product p, sale.order_item oi, sale.orders o, sale.customer c
WHERE p.product_id = oi.product_id
    AND oi.order_id = o.order_id
    AND o.customer_id = c.customer_id
    AND p.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'

-- corralated subquery yapalım
SELECT DISTINCT state
FROM sale.customer x
WHERE NOT EXISTS (
    SELECT p.product_name, oi.order_id, c.[state] --- burası önemli değil * da olabilir
    FROM product.product p, sale.order_item oi, sale.orders o, sale.customer c
    WHERE p.product_id = oi.product_id
        AND oi.order_id = o.order_id
        AND o.customer_id = c.customer_id
        AND p.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
        AND c.[state] = x.state
)

--- CTE WITH ---

WITH t1 AS
(
    SELECT MAX(order_date) AS last_order_date
    FROM sale.customer c
    INNER JOIN  sale.orders o
        ON c.customer_id = o.customer_id
    WHERE c.first_name = 'Jerald'
        AND c.last_name = 'Berray'
)
SELECT a.customer_id, a.first_name, a.last_name, b.order_date
FROM sale.customer a, sale.orders b, t1
WHERE a.customer_id = b.customer_id
    AND b.order_date < t1.last_order_date
    AND a.city = 'Austin'

---

WITH cte AS(
    SELECT o.order_date
    FROM sale.customer c
    INNER JOIN sale.orders o
        ON c.customer_id = o.customer_id
    WHERE c.first_name = 'Laurel'
        AND c.last_name = 'Goldammer'
    )
SELECT a.first_name, a.last_name, b.order_date
FROM sale.customer a, sale.orders b, cte
WHERE a.customer_id = b.customer_id
    AND b.order_date = cte.order_date


--

WITH trn_1 AS(
    SELECT s.store_name, SUM(list_price * quantity * (1-discount)) AS turnover
    FROM sale.order_item oi, sale.orders o, sale.store s
    WHERE oi.order_id = o.order_id
        AND o.store_id = s.store_id
        AND o.order_date LIKE '2018%'
    GROUP BY s.store_name
), 
trn_2 AS(
    SELECT AVG(turnover) AS avg_turnover
    FROM trn_1
)
SELECT *
FROM trn_1, trn_2
WHERE trn_1.turnover < trn_2.avg_turnover