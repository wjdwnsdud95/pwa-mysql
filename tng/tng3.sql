-- 1. 모든 직원의 이름과 입사일을 조회하세요.
SELECT
	`name`
	,hire_at
FROM employees
;

-- 2. 'd005' 부서에 속한 모든 직원의 직원 ID를 조회하세요.
SELECT
	emp_id
	,dept_code
FROM department_emps
WHERE
	dept_code = 'D005'
	AND end_at IS NULL
;

-- 3. 1995년 1월 1일 이후에 입사한 모든 직원의 정보를 입사일 순서대로 정렬하여 조회하세요.
SELECT *
FROM employees
WHERE
	hire_at >= '1995-01-01'
ORDER BY hire_at ASC
;

-- 4. 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서부터 순서대로 보여주세요.
SELECT
	dept_code
	,COUNT(dept_code) dept_count
FROM department_emps
GROUP BY dept_code
ORDER BY dept_count DESC
;

-- 5. 각 직원의 현재 연봉 정보를 조회하세요.
SELECT
	emp_id
	,salary
FROM salaries
WHERE
	end_at IS NULL
;

-- 6. 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
SELECT
	emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps deptemp
		ON emp.emp_id = deptemp.emp_id
		 AND emp.fire_at IS NULL
	JOIN departments dept
		ON deptemp.dept_code = dept.dept_code
			AND dept.end_at IS NULL
;

-- 7. '마케팅부' 부서의 현재 매니저의 이름을 조회하세요.
SELECT
	emp.`name`
	,deptmag.dept_code
	,dept.dept_name
FROM employees emp
	JOIN department_managers deptmag
		ON emp.emp_id = deptmag.emp_id
			AND deptmag.end_at IS NULL
	JOIN departments dept
		ON deptmag.dept_code = dept.dept_code
			AND dept.dept_name = '마케팅부'
;

-- 8. 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT
	emp.`name`
	,emp.gender
	,tit.title
FROM employees emp
	JOIN title_emps titemp
		ON emp.emp_id = titemp.emp_id
			AND emp.fire_at IS NULL
	JOIN titles tit
		ON titemp.title_code = tit.title_code
;

-- 9. 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT
	emp_id
	,salary
FROM salaries
WHERE end_at IS NULL
ORDER BY salary DESC
LIMIT 5
;

-- 10. 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 60000 이상인 부서만 조회하세요.
SELECT
	deptemp.dept_code
	,AVG(salary) avg_salary
FROM salaries sal
	JOIN department_emps deptemp
		ON sal.emp_id = deptemp.emp_id
			AND sal.end_at IS NULL
GROUP BY deptemp.dept_code
	HAVING avg_salary >= 40000000
;

-- 11. 아래 구조의 테이블을 작성하는 SQL을 작성해 주세요.(구조는 문서 참고)
CREATE TABLE users(
	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,`username` VARCHAR(30) NOT NULL
	,authflg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL
	,created_at DATETIME DEFAULT (CURRENT_DATE)
);

-- 12. 11번에서 만든 테이블에 아래 데이터를 입력해 주세요.(데이터는 문서 참고)
INSERT INTO users(
	`username`
	,authflg
	,birthday
	,created_at
)
VALUES(
	'그린'
	,'0'
	,'2024-01-26'
	,NOW()
);

-- 13. 12번에서 만든 레코드를 아래 데이터로 갱신해 주세요.
UPDATE users
SET
	`username` = '테스터'
	,authflg = '1'
	,birthday = '2007-03-01'
WHERE
	userid = 1
;

-- 14. 13번에서 만든 레코드를 삭제해 주세요.
DELETE FROM users
WHERE
	userid = 1
;

-- 15. 12번에서 만든 테이블에 아래 Column을 추가해 주세요.
ALTER TABLE users
ADD COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-'
;

-- 16. 12번에서 만든 테이블을 삭제해 주세요.
DROP TABLE users;

-- 17. 아래 테이블에서 유저명, 생일, 랭크명을 출력해 주세요.(테이블 예시는  문서 참고)

-- users 테이블 생성
CREATE TABLE users(
	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,`username` VARCHAR(30) NOT NULL
	,authflg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL
	,created_at DATETIME DEFAULT (CURRENT_DATE)
);
-- rankmanagement 테이블 생성
CREATE TABLE rankmanagement(
	rankid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,userid INT UNSIGNED NOT NULL
	,`rankname` VARCHAR(30) NOT NULL
);
-- users 데이터 추가
INSERT INTO users(
	`username`
	,authflg
	,birthday
	,created_at
)
VALUES(
	'그린'
	,'0'
	,'2024-01-26'
	,NOW()
);
-- rankmanagement 데이터 추가
INSERT INTO rankmanagement(
	userid
	,`rankname`
)
VALUES(
	'1'
	,'manager'
);
-- rankmanagement 테이블에 컬럼(user_id) FK 추가
ALTER TABLE rankmanagement
	ADD CONSTRAINT fk_rankmanagement_userid
		FOREIGN KEY(userid)
		REFERENCES users(userid)
;

-- 유저명, 생일, 랭크명 불러오기
SELECT
	uses.username
	,uses.birthday
	,rankt.rankname
FROM users uses
	JOIN rankmanagement rankt
	 ON uses.userid = rankt.userid
;