CREATE TABLE department
(
id BIGINT,
name VARCHAR(20),
dept_name VARCHAR(20),
seniority VARCHAR(20),
graduation CHAR (3),
salary BIGINT,
hire_date DATE
);



INSERT department VALUES
 (10238,  'Eric'    , 'Economics'        , 'Experienced'  , 'MSc'      ,   72000 ,  '2019-12-01')
,(13378,  'Karl'    , 'Music'            , 'Candidate'    , 'BSc'      ,   42000 ,  '2022-01-01')
,(23493,  'Jason'   , 'Philosophy'       , 'Candidate'    , 'MSc'      ,   45000 ,  '2022-01-01')
,(36299,  'Jane'    , 'Computer Science' , 'Senior'       , 'PhD'      ,   91000 ,  '2018-05-15')
,(30766,  'Jack'    , 'Economics'        , 'Experienced'  , 'BSc'      ,   68000 ,  '2020-04-06')
,(40284,  'Mary'    , 'Psychology'       , 'Experienced'  , 'MSc'      ,   78000 ,  '2019-10-22')
,(43087,  'Brian'   , 'Physics'          , 'Senior'       , 'PhD'      ,   93000 ,  '2017-08-18')
,(53695,  'Richard' , 'Philosophy'       , 'Candidate'    , 'PhD'      ,   54000 ,  '2021-12-17')
,(58248,  'Joseph'  , 'Political Science', 'Experienced'  , 'BSc'      ,   58000 ,  '2021-09-25')
,(63172,  'David'   , 'Art History'      , 'Experienced'  , 'BSc'      ,   65000 ,  '2021-03-11')
,(64378,  'Elvis'   , 'Physics'          , 'Senior'       , 'MSc'      ,   87000 ,  '2018-11-23')
,(96945,  'John'    , 'Computer Science' , 'Experienced'  , 'MSc'      ,   80000 ,  '2019-04-20')
,(99231,  'Santosh'	,'Computer Science'  ,'Experienced'   ,'BSc'       ,  74000  , '2020-05-07' )
;

SELECT *
FROM department;

SELECT DISTINCT dept_name
FROM department;

SELECT DISTINCT TOP 3 *
FROM department
WHERE dept_name IN ('Computer Science', 'Music');            --- be careful IN and NOT IN works for OR not AND!!

SELECT *
FROM department
WHERE dept_name IN ('Economics', 'Computer Science', 'Psychology', 'Political Science');

SELECT *
FROM department
WHERE dept_name
NOT IN ('Economics', 'Computer Science', 'Physics');


SELECT *
FROM department
WHERE salary BETWEEN 80000 AND 90000;    --- BETWEEN inclusive !!

SELECT *
FROM department
WHERE salary NOT BETWEEN 80000 AND 90000;

SELECT *
FROM department
WHERE hire_date BETWEEN '2018-06-01' AND '2019-03-31'        --- tarihlerde de kullanılır ancak '' içine almak ve 'YYYY-MM-DD' olmalı.
ORDER BY hire_date;

SELECT *
FROM department
WHERE name LIKE 'J%';

SELECT *
FROM department
WHERE name LIKE 'El_is';

SELECT *
FROM department
WHERE name LIKE '%vi%';

SELECT COUNT (name) AS num_of_emp   --- count (*) illa ki bir col name olmalı
FROM department;

SELECT COUNT(DISTINCT seniority)    --- DISTINCT atılabilir
FROM department;

SELECT COUNT(*) AS count_of_employees   ----WHERE ile birlikte kullanılabilir
FROM department
WHERE seniority = 'Experienced';

SELECT TOP 1 salary AS highest_salary
FROM department
WHERE seniority = 'Candidate'
ORDER BY salary DESC;

--- date order da newest MAX, first MIN ile seçilebilir.

SELECT SUM(salary) AS total_salary
FROM department
WHERE seniority = 'Experienced';

SELECT AVG(salary) AS average_salary
FROM department
WHERE dept_name = 'Computer Science';


--- GROUP BY ile neyi grupluyorsak onu SELECT ile vermek zorunda değiliz, ancak SELCT te agg func olmayan ne varsa GROUP BY da olmak zorunda

SELECT seniority, COUNT(id) AS count_of_emp 
FROM department
GROUP BY seniority, dept_name;

SELECT * FROM department

SELECT dept_name, COUNT(id) count_of_exc_emp
FROM department
WHERE seniority= 'Experienced'
GROUP BY dept_name;

SELECT dept_name, COUNT(id) count_of_non_exc_emp
FROM department
WHERE seniority <> 'Experienced'
GROUP BY dept_name;

SELECT seniority, AVG(salary) AS avg_salary
FROM department
GROUP BY seniority
ORDER BY AVG(salary) DESC;

SELECT dept_name, MIN(salary) AS min_salary
FROM department
GROUP BY dept_name
ORDER BY MIN(salary) DESC;

SELECT dept_name, MAX(salary) AS max_salary
FROM department
GROUP BY dept_name
ORDER BY MAX(salary) DESC;

SELECT dept_name, MAX(salary) AS max_salary
FROM department
GROUP BY dept_name
ORDER BY max_salary DESC;        --- ORDER BY SELECT sonrasında geldiği için alias ları ORDER BY için kullanabiliriz.

SELECT dept_name, COUNT(id) AS num_of_emp
FROM department
GROUP BY dept_name;

SELECT seniority, SUM(salary) AS sum_salary
FROM department
GROUP BY seniority;

SELECT seniority, AVG(salary) AS avg_salary
FROM department
GROUP BY seniority
ORDER BY avg_salary DESC;