--SQL SESSİON-3,14.01.2023
/*Arkadaşlar CHAR ile VARCHAR arasındaki farkı örnekle pekiştirelim:
Eğer sınırlama yapmazsanız VARCHAR ın 65000 karakter sınırı var.
CHAR kullanırsanız 255 karaktere kadar müsaade eder. 
VARCHAR'ı daha büyük doküman yazacaksanız tercih edebilirsiniz.
Aralarındaki fark şu: Diyelim siz CHAR dediniz ve karakter uzunluğunu 200 olarak belirlediniz.
Ondan sonra siz bir satıra ister 5 karakter girin ister 200 karakter girin.
CHAR her zaman hafızada 200 karakter yer tutar.
Ama diyelim ki VARCHAR'a 200 değeri girdiniz. Bir satıra 10 karakter yazdınız.
VARCHAR hafızada girdiğiniz karakter kadar yer kaplar. 200 karakter yer kaplamaz.*/

SELECT N'قمر'
SELECT CONVERT(VARCHAR, N'قمر')
SELECT CONVERT(NVARCHAR, N'قمر')
SELECT N':grinning:'

CREATE TABLE t_date_time (
A_time [time],
A_date [date],
A_smalldatetime [smalldatetime],
A_datetime [datetime],
A_datetime2 [datetime2],
A_datetimeoffset [datetimeoffset]  -- yeni tablo oluşturduk.
);


SELECT * FROM t_date_time  -- içine baktık boş

INSERT t_date_time
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE()) -- içini doldurduk

SELECT * FROM t_date_time  -- şimdi baktık doldu.


SELECT        A_date,
DATENAME(DW, A_date) [weekday],   --isim olarak  döndürdü         
DATEPART(DW, A_date) [weekday_2], -- 7  gün olarakolarak       
DATENAME(M, A_date) [month],             
DATEPART(month, A_date) [month_2],
DAY (A_date) [day],
MONTH(A_date) [month_3],
YEAR (A_date) [year],
A_time,
DATEPART (minute, A_time) [minute],
DATEPART (NANOSECOND, A_time) [nanosecond]
FROM        t_date_time;

/*YEAR / YYYY / YY
QUARTER / QQ / Q
MONTH / MM / M
DAYOFYEAR / DY / Y  yılın kaçıcı günü
WEEK / WW / WK
WEEKDAY / DW
DAY / DD / D
HOUR / HH
MINUTE / MI / N
SECOND / SS / S
MILLISECOND / MS
MICROSECOND / MCS
NANOSECOND / NS  */


SELECT A_date,       
       A_datetime,
       GETDATE() AS [CurrentTime],
       DATEDIFF (DAY, '2020-11-30', A_date) Diff_day, --bugünle yazılı tarih farkı
       DATEDIFF (MONTH, '2020-11-30', A_date) Diff_month,
       DATEDIFF (YEAR, '2020-11-30', A_date) Diff_year,
       DATEDIFF (HOUR, A_datetime, GETDATE()) Diff_Hour,
       DATEDIFF (MINUTE, A_datetime, GETDATE()) Diff_Min
FROM  t_date_time;


SELECT *
FROM sale.orders

--korgolama tarihi ile sipariş tarihi arasındaki farkı sorduk.

SELECT order_date, shipped_date,
DATEDIFF (DAY, order_date, shipped_date) day_diff,
DATEDIFF (DAY, shipped_date, order_date) day_diff
FROM        sale.orders
WHERE        order_id = 1;

SELECT	order_date,
		DATEADD(YEAR, 5, order_date), 
		DATEADD(DAY, 5, order_date),
		DATEADD(DAY, -5, order_date)		
FROM	sale.orders
WHERE	order_id = 1

SELECT GETDATE(), DATEADD(HOUR, 5, GETDATE());

SELECT GETDATE(), DATEADD(HOUR, 5, GETDATE())

SELECT	order_date, EOMONTH(order_date) end_of_month,
		EOMONTH(order_date, 2) eomonth_next_two_months
FROM	sale.orders;

SELECT ISDATE('2021-12-02') --2021/12/02 ||| 2021.12.02 ||| 20211202
 
SELECT ISDATE('02/12/2022') --02-12-2022 ||| 02.12.2022

SELECT ISDATE('02122022')   --ERROR

SELECT DATEDIFF (DAY, order_date, shipped_date) AS date_diff, *
FROM sale.orders
WHERE DATEDIFF (DAY, order_date, shipped_date) > 2
ORDER BY date_diff DESC;

---LEN

SELECT LEN('welcome')   --7
SELECT LEN(' welcome')  --8 baştaki boşluğu sayar.
SELECT LEN('wel come')  --8 aradaki boşluğu sayar.
SELECT LEN('welcome ')  --7 sondaki boşluğu saymaz.
SELECT LEN(12345678)    --8 olduğu gibi sayar 

SELECT 'Jack''s phone'   -- '' buraya dikkat 

-- CHARINDEX

SELECT CHARINDEX('C', 'CHARACTER')    --1 ilk Cyi bulur 
SELECT CHARINDEX('C', 'CHARACTER', 2) --6 2den başladığı için 1i görmez, 6.yı bulur
SELECT CHARINDEX('CT', 'CHARACTER')   --6 CT ikisilisini arar
SELECT CHARINDEX('ct', 'CHARACTER')   --6 büyük küçük harf duyarlılığı yok

--PATINDEX

--PATINDEX()
 
SELECT PATINDEX('%R', 'CHARACTER')    --9 öncesinde bir şeyler olabilir ama sonrasında olmaz.
SELECT PATINDEX('R%', 'CHARACTER')    --0 sonrasında bir şeyler olabilir ama öncesinde olmaz.
SELECT PATINDEX('%[RC]%', 'CHARACTER')--1 R veya C olsun fark etmez, ilk hangisi geliyorsa onu verir.
SELECT PATINDEX('_H%' , 'CHARACTER')  --1 _H birliktedir. bu pattern hemen CH olarak başta var.

--LEFT / RIGHT

SELECT LEFT('CHARACTER', 5)     --CHARA soldan başlıyor 5 tane getiriyor
SELECT LEFT('CH ARACTER', 5)    --CH AR boşluğu sayar
SELECT RIGHT('CHARACTER', 5)    --ACTER soldan başlıyor 5 tane getiriyor
SELECT RIGHT('CH ARACTER ', 5)  --CTER  boşluğu sayar

--SUBSTRING

SELECT SUBSTRING('CHARACTER', 3, 5)     --ARACT 3ten başlıyor, 5 tane getiriyor
SELECT SUBSTRING('CHARACTER', 0, 5)     -- CHAR 0dan başlıyor, 5 tane getiriyor. boşlukla başlar
SELECT SUBSTRING('CHARACTER', -1, 5)    --  CHA -1den başlıyor, 5 tane getiriyor. boşlukla başlar
SELECT SUBSTRING(888888, 3, 5)          --ERROR sayılarla çalışmıyor.

--LOWER / UPPER

SELECT LOWER('CHARACTER')     --character
SELECT LOWER('cHARACTER')     --character
SELECT UPPER('character')     --CHARACTER
SELECT UPPER('charaCTer')     --CHARACTER

--TITLE gibi yapmak için

SELECT UPPER(LEFT('character',1)) + LOWER(RIGHT('character',LEN('character')-1))  --Character

--TRIM

SELECT TRIM('   CHARACTER   ')     --CHARACTER kenardaki boşlukları temizler
SELECT TRIM('   CHARA CTER  ')     --CHARA CTER kenardaki boşlukları temizler ama içerdekiler aynı kalır

-- seçili karakterleri silmek için '?, ' boşluk ( ) yazmak zorundayız !!

SELECT TRIM('?, ' FROM '   ?SQL Server,') AS TrimmedString;

SELECT LTRIM('   CHARACTER   ')     --CHARACTER     sol kenardaki boşlukları temizler
SELECT RTRIM('   CHARACTER   ')     --    CHARACTER sağ kenardaki boşlukları temizler

-- REPLACE

SELECT REPLACE('CHARACTER STRING', ' ', '/')    --CHARACTER/STRING boşluk yerine / replace ediyoruz
SELECT REPLACE(12345, 2, '*')                   --1*345 rakamlarla da çalışır. şifreleme için kullanılarabilir.

--CAST

SELECT 1 + 1
SELECT 1 + '1'

SELECT CAST(12345 AS CHAR)       --12345 karakter olarak çıktı verir
SELECT CAST(123.95 AS INT)       --123   sadece int olanları verir
SELECT CAST(123.95 AS DEC(3,0))  --124   yuvarlayarak veriyor. int öyle değildi

---CONVERT

SELECT CONVERT(int, 30.60)                  --30 sadece int kısmı alıyor
SELECT CONVERT(VARCHAR(10), '2020-10-10')   --2020-10-10 str olarak getirdi, saat filan yok.
SELECT CONVERT(DATETIME, '2020-10-10')      --2020-10-10 00:00:00.000  date olarak geldi.

--*** CONCANT soru üzerine

SELECT first_name + ' ' + last_name AS full_name
FROM sale.customer


--SQL Server Datetime Formatting
--Converting a Datetime to a Varchar

SELECT CONVERT(VARCHAR, GETDATE(), 7)           --Jan 14, 23
SELECT CONVERT(NVARCHAR, GETDATE(), 100)        --Jan 14 2023 10:30AM
SELECT CONVERT(NVARCHAR, GETDATE(), 112)        --20230114
SELECT CONVERT(NVARCHAR, GETDATE(), 113)        --14 Jan 2023 10:31:01:020

SELECT CAST('20201010' AS DATE)                         --2020-10-10
SELECT CONVERT(NVARCHAR, CAST('20201010' AS DATE), 103) --10/10/2020

--ROUND

SELECT ROUND(123.4567, 2)           --123.4600  2 tane yuvarladı ancak sondakileri silmedi!
SELECT ROUND(123.4567, 2, 0)        --123.4600  son parametre default 0
SELECT ROUND(123.4567, 2, 9)        --123.4500  0dan başka bir şey girersek üste yuvarlamıyor
SELECT ROUND(123.4567, 2, 1)        --123.4500  0dan başka bir şey girersek üste yuvarlamıyor


SELECT CONVERT(INT, 123.4567)            --123       decimal getirmez.
SELECT CONVERT(DECIMAL(18,2), 123.4567)  --123.46    decimal getirir. 
            --DEC(toplam kaç rakam, kaç dec olsun)


--ISNUMERIC

SELECT ISNUMERIC(11111)         -1
SELECT ISNUMERIC('11111')       -1
SELECT ISNUMERIC('clarusway')   -0

--COALESCE 
-- NULL olmayan ilk değeri getirir.

SELECT COALESCE(NULL, 'Hi', 'Hello', NULL) result;              --Hi
SELECT COALESCE(NULL, NULL ,'Hi', 'Hello', NULL) result;        --Hi
SELECT COALESCE(NULL, NULL ,'Hi', 'Hello', 100, NULL) result;   --ERROR arada int var diye. aynı tipler olmalı.
---This function doesn't limit the number of arguments, but they must all be of the same data type.
SELECT COALESCE(NULL, NULL) result;   --en azından bir tane NULL olmayan değer olmalı.

--ISNULL
--NULL ları bulur, yandaki argümanla değiştirir.

SELECT ISNULL(NULL, 1)                  --1
SELECT ISNULL(phone, 'no phone')        --no phone ile değiştirdik.
FROM sale.customer;

---difference between coalesce and isnull
SELECT ISNULL(phone, 0)
FROM sale.customer;                    --0 yaptık

SELECT COALESCE(phone, 0)              --ERROR çünkü COALESCE içinde varchar value ile int var. olmaz
FROM sale.customer;

--NULLIF
--iki argüman eşitse 

SELECT NULLIF(10, 10)
SELECT NULLIF(2, '2')

--değilse ilkini getirir
SELECT NULLIF(10,2)   --10



--How many customers have yahoo mail?

SELECT COUNT(customer_id)
FROM sale.customer
WHERE PATINDEX('%yahoo%', email) > 0