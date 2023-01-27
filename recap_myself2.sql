-------- BUILT IN FUNC --------

--------

SELECT GETDATE() AS now;

SELECT DATENAME(WEEKDAY, '2020-08-21') AS sample;

SELECT DATEPART(MINUTE, GETDATE()) AS sample;

SELECT DATEPART(DAY, 2020-08-21) --- olmaz /
SELECT DAY('2020-08-21');
SELECT MONTH('2020-08-21');
SELECT YEAR('2020-08-21');

SELECT DATEDIFF(week, '2021-01-01', '2021-02-12') AS DateDifference;

SELECT DATEADD (SECOND, 1, '2021-12-31 23:59:59') AS NewDate;

SELECT DATEDIFF(YEAR, '1991-12-26', GETDATE()) AS my_age;

SELECT EOMONTH(GETDATE()) AS end_of_this_month;



-------- STR FUNC --------

SELECT LEN('this is an example')

SELECT LEN('this is an example  '); -- ikisi de aynı sonucu verdi çünkü sondaki boşluğu saymaz, ortalardaki boşluğu sayar

SELECT LEN(NULL) AS col1, LEN(10) AS col2, LEN(10.5) AS col3 --- int değerler de str içinde gibi değerlendirilir. 10.5 4 karakterdir

SELECT CHARINDEX('yourself', 'Reinvent yourself') AS start_position; -- CHARINDEX nerde başladığını 1den başlyarak sayıyor. y 10. sırada

SELECT CHARINDEX('r', 'Reinvent yourself') AS motto;

SELECT CHARINDEX('self', 'Reinvent yourself and ourself', 15) AS motto;   --- nerden itibaren sayacağını belirleyebiliyoruz. o yüzden ilkini saymıyor.

SELECT PATINDEX('%is%', 'this is not a pattern') AS sample   --- sadece sonda % kullanmıyoruz  --- her zaman ilkini sayar, sonrakiler önemli değil

SELECT SUBSTRING('clarusway.com', LEN('clarusway.com')-1, LEN('clarusway.com')); -- SUBSTRING 12den başlıyor 14 tane gidiyor, slcing gibi

SELECT SUBSTRING('clarusway.com', 5,3) --usw

SELECT value from STRING_SPLIT('John,is,a,very,tall,boy.', ','); -- STRING_SPLIT ile istediğimiz ayracı kullanacak string i satılara bölebiliriz.

SELECT SUBSTRING('clarusway.com', 5,3) --usw

SELECT SUBSTRING('Clarusway', -5, 7) AS substr  ----!! burdaki indexleme -5 olursa 1den başlar, ancak kaç tane alacağı değişmez

SELECT SUBSTRING('Clarusway', -3, 5) AS substr

SELECT LEFT('Clarusway', 2) AS leftchars -- Cl burda soldan başlar

SELECT RIGHT('Clarusway', 2) AS leftchars -- ay burda sağdan başlar, ama ters gitmez

SELECT CHARINDEX('.','clarusway.com'); --- . 10. karakterde, burası integer 10 getirir.

SELECT SUBSTRING('clarusway.com', 0 , CHARINDEX('.','clarusway.com')); --- clarusway 0dan başladığı için 1 tane boşa gider eldeki 9 da clarusway i getirir. 

SELECT UPPER(SUBSTRING('clarusway.com', 0 , CHARINDEX('.','clarusway.com'))); --- CLARUSWAY upper case çalışır

SELECT TRIM('@' FROM '@@@clarusway@@@@') AS new_string; --- clarusway @ leri siler

SELECT LTRIM('   cadillac') AS new_string; --- boşukları soldan siler 

SELECT RTRIM('   cadillac   ') AS new_string; --- boşlukları sağdan siler, öndeki boşlukşar halen kalır.

SELECT TRIM(' 789Sun is shining789   ');   --default olarak baştaki ve sondaki boşlukları siler

SELECT REPLACE('I do it my way.','do','did') AS song_name; -- do yerine did gelir. replace işte

SELECT STR(123.45, 3, 1) AS num_to_str; --- 123.5 yani . da sayılır, önce soldan saymaya başlar sonra istenen kadar decimal getirir.

SELECT STR(FLOOR (123.45), 8, 3) AS num_to_str; --- 123.0000

SELECT 'Reinvent' + ' yourself' AS concat_string;  --- + stringleri birleştirir

SELECT CONCAT('Reinvent' , ' yourself') AS concat_string; --- CONCAT da aynı

SELECT REPLACE ((TRIM(' Reinvent $Yourself! ')), '$', '')

SELECT 'customer' + '_' + CAST(10 AS VARCHAR(3)) AS col;

SELECT GETDATE() AS current_datee;

SELECT CONVERT(DATE, GETDATE()) AS current_datee;

SELECT GETDATE() AS current_datee, CONVERT(DATE, GETDATE()) AS current_datee;

SELECT GETDATE() AS curent_time, CONVERT(NVARCHAR, GETDATE(), 6)AS curent_date -- 6 burda tarih formatı

SELECT ROUND(123.9994, 3) AS col1, ROUND(123.9995, 3) AS col2; -- ROUND burda yukarı yuvarlıyor.

SELECT ROUND(123.4545, 2) col1, ROUND(123.45, -2) AS col2; -- 100.00 decimal ileri gidebildiği gibi geri de gidebilir -2 ile

SELECT ROUND(150.75, 0) AS col1, ROUND(150.75, 0, 1) AS col2;

SELECT ISNULL(NULL, 5) AS col;   -- 5,  NULL ise yerine replace yapar değilse bi şey yapmaz

SELECT ISNULL(1, 2) AS col;   -- 1

-- AS numeric AS decimal veya STR hepsi aynı aslında, kaç  karakter olacağını ve kaç tanesinin decimal olacağını veriyoruz. ROUND ise sadece decimal kısmı yuvarlama yapıyor

    SELECT CAST(1034.845299 AS decimal(7,3))

    SELECT CAST(1034.845299 AS NUMERIC(7,3))

    SELECT STR(1034.845299,18,5)

SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');   --- birleştirirken ilk NULL olmayanı getirdi.

SELECT NULLIF(1, 3) AS col, NULLIF(3, 3) AS col    --- 1  NULL aynı ise NULL getirir değilse ilkini getirir

SELECT COALESCE(NULLIF(ISNUMERIC(STR(12255.212, 7)), 1), 9999);   --- STR(123, 6) olursa sadece tam sayı kısmını alır. o da numeric olur.

-------- Check Yourself -12 de kaldım