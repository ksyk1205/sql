-- ANSI JOIN 1999

-- 1.join ~ on 
select a.first_name,b.title
from employees a
join titles b
on a.emp_no = b.emp_no;

-- 2.natural join
select a.first_name,b.title
from employees a
natural join titles b;

-- 2-1natural join의 문제점
select count(*)
from salaries a
natural join titles b;

-- 2-2 join~using => natural join의 문제점  해결
select count(*)
from salaries a
 join titles b using(emp_no);

 
