-- 1)현재 회사 상황을 반영한 직원별 근무부서를 사번, 직원 전체이름, 근무부서 형태로 출력해보세요
SELECT 
    a.emp_no AS '사번',
    CONCAT(a.first_name, ' ', a.last_name) AS '전체이름',
    c.dept_name AS '근무부서'
FROM
    employees a,
    dept_emp b,
    departments c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND b.to_date = '9999-01-01';


-- 2)현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요. 사번 ,전체이름, 연봉 이런형태로 출력하세요.
SELECT 
    a.emp_no AS '사번',
    CONCAT(a.first_name, ' ', a.last_name) AS '전체이름',
    b.salary AS '연봉'
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
ORDER BY b.salary DESC;
