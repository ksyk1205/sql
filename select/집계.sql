SELECT 
    AVG(salary), SUM(salary)
FROM
    salaries
WHERE
    emp_no = '10060';

SELECT 
    emp_no, AVG(salary) AS avg_salary, SUM(salary)
FROM
    salaries
WHERE
    to_date = '9999-01-01'
GROUP BY emp_no
HAVING AVG(salary) > 40000
ORDER BY AVG(salary) ASC;

-- ex1) 각 사원별로 평균 연봉 출력
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
ORDER BY AVG(salary) DESC;

-- ex2) [과제] 각 현재 Manager 직책 사원에 대한 평균 연봉은?
SELECT 
    AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND b.title = 'Manager';

-- ex2-1) [과제] 각 현재 직책 별 평균 연봉은?
SELECT 
    b.title, AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(a.salary) DESC;

-- ex3) 사원별 몇 번의 직책 변경이 있었는지 조회
SELECT 
    emp_no, COUNT(*)
FROM
    titles
GROUP BY emp_no
ORDER BY COUNT(*) DESC;

SELECT 
    *
FROM
    titles
WHERE
    emp_no = '204120';

-- ex4) 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 50000
ORDER BY AVG(salary) ASC;

-- ex5 [과제] 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
SELECT 
    b.title AS 직책,
    AVG(a.salary) AS 평균연봉,
    COUNT(b.emp_no) AS 인원수
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING COUNT(b.emp_no) >= 100;

-- ex6 [과제] 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
SELECT 
    c.dept_name AS 부서,
    a.title AS 직책,
    AVG(b.salary) AS 평균급여
FROM
    titles a,
    salaries b,
    departments c,
    dept_emp d
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = d.emp_no
        AND d.dept_no = c.dept_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND a.title = 'Engineer'
GROUP BY c.dept_name;




-- ex7 [과제] 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요
--  		단, 총합이 2000000000이상인 직책만 나타내며 급여 총합에 대해서 내림차순으로 정렬하세요.

SELECT 
    a.title, SUM(b.salary)
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND a.title != 'Engineer'
GROUP BY a.title
HAVING SUM(b.salary) > 2000000000
ORDER BY SUM(b.salary) DESC;

