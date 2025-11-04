-- JOIN문
-- 두개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력

-- INNER JOIN
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력

-- 전 사원의 사번, 이름, 현재 급여를 출력
-- INNER JOIN에서 INNER를 생략하고 JOIN만 입력해도 INNER JOIN으로 인식한다.
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
ORDER BY emp.emp_id ASC
;

-- 재직중인 사원의 사번, 이름, 생일, 부서명
SELECT
	depe.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM department_emps depe
	JOIN departments dept
		ON depe.dept_code = dept.dept_code
			AND depe.end_at IS NULL
	JOIN employees emp
		ON depe.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
;

-- LEFT JOIN
SELECT
	emp.*
	,sal.*
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;


-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION (중복 레코드 제거)
-- UNION ALL (중복 레코드 제거 안함)
SELECT * FROM employees WHERE emp_id IN(1, 3)
UNION
-- UNION ALL
SELECT * FROM employees WHERE emp_id IN(3, 6)
;

-- SELF JOIN
-- 같은 테이블 끼리 JOIN
SELECT
	emp.emp_id AS junior_id
	,emp.`name` AS junior_name
	,supemp.emp_id AS supervisor_id
	,supemp.`name` AS supervisor_name
FROM employees emp
	JOIN employees supemp
		ON emp.sup_id = supemp.emp_id
			AND emp.sup_id IS NOT NULL
;