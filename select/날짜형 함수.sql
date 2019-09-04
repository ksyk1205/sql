-- curdate(), current_date => yyyy, MM, dd
SELECT CURDATE(), CURRENT_DATE;

-- curtime(), current_time => hh, mm, ss
SELECT CURTIME(), CURRENT_TIME;

-- now(), sysdate(), current_timestamp() =>yyyy, MM, dd, hh, mm, ss
SELECT NOW(), SYSDATE(), CURRENT_TIMESTAMP();

-- now() : 쿼리가 실행하기 전에
-- sysdate() : 쿼리가 실행되면서
SELECT NOW(), SLEEP(2), NOW();
SELECT NOW(), SLEEP(2), SYSDATE();

-- date_format
SELECT 
    DATE_FORMAT(NOW(),
            '%Y년 %m월 %d일 %h시 %i분 %s초');
SELECT DATE_FORMAT(SYSDATE(), '%y-%c-%e %h:%i:%s');

-- period_diff(p1,p2)
-- : YYMM, YYYYMM으로 표기되는 p1과 p2의 차이의 개월을 반환한다.
-- ex) 직원들의 근무 개월 수 구하기
SELECT 
    CONCAT(first_name, ' ', last_name) AS name,
    PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'),
            DATE_FORMAT(hire_date, '%Y%m'))
FROM employees;

-- date_add = adddate
-- date_sub = subdate
-- (date, INTERVAL expr type)
-- : 날짜 date에 type형식(year,month,day)으로 지정한 expr값을 더하거나 뺀다.
-- ex) 각 직원들의 6개월 후 근무 평가일
SELECT 
    CONCAT(first_name, ' ', last_name) AS name,
    hire_date,
    date_add(hire_date, INTERVAL 6 MONTH)
FROM employees;

-- cast
select now(),cast(now() as date),cast(now() as datetime);

select 1-2, cast(1-2 as unsigned);

select cast(cast(1-2 as unsigned)as signed);