-- SELECT

SELECT 1
SELECT 'Martin' as name
SELECT 1 AS 'ID', 'Martin' AS name
SELECT 1 AS 'ID', 'Martin' AS 'first name'
SELECT 1 AS 'ID', 'Martin' AS [first name]

-- FROM

SELECT * 
FROM sale.customer

SELECT first_name, last_name FROM sale.customer

-- sıra önemli değil, istediğimiz sırada getirir

SELECT email, first_name, last_name FROM sale.customer


-- WHERE

-- filtreleme yapmak için kullanıyoruz

SELECT first_name, last_name, city, state
FROM sale.customer
WHERE city = 'ATLANTA'

SELECT first_name, last_name, city, state
FROM sale.customer
WHERE NOT city = 'ATLANTA';

-- city kırılımı ama city göstermeden

SELECT first_name, last_name, state
FROM sale.customer
WHERE city = 'ATLANTA';

SELECT first_name, last_name, street, city, state
FROM sale.customer
WHERE state = 'TX' AND city = 'Allen';

SELECT first_name, last_name, street, city, state
FROM sale.customer
WHERE state = 'TX' OR city = 'Allen';

SELECT first_name, last_name, street, city, state
FROM sale.customer
WHERE last_name = 'Chan' AND (state = 'TX' OR state = 'NY'); -- işlem önceliği gibi () kullanırız. AND öncelikli

-- IN / NOT IN

SELECT first_name, last_name, street, city, state
FROM sale.customer
WHERE [state] = 'TX' AND city IN ('Allen', 'Austin');

-- LIKE
-- '_'  any single chracter
-- '%'  unknown character numbers

SELECT * 
FROM sale.customer
WHERE email LIKE '%@yahoo%';   -- % başta ve sonda ne geleceğini bilmiyorsak kullanıyoruz

SELECT * 
FROM sale.customer
WHERE first_name LIKE 'Di__e';      -- _ ile oraya boşluk koyuyoruz

SELECT * 
FROM sale.customer
WHERE first_name LIKE '[TZ]%';     -- first_name T veya Z ile başlayanlar

SELECT * 
FROM sale.customer
WHERE first_name LIKE '[T-Z]%';    -- first_name T ile Z arasında bir harf ile başlayanlar. include!

-- BETWEEN

SELECT *
FROM product.product
WHERE list_price BETWEEN 599 AND 999; -- include!


SELECT *
FROM sale.orders
WHERE order_date BETWEEN '2018-01-05' AND '2018-01-08';

-- <, >, <=, >=, =, !=, <> (farklı demek)

SELECT *
FROM product.product
WHERE list_price < 1000;

-- IS NULL / IS NOT NULL

SELECT *
FROM sale.customer
WHERE phone IS NULL;

-- TOP N

SELECT TOP 10 *
FROM sale.orders;

SELECT TOP 10 customer_id
FROM sale.customer;

-- ORDER BY

SELECT TOP 10 *
FROM sale.orders
ORDER BY order_id DESC;

SELECT TOP 10 *
FROM sale.orders
ORDER BY order_id ASC;    -- default ASC dir

SELECT first_name, last_name, city, [state]
FROM sale.customer
ORDER BY first_name ASC, last_name DESC;   -- birden fazla sıralama, ad öncelikli, soyad tersi

SELECT first_name, last_name, city, [state]
FROM sale.customer
ORDER BY 3 ASC, 4 DESC;   -- rakamla kullanabiliriz, select ile seçilen column a göre

SELECT first_name, last_name, city, [state]
FROM sale.customer
ORDER BY 3, 4;

SELECT first_name, last_name, city, [state]
FROM sale.customer
ORDER BY customer_id DESC;   -- select içinde customer_id olmasa da ona göre order yapabiliriz

-- DISTINCT unique değerleri getirir.

SELECT DISTINCT state
FROM sale.customer;      -- 2000 değerden 27 farklı state getirdi.

SELECT DISTINCT state, city
FROM sale.customer;      -- hem state, hem city unique 50 değer


SELECT DISTINCT *        -- duplicate rows var mı diye bakıyoruz, yokmuş
FROM sale.customer
