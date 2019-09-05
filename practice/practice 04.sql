-- practice04

-- 문제1) 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(emp_no)
from salaries 
where to_date = '9999-01-01'
and salary > (select avg(salary)
				from salaries
				where to_date='9999-01-01'
);

-- 문제 2)현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요.
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select a.emp_no as 사번 ,concat(a.first_name,' ',a.last_name) as 이름,c.dept_name as 부서 ,d.salary as 연봉 
from employees a, dept_emp b, departments c, salaries d 
where a.emp_no = b.emp_no
and b.dept_no =c.dept_no
and a.emp_no =d.emp_no
and b.to_date = '9999-01-01'
and d.to_date = '9999-01-01'
and (d.salary,b.dept_no) in (select max(b.salary) ,c.dept_no as dept_no
							 from employees a, salaries b, dept_emp c
						     where a.emp_no =b.emp_no
                             and a.emp_no =c.emp_no
							 and b.to_date = '9999-01-01'
							 and c.to_date = '9999-01-01'
							 group by dept_no)
order by d.salary desc;

-- 문제 3)현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select a.emp_no as 사번 ,concat(a.first_name,' ',a.last_name) as 이름, b.salary as 연봉
from employees a, salaries b, dept_emp c, departments d, (select b.dept_no , avg(a.salary) as 평균급여
															from salaries a, dept_emp b, employees c
															where a.emp_no =c.emp_no
                                                            and c.emp_no =b.emp_no
															and a.to_date = '9999-01-01'
															and b.to_date ='9999-01-01'
                                                            group by b.dept_no)e
where a.emp_no =b.emp_no
and a.emp_no =c.emp_no
and c.dept_no =d.dept_no
and c.dept_no = e.dept_no
and b.to_date='9999-01-01'
and c.to_date='9999-01-01'
and e.평균급여 < b.salary; 




-- 문제 4)현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no as 사번 ,concat(a.first_name,' ',a.last_name) as 이름, d.manager ,c.dept_name as 부서이름
from employees a,dept_emp b, departments c, (select a.dept_no as dept_no,concat(b.first_name,' ',b.last_name) as manager
													from dept_manager a, employees b
                                                    where a.emp_no=b.emp_no
                                                    
                                                    and a.to_date ='9999-01-01')d
where a.emp_no =b.emp_no
and b.dept_no =c.dept_no
and b.dept_no =d.dept_no 
and b.to_date ='9999-01-01';

-- 문제 5)현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select  a.emp_no as 사번 ,concat(a.first_name,' ',a.last_name) as 이름, b.title as 직책 , c.salary as 연봉 
from  employees a, titles b, salaries c,dept_emp d
where a.emp_no =b.emp_no
and a.emp_no = c.emp_no
and a.emp_no =d.emp_no
and b.to_date ='9999-01-01'
and c.to_date ='9999-01-01'
and d.to_date ='9999-01-01'
and d.dept_no =(select  c.dept_no  
				from  employees a,salaries b, dept_emp c
				where a.emp_no = b.emp_no
				and a.emp_no =c.emp_no
				and b.to_date = '9999-01-01'
				and c.to_date = '9999-01-01'
				group by c.dept_no
				order by avg(b.salary) desc
				limit 0,1);



-- 문제 6)평균 연봉이 가장 높은 부서는?
select  d.dept_name as '평균연봉이 가장 높은 부서'
from  departments d
where dept_no = (select c.dept_no
				from employees a, salaries b, dept_emp c
                where a.emp_no =b.emp_no
				and a.emp_no =c.emp_no
				group by c.dept_no
                order by avg(b.salary) desc
				limit 0,1);
	

-- 문제 7)평균 연봉이 가장 높은 직책?
select d.title
from employees a, salaries b, dept_emp c,titles d
where a.emp_no =b.emp_no
and a.emp_no =c.emp_no
and a.emp_no =d.emp_no
group by title
order by avg(b.salary) desc
limit 0,1;


-- 문제 8)현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name as 부서이름 ,concat(a.first_name,' ',a.last_name) as 이름, b.salary as 연봉, e.manager as 매니저이름, e.연봉 as 매니저연봉 
from employees a, salaries b, dept_emp c, departments d, (select a.dept_no as dept_no, c.salary as 연봉 ,concat(b.first_name,' ',b.last_name) as manager
													from dept_manager a, employees b,salaries c
                                                    where a.emp_no=b.emp_no
                                                    and b.emp_no =c.emp_no
                                                    and a.to_date ='9999-01-01'
                                                    and c.to_date ='9999-01-01')e
where a.emp_no =b.emp_no
and a.emp_no=c.emp_no
and c.dept_no=d.dept_no
and c.dept_no= e.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and b.salary > e.연봉;














