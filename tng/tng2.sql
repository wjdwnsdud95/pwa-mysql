-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,tite.title_code
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
			AND tite.end_at IS NULL
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
ORDER BY sal.salary ASC
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
-- 현업에서는 데이터가 정리되어 있지 않아 ORDER BY 사용하여 정렬 필수
SELECT
	emp.`name`
	,sal.start_at
	,sal.end_at
   ,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
ORDER BY sal.start_at ASC
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps depemp
		ON emp.emp_id = depemp.emp_id
			AND depemp.end_at IS NULL
	JOIN departments dept
		ON depemp.dept_code = dept.dept_code
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
-- 	RANK() OVER(ORDER BY sal.salary DESC) AS sal_rank
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
			AND sal.end_at IS NULL
			AND emp.fire_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;

-- 5-2. 서브 쿼리 추가 버전
-- 쿼리를 불러오는 시간을 줄이기 위해 서브 쿼리 이용
SELECT
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			,sal.salary
		FROM salaries sal
		WHERE
			sal.end_at IS NULL
		ORDER BY sal.salary DESC
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
ORDER BY tmp_sal.salary DESC
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	depa.dept_name
	,emp.`name`
	,emp.hire_at
FROM department_managers depamanager
	JOIN departments depa
		ON depamanager.dept_code = depa.dept_code
			AND depamanager.end_at IS NULL
	JOIN employees emp
		ON depamanager.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
ORDER BY depa.dept_code ASC
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	tite.title
	,AVG(sal.salary)
FROM titles tite
	JOIN title_emps titemp
		ON tite.title_code = titemp.title_code
			AND tite.title = '부장'
			AND titemp.end_at IS NULL
	JOIN salaries sal
		ON titemp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;

-- 현재 각 부장별 이름, 연봉평균
SELECT
	tite.title
	,emp.`name`
	,AVG(sal.salary)
FROM titles tite
	JOIN title_emps titemp
		ON tite.title_code = titemp.title_code
			AND tite.title = '부장'
			AND titemp.end_at IS NULL
	JOIN employees emp
		ON titemp.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
GROUP BY emp.`name`, emp.emp_id
;

-- GROUP BY 표준 문법 어긋나지 않은 강사님 방식
SELECT
	emp.`name`
	,sub_salaries.avg_sal
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			,AVG(sal.salary) avg_sal
		FROM title_emps tite
			JOIN titles tit
				ON tite.title_code = tit.title_code
					AND tit.title = '부장'
					AND tite.end_at IS NULL
			JOIN salaries sal
				ON sal.emp_id = tite.emp_id
					AND sal.end_at IS NULL
		GROUP BY sal.emp_id
	) sub_salaries
		ON emp.emp_id = sub_salaries.emp_id
			AND emp.fire_at IS NULL
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,depm.dept_code
FROM department_managers depm
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT
	tite.title
-- 	,AVG(CEILING(sal.salary)) avg_sal
	,CEILING(AVG(sal.salary)) avg_sal
FROM titles tite
	JOIN title_emps titemp
		ON tite.title_code = titemp.title_code
			AND titemp.end_at IS NULL
	JOIN salaries sal
		ON titemp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
-- 		평균함수가 적용되지 않은
-- 		각 사원 개인이 가진 연봉을 가져옴
-- 			AND sal.salary >= 60000000
GROUP BY tite.title
	HAVING avg_sal >= 60000000
ORDER BY avg_sal DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	emp.gender
	,titemp.title_code
	,tit.title
	,COUNT(*) cnt_f_emp
FROM employees emp
	JOIN title_emps titemp
		ON emp.emp_id = titemp.emp_id
			AND emp.fire_at IS NULL
			AND titemp.end_at IS NULL
-- 			AND emp.gender = 'F'
	JOIN titles tit
		ON tit.title_code = titemp.title_code
GROUP BY titemp.title_code, emp.gender
ORDER BY titemp.title_code ASC, emp.gender ASC
;